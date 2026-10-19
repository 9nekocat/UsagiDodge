-- 仅当从 VSCode 调试会话（.vscode/launch.json 里的 "Usagi: Dev(调试)"）启动时，
-- 才加载 lldebugger 以启用断点/单步/变量查看。
-- 普通 `usagi dev`、`usagi run` 和导出后的游戏都不会执行这段代码。
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" and not package.loaded["lldebugger"] then
  local lldbgPath = os.getenv("USAGI_LLDBG_PATH") or ".vscode/lldebugger.lua"
  package.loaded["lldebugger"] = assert(loadfile(lldbgPath))()
  require("lldebugger").start()
end

----- 游戏逻辑：移动角色，躲避从屏幕外飞来的子弹

local PLAYER_SIZE = 16
local PLAYER_SPEED = 100
-- 与 sprites.png 里子弹精灵的 16x16 保持一致：绘制、移动、圆心补偿都用它
local BULLET_SIZE = 16
local BULLET_COLLISION_SIZE = 12
local BULLET_SPEED = 200
local BULLET_INTERVAL = 1
-- 子弹在屏幕外多远处生成
local SPAWN_MARGIN = 16
-- 飞出这个外扩范围才回收（必须明显大于 SPAWN_MARGIN）
local RECYCLE_MARGIN = 48

local GAME_STATE = {
  PLAYING = 1,
  GAME_OVER = 2,
}
local SCORE_INTERVAL = 1.2

function _init()
  -- 实时重载在保存编辑时会保留全局变量，但会重置局部变量。
  -- 将可变的游戏状态存储在大写的全局变量中，例如 `State`，这样它
  -- 可以在重载后保留；按 F5 会再次调用 _init 来重置。
  State = {
    player = {
      -- 出生在屏幕正中
      position = {
        x = (usagi.GAME_W - PLAYER_SIZE) / 2,
        y = (usagi.GAME_H - PLAYER_SIZE) / 2,
      },
      sprite = 1,
    },
    bullets = {},
    game_state = GAME_STATE.PLAYING,
    -- 放置子弹的计时器
    bullet_timer = 0,
    -- 分数
    score = 0,
    score_timer = 0,
    best_score = 0,
  }
  local t = usagi.load()
  if t then
    State.best_score = t[1] or 0
  end
end

function _update(dt)
  if State.game_state == GAME_STATE.GAME_OVER then
    -- 结束画面：按确认键重开一局
    if input.pressed(input.BTN1) then
      _init()
    end
    return
  end

  -- 游戏输入只在玩家Playing时
  local dx, dy = 0, 0
  if input.held(input.LEFT) then
    dx = dx - 1
  end
  if input.held(input.RIGHT) then
    dx = dx + 1
  end
  if input.held(input.UP) then
    dy = dy - 1
  end
  if input.held(input.DOWN) then
    dy = dy + 1
  end
  -- 归一化：斜向移动不会比直向更快；无输入时返回 (0, 0)
  local dir = util.vec_normalize({ x = dx, y = dy })
  local pos = State.player.position
  pos.x = pos.x + dir.x * PLAYER_SPEED * dt
  pos.y = pos.y + dir.y * PLAYER_SPEED * dt
  -- 限制在屏幕内，避免走出画面
  pos.x = util.clamp(pos.x, 0, usagi.GAME_W - PLAYER_SIZE)
  pos.y = util.clamp(pos.y, 0, usagi.GAME_H - PLAYER_SIZE)
  -- 回收区域：屏幕四周各外扩 RECYCLE_MARGIN
  local recycle_rect = {
    x = -RECYCLE_MARGIN,
    y = -RECYCLE_MARGIN,
    w = usagi.GAME_W + RECYCLE_MARGIN * 2,
    h = usagi.GAME_H + RECYCLE_MARGIN * 2,
  }

  -- 子弹更新
  for i = #State.bullets, 1, -1 do
    local bullet = State.bullets[i]
    bullet.position.x = bullet.position.x + bullet.direction.x * BULLET_SPEED * dt
    bullet.position.y = bullet.position.y + bullet.direction.y * BULLET_SPEED * dt

    -- position 是精灵左上角，圆碰撞需要圆心
    local b_col = {
      x = bullet.position.x + BULLET_SIZE / 2,
      y = bullet.position.y + BULLET_SIZE / 2,
      r = BULLET_COLLISION_SIZE / 2,
    }

    local p_col = { x = pos.x, y = pos.y, w = PLAYER_SIZE, h = PLAYER_SIZE }
    if util.circ_rect_overlap(b_col, p_col) then
      -- 玩家死亡：GameOver 会清空子弹，这里直接结束本帧
      GameOver()
      return
    end

    -- 完全飞出回收区域才删除（注意是 not：相交说明还在场内）
    if not util.circ_rect_overlap(b_col, recycle_rect) then
      table.remove(State.bullets, i)
    end
  end

  State.bullet_timer = State.bullet_timer + dt
  if State.bullet_timer >= BULLET_INTERVAL then
    -- 取余保留余数，实际射速不会被帧时间向上取整拉长
    State.bullet_timer = State.bullet_timer % BULLET_INTERVAL
    PlaceBullets()
  end

  State.score_timer = State.score_timer + dt
  if State.score_timer >= SCORE_INTERVAL then
    State.score_timer %= SCORE_INTERVAL
    State.score += 1
  end
