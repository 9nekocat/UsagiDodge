-- 仅当从 VSCode 调试会话（.vscode/launch.json 里的 "Usagi: Dev(调试)"）启动时，
-- 才加载 lldebugger 以启用断点/单步/变量查看。
-- 普通 `usagi dev`、`usagi run` 和导出后的游戏都不会执行这段代码。
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" and not package.loaded["lldebugger"] then
  local lldbgPath = os.getenv("USAGI_LLDBG_PATH") or ".vscode/lldebugger.lua"
  package.loaded["lldebugger"] = assert(loadfile(lldbgPath))()
  require("lldebugger").start()
end


-- 游戏本体部分

local PLAYER_SIZE = 16
local PLAYER_SPEED = 200      -- px/s
local ENEMY_R = 8
local SPAWN_DELAY = 0.5       -- s

function _init()
  State = {
    player = { x = 20, y = 80 },
    enemies = {},
    spawn_timer = 0,
    play_time = 0,
    best = State and State.best or 0,   -- 硬重置时保留最高分
    game_over = false,
  }
end

function _update(dt)
  -- 结束状态：等 BTN1 重开
  if State.game_over then
    if input.pressed(input.BTN1) then
      local best = math.max(State.best, State.play_time)
      _init()
      State.best = best
    end
    return
  end

  -- 1. 移动（用 dt，速度与帧率无关）
  local dx, dy = 0, 0
  if input.held(input.LEFT) then dx = dx - 1 end
  if input.held(input.RIGHT) then dx = dx + 1 end
  if input.held(input.UP) then dy = dy - 1 end
  if input.held(input.DOWN) then dy = dy + 1 end
  local dir = util.vec_normalize({ x = dx, y = dy })   -- 斜向不会更快
  State.player.x = State.player.x + dir.x * PLAYER_SPEED * dt
  State.player.y = State.player.y + dir.y * PLAYER_SPEED * dt

  -- 2. 夹在屏幕内
  State.player.x = util.clamp(State.player.x, 0, usagi.GAME_W - PLAYER_SIZE)
  State.player.y = util.clamp(State.player.y, 0, usagi.GAME_H - PLAYER_SIZE)

  -- 3. 定时生成敌人
  State.spawn_timer = State.spawn_timer - dt
  if State.spawn_timer <= 0 then
    table.insert(State.enemies, {
      x = usagi.GAME_W + 10,
      y = math.random(10, usagi.GAME_H - 10),
      spd = math.random(60, 140),      -- px/s
    })
    State.spawn_timer = SPAWN_DELAY
  end

  -- 4. 更新敌人 + 判碰撞（倒序，因为要删）
  local hitbox = { x = State.player.x, y = State.player.y, w = PLAYER_SIZE, h = PLAYER_SIZE }
  for i = #State.enemies, 1, -1 do
    local e = State.enemies[i]
    e.x = e.x - e.spd * dt

    if util.circ_rect_overlap({ x = e.x, y = e.y, r = ENEMY_R }, hitbox) then
      State.game_over = true
      effect.screen_shake(0.3, 4)
      effect.flash(0.15, gfx.COLOR_RED)
    end

    if e.x < -10 then
      table.remove(State.enemies, i)
    end
  end

  -- 5. 计时
  State.play_time = State.play_time + dt
end

function _draw(_dt)
  gfx.clear(gfx.COLOR_DARK_BLUE)

  if not State.game_over then
    gfx.rect_fill(State.player.x, State.player.y, PLAYER_SIZE, PLAYER_SIZE, gfx.COLOR_GREEN)
  end

  for _, e in ipairs(State.enemies) do
    gfx.circ_fill(e.x, e.y, ENEMY_R, gfx.COLOR_RED)
  end

  gfx.text(math.floor(State.play_time) .. "s", 280, 8, gfx.COLOR_WHITE)
  gfx.text("BEST " .. math.floor(State.best) .. "s", 8, 8, gfx.COLOR_LIGHT_GRAY)

  if State.game_over then
    gfx.text("GAME OVER", 8, 40, gfx.COLOR_WHITE)
    gfx.text("Press " .. input.mapping_for(input.BTN1), 8, 60, gfx.COLOR_WHITE)
  end
end