end

function _draw()
  gfx.clear(gfx.COLOR_DARK_BLUE)
  gfx.spr(State.player.sprite, State.player.position.x, State.player.position.y)

  for _, bullet in ipairs(State.bullets) do
    gfx.spr(3, bullet.position.x, bullet.position.y)
  end

  if State.game_state == GAME_STATE.GAME_OVER then
    TextAnchorCenter("游戏结束！！！", usagi.GAME_W / 2, usagi.GAME_H / 2, gfx.COLOR_RED)
    local restart_key = input.mapping_for(input.BTN1) or "Z"
    TextAnchorCenter("按 " .. restart_key .. " 重新开始", usagi.GAME_W / 2, usagi.GAME_H / 2 + 20, gfx.COLOR_WHITE)
  end

  TextAnchorCenter(tostring(State.score), usagi.GAME_W / 2, usagi.GAME_H / 4, gfx.COLOR_ORANGE)
  if State.game_state == GAME_STATE.GAME_OVER then
    TextAnchorCenter("历史最高:"..tostring(State.best_score), usagi.GAME_W / 2, usagi.GAME_H / 4 - 20, gfx.COLOR_WHITE)
  end
end

-- 子弹放置
function PlaceBullets()
  local pos = State.player.position
  local player_center = { x = pos.x + PLAYER_SIZE / 2, y = pos.y + PLAYER_SIZE / 2 }

  -- 在屏幕四条边外侧随机取一个生成点，保证子弹总是从画面外飞进来
  local spawn
  local side = math.random(4)
  if side == 1 then
    spawn = { x = -SPAWN_MARGIN, y = math.random(0, math.floor(usagi.GAME_H)) }
  elseif side == 2 then
    spawn = { x = usagi.GAME_W + SPAWN_MARGIN, y = math.random(0, math.floor(usagi.GAME_H)) }
  elseif side == 3 then
    spawn = { x = math.random(0, math.floor(usagi.GAME_W)), y = -SPAWN_MARGIN }
  else
    spawn = { x = math.random(0, math.floor(usagi.GAME_W)), y = usagi.GAME_H + SPAWN_MARGIN }
  end

  -- 朝向玩家中心
  local dir = util.vec_normalize({
    x = player_center.x - spawn.x,
    y = player_center.y - spawn.y,
  })
  State.bullets[#State.bullets + 1] = { position = spawn, direction = dir }
end

-- GameOver
function GameOver()
  State.game_state = GAME_STATE.GAME_OVER
  -- 清空子弹，避免画面定格在半空中
  State.bullets = {}
  effect.hitstop(0.1)
  effect.screen_shake(0.5, 4)
  effect.flash(0.5, gfx.COLOR_RED)

  -- 记录玩家的分数
  if State.score > State.best_score then
    State.best_score = State.score
  end
  usagi.save({ State.best_score })
end

----- util ------

-- 以 (x, y) 为中心绘制文字
---@param text string
---@param x number
---@param y number
---@param color number
function TextAnchorCenter(text, x, y, color)
  -- 用引擎实测的文字尺寸居中，中文等宽字体不能用“字数 × 固定字宽”估算
  local w, h = usagi.measure_text(text)
  gfx.text(text, x - w / 2, y - h / 2, color)
end
