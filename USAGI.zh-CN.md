<!-- 由 usagi 1.3.3 生成。运行 `usagi refresh` 进行更新。 -->

<img alt="Usagi Logo: pixel art bunny, Usagi Engine - Rapid 2D Prototyping" src="https://usagiengine.com/website/card-logo.png" />

# Usagi - 用于快速原型开发的简单 2D 游戏引擎

Usagi 是一个用 **Lua** 5.5 制作像素风游戏的 2D 游戏引擎。它支持热重载、单条命令跨平台导出，
并内置了带按键重映射功能的暂停菜单。

Usagi 是由 [Brett Chalupa](https://brettmakesgames.com) 开发的自由软件，
已贡献至公有领域。
[你可以请我喝杯咖啡，支持引擎的开发。](https://www.buymeacoffee.com/brettchalupa)

<video controls crossorigin="anonymous" type="video/mp4" src="https://assets.brettchalupa.com/usagi.mp4"></video>

**链接：** [usagiengine.com](https://usagiengine.com)、
[教程书](https://book.usagiengine.com)、
[Discord](https://usagiengine.com/discord)、
[r/UsagiEngine](https://reddit.com/r/UsagiEngine)、
[快速上手视频](https://www.youtube.com/watch?v=0i1wIm6c6Rw)、
[YouTube 播放列表](https://www.youtube.com/playlist?list=PL0qDutCc8IQhkbS53etm9xV06XgEb4BEN)

## 安装

**Linux、macOS：**

```sh
curl -fsSL https://usagiengine.com/install.sh | sh
```

**Windows（PowerShell）：**

```powershell
irm https://usagiengine.com/install.ps1 | iex
```

安装脚本会获取最新版本、校验其 SHA-256 校验和，把 `usagi` 安装到 `~/.usagi/bin/`
（Windows 上为 `%USERPROFILE%\.usagi\bin\`），并将其加入 `PATH`。

**Homebrew（包管理器）：**

```
brew tap brettchalupa/usagi https://codeberg.org/brettchalupa/usagi
brew install usagi
```

手动下载：
[Codeberg](https://codeberg.org/brettchalupa/usagi/releases/latest) |
[GitHub](https://github.com/brettchalupa/usagi/releases/latest) |
[itch.io](https://brettchalupa.itch.io/usagi)

最新版本：**v1.3.3**。

[查看更新日志。](https://usagiengine.com/changelog)

![旋转立方体演示](/website/demo.gif)

## 特性

- **热重载。** `usagi dev` 会监视你的代码和素材；保存后即刻生效，且不会丢失游戏状态。
  在编辑器里微调一张精灵图，就能立刻看到它更新。
- **一条命令导出。** `usagi export` 可把你的游戏打包为 Linux、macOS、Windows 和 Web 版本。
- **免费附赠暂停菜单。** 内置暂停菜单，含音效与音乐音量、全屏开关，以及每个游戏独立的
  键盘 + 手柄重映射。
- **存档超简单。** 一个函数就能把游戏状态保存为 Lua 表并从中加载。
- **小巧而固定的 API。** 它做不到一切，但做出一款出色的 2D 游戏所需的东西你都有。
- **用约束激发创意。** 默认分辨率 320x180，默认精灵网格 16x16，所有贴图都放在一张
  `sprites.png` 里。

音效、精灵编辑器、音乐工具请自备。

![菜单预览，显示 Continue、Settings、Clear Save Data、Reset Game 和 Quit 选项](/website/menu.png)

## Hello, Usagi

引导创建一个项目并以开发模式启动：

```sh
usagi init my_game
cd my_game
usagi dev
```

`init` 会写入 `main.lua`（包含 `_init` / `_update` / `_draw` 三个空壳函数）、
用于 Lua LSP 支持的 `.luarc.json`、`.gitignore`、`meta/usagi.lua`（API 类型存根），
以及 `USAGI.md`（本文档的一份拷贝）。

编辑 `main.lua` 并保存，正在运行的游戏就会在不重启、不丢失状态的情况下接受改动。
绘制 "Hello, Usagi!" 的代码如下：

```lua
function _draw(_dt)
  gfx.clear(gfx.COLOR_BLACK)
  gfx.text("Hello, Usagi!", 10, 10, gfx.COLOR_WHITE)
end
```

## 更新 Usagi

用更新的版本替换 `usagi` 二进制文件，或运行 `usagi update` 获取最新版。然后在项目内运行
`usagi refresh`，刷新 LSP 类型存根与内嵌文档（`meta/usagi.lua`、`.luarc.json`、
`USAGI.md`）。它不会碰 `main.lua`。

## 反馈与问题

有反馈、功能请求或 bug，请提一个
[issue](https://codeberg.org/brettchalupa/usagi/issues/new)。请先搜索，避免重复。

## 目标与非目标

Usagi 面向使用 Lua 的 2D 像素风快速原型开发。如果你想快速验证一个想法、如果你是游戏编程
新手、如果你撞上了 Pico-8 的 token 上限，或者你想要比 Love2D 更简单的东西，它都非常合适。

它**不是**幻想主机（fantasy console），也不是 Love2D 的替代品。它不面向移动端或 VR，
也不是为中型到大型的精雕细琢型游戏而打造的。

**为什么选 Lua：** 它小巧、在游戏工具链中被广泛使用，而且足够强大，不会挡你的路。

## 项目结构

一个 Usagi 游戏要么是单个 `.lua` 文件，要么是一个包含 `main.lua` 的目录。项目根目录下
任意位置的其它 `.lua` 文件都可以用标准 Lua 的 `require` 加载。可选素材与源代码放在一起。
下面是一个多文件项目可能呈现的目录结构：

```
my_game/
  main.lua           -- 必需：游戏的入口点
  sprites.png        -- 可选：16×16 精灵图集（带 alpha 的 PNG）
  palette.png        -- 可选：自定义调色板（高 1 像素，一个像素一种颜色）
  font.png           -- 可选：自定义字体（用 `usagi font bake` 烘焙）
  enemies.lua        -- 可选：require "enemies"
  data/
    level.json       -- 可选：JSON 数据，用 `usagi.read_json("level.json") 加载
    dialog.txt       -- 可选：文本数据，用 `usagi.read_text("dialog.txt") 加载
  scenes/
    main_menu.lua    -- 可选：require "scenes.main_menu" —— 源码可以放在子目录里
  sfx/               -- 可选：.wav 文件，文件名主干即音效名
    jump.wav
    coin.wav
  music/             -- 可选：.ogg/.mp3/.wav/.flac，文件名主干即曲目名
    overworld.ogg
    boss.ogg
  shaders/           -- 可选：后处理 GLSL 着色器（进阶用法；见「着色器」一节）
    crt.fs           -- 桌面 GLSL 330
    crt_es.fs        -- Web + 树莓派 GLSL ES 100
```

运行方式：

- `usagi init path/to/new_game` 引导创建一个项目（main.lua 空壳、`.luarc.json`、
  `.gitignore`、LSP 存根、`USAGI.md` 文档）。
- `usagi dev path/to/my_game` 进入热重载开发模式（脚本、精灵图和音效在保存时重新加载；
  [重置](#重置)会重新运行 `_init`）。
- `usagi run path/to/my_game` 不带热重载地运行。
- `usagi tools [path]` 打开 Usagi 工具窗口（点唱机、瓦片拾取器）。见下文 **工具** 一节。
- `usagi export path/to/my_game` 把游戏打包用于分发：Linux、macOS、Windows 和 Web 的
  zip 包，外加一个可移植的 `.usagi` 包。见下文 **导出** 一节。

你也可以不给路径，让 Usagi 命令在当前目录下运行，例如 `usagi dev` 或 `usagi export`。

完全不带参数运行二进制文件（双击它，或启动一个 `.desktop` 文件）会打开一个小型启动器
窗口。把一个 `main.lua` 或项目文件夹拖进去，Usagi 就会对该路径启动 `usagi dev`。

### 多个 Lua 文件

`require "name"` 会解析到项目根目录下的 `name.lua`，若未命中则回退到 `name/init.lua`。
带点的名字（`require "world.tiles"`）会转成以斜杠分隔的路径。同一套查找逻辑在融合
（fused）/ 导出构建中也同样有效，因此多文件项目无需额外配置就能打包为单个二进制或
`.usagi` 文件。

用 `require` 把代码拆到多个文件。模块会返回自己的 API 并被缓存，因此你可以在任何需要的
地方 `require` 它：

```lua
-- player.lua
local Player = {}
function Player.new() return { x = 0, y = 0 } end
return Player

-- main.lua
local Player = require "player"
```

加载 `.lua` 文件时只使用 `require`，绝不要用 `loadfile` / `dofile` / `io`：它们从操作
系统文件系统读取，在 `usagi dev` 里能跑，但在 Web 和导出构建中会失效。`require` 走的是
Usagi 的虚拟文件系统，所以在任何平台都能工作。

## Lua API

**理念：** 保持简单、命名清晰，并优先使用固定函数签名。

**风格**：Lua 代码使用 2 空格缩进，局部变量、函数名和表字段使用 `snake_case`。文件作用域
常量使用 `SCREAMING_SNAKE_CASE`（`local TICK = 0.12`、`gfx.COLOR_*`）。跨帧的全局变量使用
**`Capitalized`（首字母大写）**。规范的游戏状态容器是 `State`，在 `_init` 中赋值。以全局
形式保留的模块导入写作 `Player = require("player")`。随附的 `.luarc.json` 启用了
`lowercase-global` 诊断，因此文件作用域里任何未加保护的小写赋值都会被标记为「可能漏写了
`local`」。引擎 API（`gfx`、`input`、`sfx`、`music`、`usagi`）保持小写，并通过
`meta/usagi.lua` 豁免于该检查。

[查看 Lua 5.5 文档以获取完整语言参考。](https://www.lua.org/manual/5.5/)

### 速查表

```lua
-- 引擎信息 / 配置

usagi.GAME_W
usagi.GAME_H
usagi.SPRITE_SIZE
usagi.PLATFORM -- "web" | "macos" | "linux" | "windows" | "unknown"
usagi.IS_DEV
usagi.IS_RELEASE
usagi.elapsed
usagi.measure_text(text)
usagi.save(t)
usagi.load()
usagi.read_json(path) -- 以 Lua 表形式读取 data/<path>
usagi.read_text(path) -- 以字符串形式读取 data/<path>
usagi.to_json(t) -- 把 Lua 表序列化为 JSON 字符串（形状规则与 usagi.save 相同）
usagi.menu_item(label, callback) -- 最多 3 个；回调 `return true` 保持菜单打开
usagi.clear_menu_items()
usagi.toggle_fullscreen() -- 切换全屏，以 bool 返回新状态
usagi.is_fullscreen()
usagi.quit() -- 终止主循环（在 Web 上视觉上无效果）

-- 生命周期回调

_init()
_update(dt)
_draw(dt)

-- 配置：项目根目录的 usagi.conf，或 main.lua 顶部的 `-- key = value` 前置注释。
-- 键：name, game_id, icon, game_width,
-- game_height, sprite_size, pixel_perfect, pause_menu, initial_fullscreen。

-- 图形

gfx.clear(color)
gfx.text(text, x, y, color, alpha?)
gfx.text_ex(text, x, y, scale, rotation, color, alpha, spacing?)
gfx.rect(x, y, w, h, color, alpha?)
gfx.rect_fill(x, y, w, h, color, alpha?)
gfx.rect_ex(x, y, w, h, thickness, color, alpha?)
gfx.circ(x, y, r, color, alpha?)
gfx.circ_fill(x, y, r, color, alpha?)
gfx.circ_ex(x, y, r, thickness, color, alpha?)
gfx.line(x1, y1, x2, y2, color, alpha?)
gfx.line_ex(x1, y1, x2, y2, thickness, color, alpha?)
gfx.tri(x1, y1, x2, y2, x3, y3, color, alpha?)
gfx.tri_fill(x1, y1, x2, y2, x3, y3, color, alpha?)
gfx.px(x, y, color, alpha?)
gfx.get_px(x, y) -- 读取屏幕像素：r, g, b, palette_index；在 Web 上开销很大
gfx.spr(index, x, y, alpha?)
gfx.spr_ex(index, x, y, flip_x, flip_y, rotation, tint, alpha)
gfx.get_spr_px(index, x, y) -- 读取精灵图集像素：r, g, b, palette_index
gfx.sspr(sx, sy, sw, sh, dx, dy, alpha?)
gfx.sspr_ex(sx, sy, sw, sh, dx, dy, dw, dh, flip_x, flip_y, rotation, tint, alpha)
gfx.shader_set(name)
gfx.shader_uniform(name, value)

-- 调色板（PICO-8，16 色）

gfx.COLOR_BLACK, gfx.COLOR_DARK_BLUE, gfx.COLOR_DARK_PURPLE, gfx.COLOR_DARK_GREEN
gfx.COLOR_BROWN, gfx.COLOR_DARK_GRAY, gfx.COLOR_LIGHT_GRAY, gfx.COLOR_WHITE
gfx.COLOR_RED,   gfx.COLOR_ORANGE,    gfx.COLOR_YELLOW,     gfx.COLOR_GREEN
gfx.COLOR_BLUE,  gfx.COLOR_INDIGO,    gfx.COLOR_PINK,       gfx.COLOR_PEACH

-- 调色板之外的纯白 (255,255,255)。spr_ex / sspr_ex 的恒等染色值。
gfx.COLOR_TRUE_WHITE

-- 声音

sfx.play(name)
sfx.play_ex(name, volume, pitch, pan)
sfx.stop(name)
sfx.stop_all()
sfx.is_playing(name)
music.play(name)
music.loop(name)
music.stop()
music.play_ex(name, volume, pitch, pan, loop)
music.mutate(volume, pitch, pan)

-- 输入 —— 动作

input.pressed(action)
input.held(action)
input.released(action)
input.mapping_for(action)
input.last_source()

input.LEFT, input.RIGHT, input.UP, input.DOWN
input.BTN1, input.BTN2, input.BTN3
input.SOURCE_KEYBOARD, input.SOURCE_GAMEPAD

-- 输入 —— 鼠标

input.mouse()
input.mouse_over()
input.mouse_held(button)
input.mouse_pressed(button)
input.mouse_released(button)
input.mouse_scroll()
input.set_mouse_visible(visible)
input.mouse_visible()

input.MOUSE_LEFT, input.MOUSE_RIGHT, input.MOUSE_MIDDLE

-- 输入 —— 键盘（绕过动作键位映射；游戏输入请优先使用动作）

input.key_held(key)
input.key_pressed(key)
input.key_released(key)

input.KEY_A   .. input.KEY_Z
input.KEY_0   .. input.KEY_9
input.KEY_F1  .. input.KEY_F12
input.KEY_SPACE, KEY_ENTER, KEY_ESCAPE, KEY_TAB, KEY_BACKSPACE, KEY_DELETE
input.KEY_LEFT, KEY_RIGHT, KEY_UP, KEY_DOWN
input.KEY_LSHIFT, KEY_RSHIFT, KEY_LCTRL, KEY_RCTRL, KEY_LALT, KEY_RALT
input.KEY_BACKTICK, KEY_MINUS, KEY_EQUAL
input.KEY_LBRACKET, KEY_RBRACKET, KEY_BACKSLASH
input.KEY_SEMICOLON, KEY_APOSTROPHE, KEY_COMMA, KEY_PERIOD, KEY_SLASH

-- 效果（打击感 / juice）

effect.hitstop(time)
effect.screen_shake(time, intensity)
effect.flash(time, color)
effect.slow_mo(time, scale)
effect.stop() -- 停止所有正在运行的效果

-- 工具 —— 数学

util.clamp(v, lo, hi)
util.sign(v)
util.round(v)
util.approach(current, target, max_delta)
util.lerp(a, b, t)
util.wrap(v, lo, hi)
util.flash(t, hz)
util.remap(v, start_a, end_a, start_b, end_b)

-- 工具 —— 向量与几何
-- 表参数：vec {x, y}   rect {x, y, w, h}   circ {x, y, r}

util.vec_normalize(vec)
util.vec_dist(vec, vec)
util.vec_dist_sq(vec, vec)
util.vec_from_angle(angle, len)          -- len 可选，默认 1

util.point_in_rect(vec, rect)
util.point_in_circ(vec, circ)
util.rect_overlap(rect, rect)
util.circ_overlap(circ, circ)
util.circ_rect_overlap(circ, rect)

-- 工具 —— 缓动

util.ease.sine_in(a, b, progress)
util.ease.sine_out(a, b, progress)
util.ease.sine_in_out(a, b, progress)
util.ease.circ_in(a, b, progress)
util.ease.circ_out(a, b, progress)
util.ease.circ_in_out(a, b, progress)
util.ease.expo_in(a, b, progress)
util.ease.expo_out(a, b, progress)
util.ease.expo_in_out(a, b, progress)
```

### 复合赋值运算符

Usagi 会把每个 `.lua` 源文件先过一个极小的预处理器，再交给 Lua 虚拟机，从而加上复合赋值
语法糖：

| 运算符   | 改写为      |
| -------- | ----------- |
| `+=`     | `x = x + y` |
| `-=`     | `x = x - y` |
| `*=`     | `x = x * y` |
| `/=`     | `x = x / y` |
| `%=`     | `x = x % y` |

```lua
State.score += 1
State.timer += dt
```

限制：改写是以整行为锚点的，因此 `if cond then x += 1 end` 会保持原样（请用展开写法）。
左值会被原样复制一遍，所以 `t[f()] += 1` 会调用两次 `f()`。

`usagi init` 生成的 `.luarc.json` 把这些运算符声明为非标准符号，这样 lua-language-server
就不会把它们当作文法错误画下划线。

### 回调

把以下任意函数定义为全局函数，Usagi 就会调用它们：

- `_init()` —— 启动时调用一次，以及每次[重置](#重置)时调用。请在这里初始化 `State`
  （以及其它跨帧全局变量）。
- `_update(dt)` —— 每帧在绘制之前调用。`dt` 是距上一帧的秒数。
- `_draw(dt)` —— 每帧在更新之后调用。`dt` 含义同上。

### 配置

用项目根目录下的 `usagi.conf` 文件，或用 `main.lua` 顶部的前置注释来配置你的游戏。两者
使用相同的 `key = value` 格式，每行一项。配置在启动时、窗口打开之前只读取一次。

对大多数游戏来说，`usagi.conf` 是推荐做法；它把配置与代码分开，也便于其它工具读取。
`usagi init` 会为你创建一个。

```conf
name = Snake
game_id = com.example.snake
pixel_perfect = true
# game_width = 480     # 可选；默认 320
# game_height = 270    # 可选；默认 180
# sprite_size = 32     # 可选；默认 16
# pause_menu = false   # 可选；默认 true
# initial_fullscreen = true  # 可选；默认 false
# gif_length = 10      # 可选；默认 5
```

前置注释必须从 `main.lua` 的第一行开始（前面有空白行或代码就会被跳过）。它们会逐行读取，
直到遇到第一行不是 `--` 注释的内容（空行会结束该块）。不含 `=` 的注释行被视为普通散文而
被忽略，因此描述性文字可以和配置行并排存在。这让单文件游戏和开发工具能够自我配置：

```lua
-- name = Snake
-- game_id = com.example.snake
-- pixel_perfect = true

function _init() end
```

两者同时存在时，会按字段合并，前置注释优先于 `usagi.conf`。这让单个 `mapeditor.lua`
文件可以自行设定分辨率，而不用碰项目的 `usagi.conf`。若某个字段在多于一处被设置，
则会记录一条警告日志，指出生效的是哪一处。

值都是字符串，按字段做类型转换：`pixel_perfect = true`、`game_width = 480`、
`name = My Game`（不加引号，空格保留）。`usagi.conf` 中的空行与 `#` 注释会被忽略。

支持的键：

- `name`：显示名称。它决定窗口标题栏、macOS `.app` 包目录名（`Sprite Example.app`）、
  Info.plist 的 `CFBundleName` / `CFBundleDisplayName`，以及（在转换成 ASCII kebab-case
  之后）`usagi export` 产出的归档文件名与 Linux/Windows 二进制名。默认取项目目录名
  （`examples/spr/main.lua` → "spr"）；若没有可用路径则回退为 "Usagi"。
- `pixel_perfect`（默认 `false`）：为 `true` 时，游戏只按整数倍缩放（1×、2×、3×……）渲染，
  窗口剩余空间用黑色信箱条填充。为 `false` 时，游戏按能适配窗口的任意倍率缩放，同时保持
  游戏的宽高比，因此信箱条只会出现在多出空间的那一个轴上，绝不会让画面变形。默认值为
  `false`，因为在常见的全屏分辨率（720p、1080p、4K）下，游戏的 320×180 原生尺寸恰好落在
  整数倍上，而窗口模式下它看起来依然不错。
- `game_id`：形如 `com.brettmakesgames.snake` 的反向 DNS 字符串，用于为存档数据和 macOS
  包标识符划分命名空间。可选。
- `icon`：`sprites.png` 中从 1 开始的瓦片索引，用作窗口图标，以及（在
  `usagi export --target macos` 时）`.app` 图标。可选，默认为 Usagi 兔子。
- `sprite_size`（默认 `16`）：`sprites.png` 中单个格子的边长（像素）。它决定 `gfx.spr`
  的索引方式、瓦片拾取器工具的网格，以及窗口图标的切图逻辑。你的 `sprites.png` 在两个
  轴上都必须是该值的整数倍；若版式不符合，窗口图标会回退为默认图标。该值也会流入
  `usagi.SPRITE_SIZE`，让 Lua 代码可以读到当前格子尺寸。可选。

  请把 `sprites.png` 控制在**每个轴 8192 像素以内**。GPU 对纹理尺寸有上限（桌面端通常
  16384，但 Web 和较老硬件上常常只有 8192 或更低）；超出上限的图集会被截断上传，因此
  任何取自上限之外的精灵都会渲染成一个黑色方块，而且不会报错。如果你有数百帧，请把它们
  排成多行的网格，而不是挤在一行很长里。图集过大时，Usagi 会在加载时记录一条警告。

- `game_width`（默认 `320`）与 `game_height`（默认 `180`）：覆盖游戏的渲染分辨率。
  内部渲染目标会按这两个尺寸创建；窗口再等比放大以适配。经过测试的范围大致是
  320x180 到 640x360。超出该范围时，暂停菜单与工具界面是像素固定的，非常小的尺寸下可能
  溢出，非常大时又会显得稀疏。精灵尺寸（`usagi.SPRITE_SIZE`，16）与内置字体（5x7）不会
  随分辨率缩放，因此 1280x720 的游戏里精灵和文字相对屏幕会显得很小。Web 导出会把画布的
  backing-store 与宽高比按配置的分辨率做模板化，因此非 16:9 / 非默认尺寸的游戏用默认外壳
  即可正确发布（无需 `--web-shell`），并且能在 itch 上以任意 iframe 尺寸干净地嵌入。可选。
- `pause_menu`（默认 `true`）：为 `true` 时，引擎会拦截 Esc / P / Enter / 手柄 Start 来
  打开内置暂停浮层。设为 `false` 时，这些按键会直接传给用户代码，让游戏可以用
  `usagi.menu_item`、`usagi.toggle_fullscreen`、`usagi.quit` 以及 `input.key_*` API
  自行实现菜单。禁用同时会关闭键盘重映射界面、输入测试器，以及手柄驱动的菜单导航
  （它们是同一浮层的子视图），并且 `usagi.menu_item` 的注册也不再被渲染。适合以键盘驱动
  的原型。可选。
- `initial_fullscreen`（默认 `false`）：为 `true` 时，游戏以全屏启动。这只设定玩家首次
  启动时的默认值；一旦玩家从暂停菜单切换过全屏，之后启动时以保存的偏好为准。可选。
- `gif_length`（默认 `5`）：由 Ctrl/Cmd+G 的 GIF 录制功能（仅在 `usagi dev` 构建中可用）
  生成的 GIF 时长，单位秒。默认 5 秒，但可以改为任意浮点数。注意：录制时间越长，引擎收集
  待导出帧数据时的资源占用越高、性能损耗越明显。设为 `0` 可在所有构建中禁用 GIF 录制，
  并消除相关的少量开销。

`icon`（可选）是你的 `sprites.png` 中从 1 开始的瓦片索引，索引方式与 `gfx.spr` 相同。
省略时使用内置的 Usagi 兔子。选定的瓦片会在 Linux/Windows 上应用到游戏窗口。在
`usagi export --target macos` 时，同一瓦片会被放大并打包进 `.app` 内的
`Resources/AppIcon.icns`，macOS 的 Dock/Finder 正是读取它。

配置**在启动时读取一次并缓存**。游戏运行期间编辑 `usagi.conf` 或前置注释不会更新标题或
任何其它配置字段；重启会话才能生效。

#### 已废弃：`_config()`

较早的游戏会从全局函数 `_config()` 返回配置表。这仍然可用，但已废弃：它会迫使引擎
（以及 `usagi tools` / `usagi export`）仅仅为了读取配置就启动一个 Lua 虚拟机，而且存在
加载顺序陷阱——顶层对 `usagi.GAME_W` 的读取会在 `_config()` 运行之前就看到默认值。
`_config()` 的优先级最低（前置注释 > `usagi.conf` > `_config()`），并且存在时 Usagi 会
记录一条废弃警告。请把你的设置迁移到 `usagi.conf` 或前置注释。

#### 窗口尺寸与缩放

使用 Usagi 你不必操心窗口尺寸。游戏会被缩放到窗口。默认情况下，游戏以窗口模式启动，
大小约为显示器尺寸的 66%，并向下取到最接近的整数倍缩放。玩家可以按自己的偏好切换全屏，
该设置会被持久化并在下次启动时生效。窗口可由玩家调整大小。

你可以在配置中设置 `pixel_perfect = true`，确保游戏永远不会不像素完美。对于分辨率可能
低于游戏的分辨率，游戏窗口会被最大化。

如果你希望游戏默认以全屏启动，在配置中设置 `initial_fullscreen = true`。

### `gfx`

向屏幕绘制。坐标以游戏空间像素为单位（320×180）。颜色是调色板槽位索引 `1..16`；请使用
具名常量。

下面每一个 `gfx` 绘制调用都接受一个可选的尾部 `alpha` 参数（不透明度，`0..1`）；省略它或
传入 `1.0` 即为完全不透明绘制。这包括 `text`、`spr`、`sspr` 以及各种形状图元。

- `gfx.clear(color)` —— 填充整个屏幕。
- `gfx.rect(x, y, w, h, color, alpha?)` —— 1 像素宽的矩形轮廓。
- `gfx.rect_fill(x, y, w, h, color, alpha?)` —— 实心矩形。
- `gfx.rect_ex(x, y, w, h, thickness, color, alpha?)` —— 可自定义描边粗细（像素）的
  矩形轮廓。
- `gfx.circ(x, y, r, color, alpha?)` —— 以 `(x, y)` 为圆心的 1 像素宽圆形轮廓。
- `gfx.circ_fill(x, y, r, color, alpha?)` —— 以 `(x, y)` 为圆心的实心圆。
- `gfx.circ_ex(x, y, r, thickness, color, alpha?)` —— 可自定义描边粗细的圆形轮廓。
  描边以标称半径为中线，因此连续叠加
  `circ_ex(x, y, r, 1, c)` / `circ_ex(x, y, r-1, 1, c)` / `circ_ex(x, y, r-2, 1, c)`
  三次调用可以画出紧贴的同心圆环、不留缝隙——这修掉了在相邻半径上叠用普通 `gfx.circ`
  时出现的取整缝隙问题。
- `gfx.line(x1, y1, x2, y2, color, alpha?)` —— 从 `(x1, y1)` 到 `(x2, y2)` 的 1 像素线。
- `gfx.line_ex(x1, y1, x2, y2, thickness, color, alpha?)` —— 可自定义粗细（像素）的线。
- `gfx.tri(x1, y1, x2, y2, x3, y3, color, alpha?)` —— 由三个点构成的 1 像素宽三角形
  轮廓。若需要更粗的轮廓，请绘制三次 `gfx.line_ex`。
- `gfx.tri_fill(x1, y1, x2, y2, x3, y3, color, alpha?)` —— 由三个点构成的实心三角形。
  顶点顺序无关紧要；绕序会被自动纠正，所以箭头、飞船机头之类的东西无论你怎么排点都
  画得出来。
- `gfx.px(x, y, color, alpha?)` —— 设置单个像素。
- `gfx.get_px(x, y)` 返回最近一次渲染帧上 `(x, y)` 处像素的 `(r, g, b, palette_index)`。
  `palette_index` 是 RGB 精确匹配时对应的从 1 开始的槽位，若颜色不在调色板内则为 `nil`。
  对于屏幕外坐标以及最初的第一帧（还什么都没画时），四个返回值都是 `nil`。读取反映的是
  上一帧的成品图像，因此看不到当前 `_draw` 里正在进行的绘制。经典用法是按颜色做碰撞：
  用已知颜色把墙画进帧缓冲，然后在 `_update` 中查询目标位置的 `gfx.get_px`。
  **性能**：这个函数开销很高，在 Web 上尤其明显。即使只调用一次，也会让你的游戏慢上
  约 10%。请谨慎使用。
- `gfx.text(text, x, y, color, alpha?)` —— 内置的 monogram 字体（5×7 像素字体，
  行高 12 像素；见下文「致谢」）。它会渲染引擎默认的拉丁 / 西里尔 / 希腊字形集，如果
  项目根目录存在 `font.png`，则使用你的自定义字体（见下文「自定义字体」）。要测量文本
  尺寸，请使用 `usagi.measure_text`——它位于 `usagi` 而不是 `gfx`，因为测量是纯工具函数
  （没有渲染副作用），并且可以从任何回调中调用，包括 `_init`。
- `gfx.text_ex(text, x, y, scale, rotation, color, alpha, spacing?)` —— `text` 的扩展
  版本：
  - `scale`（数字）—— 字号倍率。要得到清晰文字请**使用整数**（`1`、`2`、`3`），因为
    图集预烘焙的字体使用 POINT 过滤，整数倍才能保住像素画观感。小数倍会变模糊。
  - `rotation`（数字）—— 弧度。`0` 表示不旋转。要写角度请用 `math.rad(45)`。旋转围绕
    未旋转包围盒的**中心**进行；`rotation = 0` 时 `(x, y)` 仍是左上角。适合做打击感：
    抖动的字幕、倾斜的标签、分数弹出。
  - `alpha`（数字）—— 不透明度，`0..1`。`1.0` 为不透明，`0.0` 为不可见。用于淡入淡出、
    变暗的 UI、半透明预览。
  - `spacing`（数字）—— 字符间距，默认为 `0`；`-1` 表示字符彼此靠近 1 像素。
- `gfx.spr(index, x, y, alpha?)` —— 从 `sprites.png` 中绘制索引 `index` 处的 16×16
  精灵（`1` = 左上角）。原生尺寸、不翻转、不旋转、不染色；除非传入 `alpha`，否则不透明。
- `gfx.spr_ex(index, x, y, flip_x, flip_y, rotation, tint, alpha)` —— `spr` 的扩展版本。
  八个参数全部必填：
  - `flip_x` / `flip_y`（布尔）—— 左右或上下镜像。
  - `rotation`（数字）—— 弧度。`0` 表示不旋转。要写角度请用 `math.rad(45)`。旋转围绕
    精灵的**中心**进行；`(x, y)` 仍是未旋转包围盒的左上角。
  - `tint`（调色板颜色）—— 与精灵相乘。`gfx.COLOR_TRUE_WHITE` 是恒等值（不改变颜色）。
    其它颜色会重新着色精灵（例如用 `gfx.COLOR_RED` 做受击闪白）。注意
    `gfx.COLOR_WHITE` 是 Pico-8 调色板的白（`255,241,232`），略微偏暖，会让颜色有一点点
    偏移；如果你想要「纸页泛黄」的观感就故意用它，若想让像素原样透过，请用
    `gfx.COLOR_TRUE_WHITE`（调色板之外的纯白）。因为是相乘语义，它无法产出全白剪影：
    那种效果请用着色器，或在上面盖一个彩色矩形。
  - `alpha`（数字）—— 不透明度，`0..1`。`1.0` 为不透明，`0.0` 为不可见。
- `gfx.get_spr_px(index, x, y)` 返回 `sprites.png` 上 `index` 精灵格内某个像素的
  `(r, g, b, palette_index)`。`index` 从 1 开始（形状与 `gfx.spr` 相同）；`(x, y)` 是
  格子内的偏移，`(0, 0)` 为该格子的左上角。索引越界、坐标超出格子、项目没有
  `sprites.png`，或源像素完全透明时，四个返回值都是 `nil`（`gfx.spr` 是按 alpha 键控
  绘制的，因此透明像素读出来是「这里没有东西」，而不是它背后的 RGB）。与 `gfx.get_px`
  不同，精灵读取是确定性的、不受绘制顺序影响：适合做像素级精确的精灵碰撞，也适合那种
  把关卡布局画进图集、再在启动时扫描它来生成实体的做法。
- `gfx.sspr(sx, sy, sw, sh, dx, dy, alpha?)` —— 从 `sprites.png` 取任意
  `(sx, sy, sw, sh)` 矩形，按原始尺寸绘制到 `(dx, dy)`；除非传入 `alpha`，否则不透明。
- `gfx.sspr_ex(sx, sy, sw, sh, dx, dy, dw, dh, flip_x, flip_y, rotation, tint, alpha)`
  —— `sspr` 的扩展版本：先拉伸到 `(dw, dh)`，再按布尔值翻转，然后旋转 / 染色 / 设置
  alpha。语义与 `spr_ex` 相同。十三个参数全部必填。
- `gfx.COLOR_BLACK`、`COLOR_DARK_BLUE`、`COLOR_DARK_PURPLE`、`COLOR_DARK_GREEN`、
  `COLOR_BROWN`、`COLOR_DARK_GRAY`、`COLOR_LIGHT_GRAY`、`COLOR_WHITE`、
  `COLOR_RED`、`COLOR_ORANGE`、`COLOR_YELLOW`、`COLOR_GREEN`、`COLOR_BLUE`、
  `COLOR_INDIGO`、`COLOR_PINK`、`COLOR_PEACH` —— 调色板槽位索引 `1..16`，与
  `gfx.spr` 以及 Lua 的数组约定一致。每个槽位的 RGB 都是默认的 Pico-8 调色板，除非有
  `palette.png` 覆盖（见下文）。这些常量是槽位索引，而不是对 RGB 的承诺：如果你换了
  调色板，`gfx.COLOR_RED` 仍然解析到槽位 9，但它的实际颜色取决于当前生效的调色板。
- `gfx.COLOR_TRUE_WHITE` —— 槽位 `0`，纯 `(255, 255, 255)`。在调色板之外：即使加载了
  `palette.png` 也保持纯白。当你希望精灵按源色原样绘制时，用它作为
  `gfx.spr_ex` / `gfx.sspr_ex` 的恒等染色值。Pico-8 的 `gfx.COLOR_WHITE` 略微偏暖
  （`255, 241, 232`），若把它当作染色值会给精灵染上一点桃色，想要那种观感也没问题，
  但 `gfx.COLOR_TRUE_WHITE` 才是真正的无操作。（低于 `0` 或高于当前调色板长度的索引会
  渲染为品红色，作为明显的「未知颜色」哨兵值。）

`_ex` 变体把所有强力参数打包进一个固定签名，而不是拖一串可选参数。每个图元只有一个
`_ex` 版本，因此每次绘制只面临一个决定（「简单版还是扩展版？」）。如果你想要更短的调用
点，写一个薄封装即可。

#### 自定义调色板（`palette.png`）

把 `palette.png` 放在项目根目录，即可覆盖引擎默认的 Pico-8 调色板。像素按**行主序**
读取（从左到右、从上到下）：

- **任意矩形形状。** 16x1 长条、16x2 网格（32 色）、4x4（16 色）都可以。颜色数 =
  `width × height`。多行对于组织更大的调色板很方便。
- **每个像素 = 一个槽位。** 请使用 lospec.com 的「1px cells」导出，而不是更大的色块版本
  （那种版本里每种颜色是一个 16x16 的重复块）。
- **槽位索引从 1 开始。** 左上角像素是槽位 1。`gfx.COLOR_*` 常量就是当前调色板的
  `1..16` 槽位索引。

行为：

- 缺少 `palette.png` → 引擎使用 Pico-8 默认调色板（16 色）。
- 会像 `sprites.png` 一样热重载。把新的 `palette.png` 覆盖保存到旧文件上，运行中的游戏
  就会立即换色。
- 超出调色板范围的槽位索引会渲染为品红色（`255,0,255,255`）——即现有的「未知颜色」哨兵
  值。如果你的调色板只有 8 色，`gfx.COLOR_RED`（槽位 9）及更高的槽位都会是品红色。
  对于非默认调色板，请在 Lua 里定义你自己的常量。
- 存在时会自动被打进 `usagi export`。
- 自定义调色板不适用于暂停菜单的颜色。

**推荐做法：使用自定义调色板时给自己的槽位命名。**
内置的 `gfx.COLOR_*` 常量是按 Pico-8 的槽位顺序命名的（槽位 9 = `COLOR_RED`）。换成自定义
调色板后，槽位 9 可能是深蓝或青色，名字与颜色就对不上了。请在项目顶部一次性定义自己的
常量，并在所有地方使用它们：

```lua
-- 例如 sweetie16
local COLOR = {
  NIGHT = 1, PURPLE = 2, RED = 3,    ORANGE = 4,
  YELLOW = 5, LIME = 6,  GREEN = 7,  TEAL = 8,
  NAVY = 9,  BLUE = 10,  SKY = 11,   CYAN = 12,
  WHITE = 13, SILVER = 14, GRAY = 15, SHADOW = 16,
}

gfx.clear(COLOR.NIGHT)
gfx.rect_fill(x, y, w, h, COLOR.RED)
```

工作流小贴士：`palette.png` 可以一键载入 Aseprite 的调色板面板（「Edit → Preferences →
Palette → Load」），因此同一个文件既驱动你的引擎颜色，也驱动你作画时用的色板。

可运行的演示见
[`examples/palette_swap`](https://github.com/brettchalupa/usagi/tree/main/examples/palette_swap)
（内含 sweetie16，并使用 `COLOR` 表来命名槽位）。

#### 自定义字体（`font.png`）

把 `font.png` 放在项目根目录，即可覆盖 `gfx.text` / `gfx.text_ex` /
`usagi.measure_text` 使用的内置 monogram 字体。该 PNG 是一个预先烘焙好的字形图集，
元数据以 zTXt 区块内嵌其中（见下文「烘焙」）。

覆盖范围有意收得很窄：

- **Lua 绘制的文本使用自定义字体。** 你用 `gfx.text` 或 `gfx.text_ex` 画的任何东西。
- **引擎 UI 使用内置字体。** 暂停菜单、FPS 浮层、错误浮层、工具窗口。这样即使你放了一个
  尺寸夸张的自定义字体，也不会破坏引擎布局。

字体的自然行高决定 `usagi.measure_text` 的结果与每个字形的定位，因此较小的自定义字体
（例如 Misaki Gothic 8×8）按 8 像素渲染，较大的字体（Silver 5×9）按 21 像素渲染，
两者在整数倍缩放时都很清晰。

**烘焙字体：**

```bash
usagi font bake <font.ttf> <size>
```

示例：

```bash
# 烘焙到当前项目（默认在当前工作目录写入 font.png）
usagi font bake my_font.ttf 12

# 对于覆盖汉字的字体，跳过汉字区块
usagi font bake misaki_gothic.ttf 8 --scripts all,-cjk

# 仅含韩文的图集（对不需要其它文字系统的游戏来说输出更小）
usagi font bake silver.ttf 18 --scripts latin,latin-ext,punct,korean

# 写入指定路径
usagi font bake silver.ttf 18 --out my_proj/font.png
```

行为：

- 请把字体的**自然设计尺寸**作为尺寸参数传入。像素字体只有在设计者绘制的尺寸上才能清晰
  光栅化；在其它尺寸渲染会经过 FreeType 的轮廓缩放器，看起来略微发虚。常见尺寸：
  monogram 用 `15`、Silver 用 `18`、Misaki Gothic 用 `8`、Geist Pixel 用 `16`。
- 默认包含所有受支持的文字系统（拉丁、拉丁扩展、希腊、西里尔、标点、箭头、数学运算符、
  制表符、几何图形、杂项符号、CJK 标点、平假名、片假名、谚文、半角/全角形式，以及 CJK
  统一表意文字）。字体的 cmap 未覆盖的码位会被跳过，因此用不到的文字系统不产生任何成本。
- 用 `--scripts` 收窄或扩展集合。传入以逗号分隔的名字列表；`all`（默认）和 `none` 是
  特殊值，`-` 前缀表示减去。已知名字：`latin`、`latin-ext`、`greek`、`cyrillic`、
  `punct`、`arrows`、`math`（别名 `math-ops`）、`box-drawing`（别名 `box`）、
  `geometric`（别名 `shapes`）、`symbols`（别名 `misc-symbols`）、`cjk-punct`、
  `hiragana`、`katakana`、`hangul`（别名 `korean`）、`cjk`（别名 `han`）、`halfwidth`。
  示例：`--scripts all,-cjk` 可去掉汉字（约 2.1 万个码位），
  `--scripts latin,korean` 则得到一个聚焦的图集。当字体覆盖这些内容时，
  箭头/数学/制表/几何/符号区块只会增加几 KB；不需要的减掉即可
  （例如 `--scripts all,-symbols`）。
- `--no-cjk` 是 `--scripts all,-cjk` 的废弃别名。它仍然可用，但会打印警告，并将在未来的
  大版本中移除。
- 输出是单个 `font.png`，元数据放在 zTXt 区块里。把它放在 `main.lua` 旁边，引擎就会自动
  加载。
- 烘焙是可复现的：同样的 TTF + 文字系统 + 尺寸会产出一模一样的字节。

项目放置后的行为：

- 缺少 `font.png` → 引擎使用内置的 monogram 字体（当前默认）。
- 存在时会自动被打进 `usagi export`。

**亚洲语言支持：** 内置的 monogram 字体覆盖拉丁 / 西里尔 / 部分希腊文，但不含 CJK。
要显示日文、中文或韩文，请找一个覆盖所需文字系统的像素字体并烘焙它：

```bash
# Silver：约 5x9，含较广的欧洲字符 + 约 8 千个汉字 + 约 2 千个谚文。
# 从 https://poppyworks.itch.io/silver 下载（CC-BY-4.0）。
usagi font bake Silver.ttf 18
# 把生成的 font.png 放到项目 main.lua 旁边。
```

一个可运行的、基于 Silver 的演示见
[`examples/custom_font`](https://github.com/brettchalupa/usagi/tree/main/examples/custom_font)，
它在同一屏上渲染英文、西里尔、希腊、日文和韩文。

#### 缩放精灵

`spr` / `spr_ex` 没有缩放参数，因为它们固定使用原生精灵尺寸。要绘制缩放后的精灵，请用
`sspr_ex`，并把目标尺寸设成与源尺寸不同：

```lua
-- 以 2 倍缩放把索引为 1 的精灵（16×16）画在 (x, y)。
local sz = usagi.SPRITE_SIZE
gfx.sspr_ex(0, 0, sz, sz, x, y, sz * 2, sz * 2, false, false, 0, gfx.COLOR_TRUE_WHITE, 1.0)
```

如果你发现自己经常用到这些变体，就封装起来。下面三个辅助函数能覆盖大多数游戏：

```lua
-- 按缩放绘制图集上的一个源矩形。不经过 `spr` 索引 ——
-- 源矩形请用 TilePicker 自己挑。
function sspr_scaled(sx, sy, sw, sh, dx, dy, scale)
  gfx.sspr_ex(
    sx, sy, sw, sh,
    dx, dy, sw * scale, sh * scale,
    false, false, 0, gfx.COLOR_TRUE_WHITE, 1.0
  )
end

-- 按从 1 开始的索引绘制精灵，围绕其中心旋转，原生尺寸。
function spr_rot(index, x, y, rotation)
  gfx.spr_ex(index, x, y, false, false, rotation, gfx.COLOR_TRUE_WHITE, 1.0)
end

-- 按从 1 开始的索引绘制精灵并染色，原生尺寸。
function spr_tinted(index, x, y, tint)
  gfx.spr_ex(index, x, y, false, false, 0, tint, 1.0)
end
```

引擎有意不随附这些，因为每个游戏在这方面的约定都略有不同（缩放是否只允许整数、旋转是否
绕中心以外的位置、染色的绘制是否还需要 alpha），强行给所有人一个固定形态弊大于利。
请复制并改写。

### `input`

抽象输入动作。每个动作都是键盘、手柄按键与左摇杆的并集；任何已连接的手柄都会触发所有动作，
因此 Steam Deck 内置手柄与外接手柄都能用，热插拔也是透明的。

- `input.pressed(action)` —— 仅在动作首次按下的那一帧为 true。用于一次性动作
  （开火、跳跃、菜单确认）。
- `input.held(action)` —— 动作按住期间为 true。用于移动、蓄力条、「按住跳过」提示。
- `input.released(action)` —— 仅在动作首次松开的那一帧为 true。用于蓄力-释放类机制
  （松手起跳、弹弓回拉）。

| 动作    | 键盘             | 手柄                                             |
| ------- | ---------------- | ------------------------------------------------ |
| `LEFT`  | 左方向键 / A     | 十字键左 / 左摇杆左                              |
| `RIGHT` | 右方向键 / D     | 十字键右 / 左摇杆右                              |
| `UP`    | 上方向键 / W     | 十字键上 / 左摇杆上                              |
| `DOWN`  | 下方向键 / S     | 十字键下 / 左摇杆下                              |
| `BTN1`  | Z / J            | 下方面键（Xbox A、PS Cross）、LB                 |
| `BTN2`  | X / K            | 右方面键（Xbox B、PS Circle）、RB                |
| `BTN3`  | C / L            | 上方 + 左方面键（Xbox Y/X、PS Triangle/Square）   |

`BTN1`/`BTN2`/`BTN3` 是抽象的动作按钮。BTN3 同时绑定上方和左方面键，因为这两个都比从
BTN1 的下方位置横跨十字键更好按。

**Nintendo Switch 面键交换。** 连接 Switch 手柄时，BTN1 由 A 键（右方面键）触发，BTN2 由
B 键（下方面键）触发，以符合任天堂「A 确认、B 取消」的约定。扳机（L/R）与 BTN3 不变。
该交换通过 `GetGamepadName` 自动完成；从你的游戏视角看，`input.pressed(input.BTN1)`
依然表示「主操作」。

`input.pressed` 与 `input.released` 在键盘、手柄按键与模拟摇杆上都做边沿检测。把摇杆推过
死区时，会在越过的那一帧触发一次按下；松回死区内时，会在那一帧触发释放。

#### 控制图标（感知输入源）

用于让 UI 提示适配玩家当前使用的设备：

- `input.mapping_for(action)`：当前输入源上 `action` 主绑定对应的字符串标签（例如键盘上是
  `"Z"`、Xbox 上是 `"A"`、PlayStation 上是 `"Cross"`、Switch 上是 `"A"`，因为任天堂把
  BTN1 交换到了它的 A 键）。手柄家族通过 `GetGamepadName` 自动识别。它会遵循玩家通过暂停
  菜单的 Configure Keys 流程设置的任何键位重映射。若 `action` 未知或当前输入源没有对应
  绑定，则返回 `nil`（罕见；只会在做了特殊重映射之后出现）。
- `input.last_source()`：字符串 `"keyboard"` 或 `"gamepad"`，表示最近触发任何已绑定动作的
  输入源。只有当**被绑定的**输入触发时才会切换，因此菜单键（Esc/Enter）和闲置活动不会让
  它翻转。
- `input.SOURCE_KEYBOARD`、`input.SOURCE_GAMEPAD`：用于和 `last_source()` 比较的对应字符串
  常量。

```lua
local btn = input.mapping_for(input.BTN1) or "?"
gfx.text("Press " .. btn .. " to jump", 10, 10, gfx.COLOR_WHITE)
```

#### 鼠标

- `input.mouse()` —— 返回光标在游戏空间像素下的 `x, y`（因此无论窗口尺寸或像素完美缩放
  如何，这些值都与 `gfx.*` 坐标对齐）。当光标位于信箱条上时，这些值会落在
  `0..usagi.GAME_W` / `0..usagi.GAME_H` 之外，因此做一次边界检查就是判断「光标不在游玩
  区域内」的惯用方式。见
  [`examples/mouse`](https://github.com/brettchalupa/usagi/blob/main/examples/mouse/main.lua)。
- `input.mouse_over()` —— 光标位于已绘制的游戏区域上时为 true；在窗口之外或信箱条上时为
  false。
- `input.mouse_held(button)` —— `button` 按住期间为 true。
- `input.mouse_pressed(button)` —— `button` 首次按下的那一帧为 true。
- `input.mouse_released(button)` —— `button` 首次松开的那一帧为 true。
- `input.mouse_scroll()` —— 每帧的垂直滚动增量。返回一个数字：本帧向上滚动为正、向下为
  负、无滚动为 `0`。在鼠标滚轮和触控板双指滑动上行为一致。请用 `> 0` / `< 0` 判断，而
  不要用 `== 1`，因为触控板会给出小数值：

  ```lua
  local s = input.mouse_scroll()
  if s > 0 then slot = math.max(1, slot - 1) end
  if s < 0 then slot = math.min(N, slot + 1) end
  ```

- `input.MOUSE_LEFT`、`input.MOUSE_RIGHT`、`input.MOUSE_MIDDLE` —— 支持的鼠标按键。
- `input.set_mouse_visible(visible)` —— 在游戏窗口上显示或隐藏操作系统光标。可以从 `_init`
  调用，在第一帧绘制前就隐藏光标（对自行绘制光标精灵的游戏很方便）。
- `input.mouse_visible()` —— 操作系统光标当前显示时为 true。它会同步反映最近一次
  `set_mouse_visible` 调用，因此来回切换时读取结果是一致的：
  `input.set_mouse_visible(not input.mouse_visible())`。

#### 直接读取键盘（如果你确实需要）

对于开发热键（切换调试浮层、截图、F 键快捷方式）以及纯键鼠游戏，你可以按按键读取原始键盘
状态：

- `input.key_pressed(key)` —— `key` 首次按下的那一帧为 true。
- `input.key_held(key)` —— `key` 按住期间为 true。
- `input.key_released(key)` —— `key` 首次松开的那一帧为 true。

```lua
if usagi.IS_DEV and input.key_pressed(input.KEY_F1) then
  State.show_debug = not State.show_debug
end
```

**在玩法逻辑中请克制使用。** 这些 API 有意绕过动作/键位映射系统，也就是说它们不会遵循
玩家在暂停菜单里做的按键重映射，也不会由手柄触发。任何玩家应当能重映射的东西，或手柄玩家
需要触及的东西，都应属于带抽象动作的 `input.held` / `input.pressed` / `input.released`。

可用常量（全部为 `input.KEY_*`）：字母 `A`–`Z`、数字 `0`–`9`、功能键 `F1`–`F12`、
`SPACE`、`ENTER`、`ESCAPE`、`TAB`、`BACKSPACE`、`DELETE`、方向键
（`LEFT`、`RIGHT`、`UP`、`DOWN`）、修饰键（`LSHIFT`、`RSHIFT`、`LCTRL`、`RCTRL`、
`LALT`、`RALT`），以及标点（`BACKTICK`、`MINUS`、`EQUAL`、`LBRACKET`、`RBRACKET`、
`BACKSLASH`、`SEMICOLON`、`APOSTROPHE`、`COMMA`、`PERIOD`、`SLASH`）。小键盘与导航键区
（Insert/Home/End/PgUp/PgDn）不对外暴露。

原始手柄读取（模拟摇杆、扳机、按索引访问单个面键）有意不暴露。抽象的
`input.held(input.BTN1)` 家族已覆盖手柄输入；如果你需要比这更细粒度的控制，那你大概已经
超出 Usagi 的适用范围了。请 fork 引擎，或者改用 Love2D！

### `sfx`

- `sfx.play(name)` —— 播放 `sfx/<name>.wav`。未知名字会静默地什么都不做。每个音效有 8 个
  可重叠的声部；第 9 次同时播放会抢占最旧的。
- `sfx.play_ex(name, volume, pitch, pan)` —— 发射后不管，参数按次生效。适合用同一个音效
  做出变化丰富的一次性效果，而不必额外提交 `.wav` 文件。三个参数全部必填：
  - `volume`（数字）—— 对暂停菜单音效音量的乘数，`0..1`。`1.0` 为恒等。会被钳制。
  - `pitch`（数字）—— 音高倍率。`1.0` 为恒等，`0.5` 低一个八度，`2.0` 高一个八度。
    配合 `math.random`，可以从单个 .wav 做出变化多端的脚步声 / 拾币声。
  - `pan`（数字）—— 立体声声像，`-1..1`。`-1` 左、`0` 中、`1` 右。会被钳制。
- `sfx.stop(name)` —— 停止 `name` 所有正在播放的声部。未知或未在播放的名字会静默地什么都
  不做。
- `sfx.stop_all()` —— 停止所有已加载音效的所有声部。
- `sfx.is_playing(name)` —— 若 `name` 的任一声部正在播放则为 `true`；未知或未在播放的名字
  为 `false`。

### `music`

从磁盘（或融合包）流式播放的背景音乐。同一时间只播放一首；在其它曲目播放时调用 `play`、
`loop` 或 `play_ex` 会先停止旧的。

- `music.play(name)` —— 播放 `music/<name>.<ext>` 一次，结束后停止。
- `music.loop(name)` —— 播放并无限循环。
- `music.stop()` —— 停止当前播放的任何内容。没有在播放时无操作。
- `music.play_ex(name, volume, pitch, pan, loop)` —— 以显式初始参数播放。`loop` 是布尔值
  （`true` 无限循环，`false` 播放一次）。其它参数语义同 `sfx.play_ex`。选定的
  volume / pitch / pan 会成为初始值，后续 `music.mutate` 以此为基准调制。
- `music.mutate(volume, pitch, pan)` —— 就地调制**当前正在播放**曲目的参数。替换语义：
  每次调用都设置绝对值，不叠加。没有在播放时无操作。可用于对白时压低音乐、受击硬直时扭曲
  音高，以及死亡时的淡出。volume / pitch / pan 的取值范围与 `sfx.play_ex` 相同。引擎出于
  设计不提供读取用的 getter。若想做补间，请在自己的游戏状态里记录这些值（见
  `examples/music`）。

四个 play / loop / stop / play_ex 调用都可以从 `_init` 调用，因此标题曲可以在窗口一打开
时就响起（无需等 `_update` 而空出一帧）。

可识别的扩展名：`.ogg`、`.mp3`、`.wav`、`.flac`。**音乐推荐使用 OGG，因为它体积小且跨
平台。**

文件名主干就是名字；`music/intro.ogg` 即 `music.play("intro")`。音乐与音效放在不同目录，
因为两者的格式与生命周期不同——音效是完整加载进内存并一次性的，音乐则在音频线程上增量
解码。

### `util`

开箱即用的数学与几何辅助函数。纯 Lua，无引擎状态，以全局 `util` 表提供。

接受结构化表的函数（向量 `{x, y}`、矩形 `{x, y, w, h}`、圆 `{x, y, r}`）会检查参数，并在
字段缺失时抛出指向**你的**调用点的错误，因此像 `util.rect_overlap({x=0, y=0, w=10})`
这样的笔误会给出
`util.rect_overlap: arg 1 table missing or non-numeric field 'h'`，而不是在辅助函数深处
爆出一堆让人困惑的 nil 算术。

**标量数学：**

- `util.clamp(v, lo, hi)` —— 把 `v` 钳制到 `[lo, hi]`。
- `util.sign(v)` —— 返回 `-1`、`0` 或 `1`。Lua 没有内置这个。
- `util.round(v)` —— 四舍五入（半分向上）到最接近的整数。绘制时对世界坐标做像素对齐，
  可让精灵保持清晰。
- `util.approach(current, target, max_delta)` —— 让 `current` 朝 `target` 移动，最多移动
  `max_delta`。传入按 `dt` 缩放的增量即可与帧率无关
  （`util.approach(p.vx, target, accel * dt)`）。
- `util.lerp(a, b, t)` —— 线性插值；`t = 0` → `a`，`t = 1` → `b`，`[0, 1]` 之外的值会外推。
- `util.wrap(v, lo, hi)` —— 把 `v` 环绕进 `[lo, hi)`。对负值也安全。
- `util.flash(t, hz)` —— 由时间得出的布尔值，每秒翻转 `hz` 次。
- `util.remap(v, start_a, end_a, start_b, end_b)` —— 把 `v` 从 `[start_a, end_a]` 映射到
  `[start_b, end_b]`。

**向量：** 全部接受 `{x, y}` 表且为纯函数（绝不修改输入）。

- `util.vec_normalize(v)` —— `v` 是一个 `{x, y}` 向量。返回一个新的单位长度 `{x, y}`。
  输入零则输出零（不会除零）。
- `util.vec_dist(a, b)` —— 点 `a` 与 `b` 之间的直线距离，各为 `{x, y}` 表。
- `util.vec_dist_sq(a, b)` —— `{x, y}` 点 `a` 与 `b` 之间的距离平方。用于「X 是否比 Y 更
  近？」这类热循环时省掉 sqrt；请与 `r * r` 比较。
- `util.vec_from_angle(angle, len)` —— `angle` 为弧度，`len` 为模长（可选，默认 1）。
  返回 `{x, y}` 向量。配合 `math.atan(dy, dx)` 可把方向转成速度。

**几何重叠：** 表参数为点/向量 `{x, y}`、矩形 `{x, y, w, h}`（左上角原点）与圆
`{x, y, r}`（圆心 + 半径）。全部返回布尔值。

- `util.point_in_rect(p, r)` —— 点 `p` `{x, y}` 是否在矩形 `r` `{x, y, w, h}` 内？
  每个轴上是半开区间 `[x, x+w)`：上/左边缘算在内，下/右边缘算在外。
- `util.point_in_circ(p, c)` —— 点 `p` `{x, y}` 是否在圆 `c` `{x, y, r}` 内？
  边界算在外（与 `circ_overlap` 一致）。
- `util.rect_overlap(a, b)` —— 矩形 `a` 与 `b`（`{x, y, w, h}`）是否重叠？AABB 检测；
  边相邻的矩形不算重叠。
- `util.circ_overlap(a, b)` —— 圆 `a` 与 `b`（`{x, y, r}`）是否重叠？相切的圆不算重叠。
- `util.circ_rect_overlap(c, r)` —— 圆 `c` `{x, y, r}` 与矩形 `r` `{x, y, w, h}` 是否
  重叠？用最近点法判断。

**缓动：** 全部接受 `a, b, progress` 参数且为纯函数（绝不修改输入）。`a` 是起点，`b` 是你
想抵达的点，`progress` 是动画的时间进度（介于 0 与 1 之间）。`progress` 从不被钳制。

- `util.ease.sine_in(a, b, progress)` —— 正弦缓入。
- `util.ease.sine_out(a, b, progress)` —— 正弦缓出。
- `util.ease.sine_in_out(a, b, progress)` —— 正弦缓入缓出。
- `util.ease.circ_in(a, b, progress)` —— 圆形缓入。
- `util.ease.circ_out(a, b, progress)` —— 圆形缓出。
- `util.ease.circ_in_out(a, b, progress)` —— 圆形缓入缓出。
- `util.ease.expo_in(a, b, progress)` —— 指数缓入。
- `util.ease.expo_out(a, b, progress)` —— 指数缓出。
- `util.ease.expo_in_out(a, b, progress)` —— 指数缓入缓出。

### `usagi`

引擎层面的信息。

- `usagi.GAME_W`、`usagi.GAME_H` —— 游戏渲染尺寸（320、180）。
- `usagi.SPRITE_SIZE` —— `sprites.png` 中单个格子的边长（像素，默认 16，由 `sprite_size`
  配置设定）。做瓦片网格数学时请用它，而不是硬编码 16：
  `gfx.spr(idx, col * usagi.SPRITE_SIZE, row * usagi.SPRITE_SIZE)`。
- `usagi.IS_DEV` —— 在 `usagi dev` 下运行时为 `true`；在 `usagi run` 以及导出的二进制内
  为 `false`。适合用来控制调试浮层、开发菜单、冗长日志：

  ```lua
  if usagi.IS_DEV then
    gfx.text("debug", 0, 0, gfx.COLOR_GREEN)
  end
  ```

- `usagi.IS_RELEASE` —— `usagi.IS_DEV` 的反面。在只想让发布版执行的代码里，它比
  `not usagi.IS_DEV` 更好读。
- `usagi.elapsed` —— 自会话启动以来的壁钟秒数，每帧在 `_update` 之前更新一次。帧内稳定
  （同一帧内每次读取都返回相同值）。它会在[重置](#重置)后继续累计；如果你需要按「每局」
  计时的计时器，请在 `_init` 中自建计数器。
- `usagi.measure_text(text)` —— 返回两个值 `width, height`（像素），是 `text` 用内置字体
  渲染后的尺寸。纯工具函数（无渲染）；可从 `_init` 调用预先算好布局，也可从 `_update` /
  `_draw` 调用处理动态字符串。

  ```lua
  local w, h = usagi.measure_text("Game Over")
  gfx.text("Game Over", (usagi.GAME_W - w) / 2, (usagi.GAME_H - h) / 2,
           gfx.COLOR_WHITE)
  ```

- `usagi.save(t)` —— 把 Lua 表序列化为 JSON 并持久化。存档按游戏隔离（以 `game_id` 配置
  划分命名空间），因此不同 Usagi 游戏不会互相覆盖。
- `usagi.load()` —— 返回此前保存的表；首次运行时返回 `nil`。

  ```lua
  -- usagi.conf: name = My Game / game_id = com.you.mygame

  function _init()
    State = usagi.load() or { score = 0, best = 0 }
  end

  function _update(dt)
    -- ... 玩法逻辑更新 State.score、State.best ...
    usagi.save(State)  -- 想持久化时随时调用
  end
  ```

  存档就是一个 JSON 文件。请把你自己的结构（设置、解锁、本局状态）嵌套在里面。引擎层面
  没有「存档槽」的概念。

  存档位置：
  - Linux：`~/.local/share/<game_id>/save.json`
  - macOS：`~/Library/Application Support/<game_id>/save.json`
  - Windows：`%APPDATA%\<game_id>\save.json`
  - Web：`localStorage`，键为 `usagi.save.<game_id>`

  `game_id` 是形如 `com.brettmakesgames.snake` 的反向 DNS 字符串。存档 / 读档需要它，
  但从不持久化任何东西的游戏可以不设。

  原生平台上的写入是原子的（`save.json.tmp` + 重命名），因此写入中途崩溃会保留上一份存档
  完好。JSON 值必须可表示：表、字符串、数字、布尔、nil。函数、userdata、NaN 和循环引用
  的表会抛错。

  **表的键必须全部是字符串（映射），或者是一个稠密的 `1..n` 整数数组。** JSON 没有以整数
  为键的映射类型，因此像 `{[6]=1, [7]=2}` 这样的稀疏整数键，以及像
  `{[1]="x", [3]="z"}` 这样有空洞的数组，都会抛出明确的错误，而不是被静默截断。如果你想
  要以整数索引的映射，请把键转成字符串（`{[tostring(level)] = time}`）；如果你想要列表，
  请填满 `1..n`。

### 加载游戏数据：JSON 与文本

把任意游戏数据（关卡、对白、可调配置）放在项目根目录的 `data/` 目录下。`usagi export` 会
打包整棵目录树，因此同一路径在开发环境和导出构建中解析结果完全一致。

- `usagi.read_json(path)` —— 读取 `data/<path>` 作为 JSON，返回 Lua 表。JSON 数组会作为
  从 1 开始索引的 Lua 数组返回；JSON 对象会作为字符串键的表返回。JSON 格式错误、文件缺失
  或包含非 UTF-8 字节时会响亮报错。
- `usagi.read_text(path)` —— 读取 `data/<path>` 作为 UTF-8 字符串。用于手写格式：CSV
  网格、对白脚本，以及任何你想自己在 Lua 里解析的东西。

路径是以正斜杠分隔、相对于 `data/` 的相对路径。嵌套子目录也可以
（`data/levels/01.json` → `usagi.read_json("levels/01.json")`）。反斜杠、绝对路径和 `..`
片段会在虚拟文件系统边界被拒绝，因此恶意或有 bug 的路径无法逃出 `data/`。

```lua
-- usagi.conf: name = Tile Demo

-- 在代码块顶部读取，这样热重载就能接受对 JSON 的修改，无需按 F5。
-- 每当任何数据文件的 mtime 变化时脚本都会重新运行，与任何 .lua 文件的行为相同。
local levels = usagi.read_json("levels.json")
local intro  = usagi.read_text("dialog/intro.txt")

function _draw(_dt)
  gfx.clear(gfx.COLOR_BLACK)
  gfx.text(intro, 4, 4, gfx.COLOR_WHITE)
  -- ... 遍历 `levels` ...
end
```

热重载：保存 `data/` 下任何文件都会触发与保存 `.lua` 相同的脚本重跑。状态全局变量
（在 `_init` 中设置的首字母大写变量）会在重载中保留；如果你想要真正的重置，请按 F5。
打包构建没有 mtime，因此热重载只是开发期的便利；导出的游戏从包中读取一次。

CSV 请用 `read_text` + Lua 拆分。三行 `string.gmatch` 就能覆盖简单网格的情况
（见 `examples/level_from_csv/`）。

### 把 Lua 表编码为 JSON

`usagi.to_json(t)` 为任何 Lua 表返回一个格式化良好的 JSON 字符串。它与 `usagi.save` 共用
同一个校验器，因此形状规则相同：键要么全是字符串，要么是稠密的 `1..n` 整数数组；函数、
userdata、NaN 和循环引用会带着清晰的错误信息抛错。

当你想绕过存档文件直接得到 JSON 时很有用：游戏内开发工具浮层、结构化 stdout 日志、临时的
状态检查，或把数据喂给另一个工具。若你想往返一圈，可与 `usagi.read_json` 搭配；而当你想要
的是一个可以 `require` 的 Lua 表，或一个能容忍循环引用与混合键表的宽松美化打印时，请改用
`usagi.dump`。

```lua
local payload = { score = 200, run = { seed = 42, deaths = 1 } }
print(usagi.to_json(payload))
-- {
--   "score": 200,
--   "run": { "seed": 42, "deaths": 1 }
-- }
```

可运行的演示见 `examples/to_json.lua`。

### 效果：卡帧、屏幕震动、闪光、慢动作

`effect.*` 模块提供四个引擎级的打击感图元。每个都只需从 `_init` / `_update` / `_draw`
的任意位置调用一次；引擎每帧对它们做衰减，并把它们接入更新 / 渲染循环中的正确时点，因此你
不必把震动偏移一路传到绘制里，也不必用冻结标志去卡 `_update`。

```lua
effect.hitstop(0.06)                     -- 冻结 _update 60 毫秒
effect.screen_shake(0.3, 4)              -- 震动 0.3 秒，最大 4 个游戏像素
effect.flash(0.1, gfx.COLOR_WHITE)       -- 白色闪光，100 毫秒内淡出
effect.slow_mo(1.5, 0.3)                 -- 1.5 秒内以 30% 速度运行
```

- **`effect.hitstop(time)`** 在 `time` 秒内跳过对 `_update` 的调用。`_draw` 仍会运行，
  因此世界仍留在屏幕上。
- **`effect.screen_shake(time, intensity)`** 偏移从渲染目标到窗口的 blit。`intensity` 是
  以**游戏像素**计的最大偏移（试试 2-6）；幅度线性衰减到零。绘制在世界之外的元素（引擎
  错误浮层、REC 指示器）保持锚定不动。
- **`effect.flash(time, color)`** 在 `_draw` 输出之上绘制一层全屏的调色板 `color` 浮层。
  Alpha 从不透明衰减到透明。受击用白色，受伤用红色。
- **`effect.slow_mo(time, scale)`** 把传给 `_update` 的 `dt` 乘以 `scale`。`scale=0.5`
  是半速，`scale=2.0` 是双速，`scale=0` 会冻结（那种意图请用 `effect.hitstop`）。slow_mo
  的计时器本身按真实壁钟倒数，因此这段「电影感」总会准时结束。
- **`effect.stop()`** 结束所有正在运行的效果；在场景或状态之间切换时很有用。

**叠加。** 四者通用规则：时长更长者胜；幅度参数以最近一次调用为准。
先 `effect.screen_shake(0.1, 2)` 再 `effect.screen_shake(0.5, 4)`，结果是 0.5 秒、强度 4。
疯狂重复调用是安全的。

**暂停。** 当引擎暂停浮层打开时，效果计时器不会走，震动在「PAUSED」视图下也被抑制，因此
游戏被挂起期间既不会衰减也不会抖动。

可运行的演示见
[`examples/effect.lua`](https://github.com/brettchalupa/usagi/blob/main/examples/effect.lua)
（每个图元一个按键，外加一个组合按钮）。

### 着色器（进阶）

后处理 GLSL 片元着色器在游戏的渲染目标被 blit 到窗口时作为最后一道工序运行。可用于 CRT
效果、调色板交换、暗角、调色分级等等。

截图捕获有一个已知限制（见下文）。

API：

- `gfx.shader_set("name")`：激活 `shaders/<name>.fs`（以及可选的
  `shaders/<name>.vs`）。
- `gfx.shader_set(nil)`：清除当前着色器。
- `gfx.shader_uniform("u_name", v)`：排入一次 uniform 写入。`v` 可以是数字（float），
  也可以是长度为 2/3/4 的数字表（vec2/vec3/vec4）。动画值请在 `_update` 或 `_draw` 里
  每帧调用。

```lua
function _init() gfx.shader_set("crt") end

function _draw(_dt)
  gfx.shader_uniform("u_time", usagi.elapsed)
  gfx.shader_uniform("u_resolution", { usagi.GAME_W, usagi.GAME_H })
  -- ... 你平常的 gfx.* 调用 ...
end
```

**跨平台着色器文件。** 桌面 GL 目标编译 GLSL `#version 330`。GLES 目标——Web 构建和
Linux ARM（树莓派）构建——使用 GLSL ES `#version 100`（WebGL 1 / GLES 2）。请并排放两个
文件以同时支持两者：

- `shaders/<name>.fs`：桌面版，`#version 330`，`in`/`out`，`texture(...)`，
  自定义 `out vec4 finalColor`。
- `shaders/<name>_es.fs`：GLES 版，`#version 100`，`precision mediump float;`，
  `varying`，`texture2D(...)`，`gl_FragColor` 输出。

GLES 目标优先使用 `_es.fs` 并回退到 `.fs`；桌面 GL 则相反。若只提供了一个，所有加载它的
平台都会跑那一个，因此如果你想支持树莓派和 Web，请务必附带 `_es.fs` 变体。
`fragTexCoord`、`fragColor` 和 `texture0` 输入在两种目标上都由 raylib 提供。
可运行的 CRT 效果示例见 `examples/shader/`，其中还有一个 Game Boy 调色板交换，
每个效果都含两种变体。

**热重载。** 保存当前生效着色器的 `.fs` 或 `.vs` 文件会就地重建它。已缓存的 uniform 会被
重放到新着色器上。编译错误会打印到终端，并继续使用上一个着色器运行。

**打包。** `usagi export` 会遍历 `shaders/` 并把每个 `.fs` / `.vs` 都打进包里，因此在
`usagi dev`、`usagi run`、`.usagi` 文件以及各平台的融合 exe 中，着色器的行为完全一致。

**截图不包含着色器。** F8 / Cmd+F 截图与 F9 / Cmd+G GIF 录制读取的是未着色处理的游戏渲染
目标，因此后处理效果会出现在屏幕上，但不会出现在保存的文件里。权衡是：着色器以窗口分辨率
运行（CRT 扫描线看起来平滑而非块状），而捕获内容保持在游戏的 320x180 网格上，产出干净、
易分享的素材。如果你需要把着色器烘进捕获结果，请用操作系统的录屏或截屏工具对着游戏窗口
操作。

着色器资源：

- [Raylib 着色器演示](https://www.raylib.com/examples/shaders/loader.html?name=shaders_postprocessing)
- [Raylib 着色器源码](https://github.com/raysan5/raylib/blob/master/examples/shaders/shaders_postprocessing.c)

### 索引方式

序列风格的 API（`gfx.spr`）是**从 1 开始**的，以符合 Lua 惯例（`ipairs`、`t[1]`、
`string.sub`）。`gfx.spr(1, ...)` 绘制左上角的精灵。

调色板常量同样从 1 开始：`gfx.COLOR_BLACK` 是 `1`，`gfx.COLOR_RED` 是 `9`。Pico-8 里
熟悉的 `0..15` 编号被整体上移一位，这样槽位索引可以直接当作 Lua 数组下标使用。槽位 `0`
以及任何高于当前调色板长度的索引都会渲染为品红哨兵色。

### 随机数

Lua 的 `math.random` 可直接使用。Lua 会在启动时自动为 PRNG 播种，因此每次运行
`usagi dev` / `usagi run`（以及每次启动导出的二进制）都会产生新的序列。调用
`math.random()` 前无需任何引擎调用。

```lua
local n = math.random(1, 100)   -- [1, 100] 内的整数
local f = math.random()         -- [0, 1) 内的浮点数
```

如果你想要确定性的序列（回放、测试、可复现的关卡生成），请在 `_init` 中调用标准 Lua 的
`math.randomseed(n)`。一个小演示见
[`examples/rng.lua`](https://github.com/brettchalupa/usagi/blob/main/examples/rng.lua)。

### 从 Pico-8 过来？

看看
[`./examples/pico8`](https://github.com/brettchalupa/usagi/tree/main/examples/pico8)，
了解如何放入一个 `pico8.lua`、`require "pico8"`，从而得到大量与 Pico-8 同名的函数。

Pico-8 兼容层让你可以写 Pico-8 那样的代码：

```lua
-- 检查输入
if btn(0) then
  State.p.x = State.p.x - State.p.spd * dt
end

-- 从 sprites.png 绘制精灵
spr(0, 20, 30)
```

## 快捷键

- 按 **~**（反引号/波浪号）切换 FPS 浮层。在 `dev` 下默认隐藏。
- 按 **Alt+Enter** 切换无边框全屏。该设置持久化在 `settings.json` 中，并在下次启动时于
  第一帧之前生效。按设计不提供 Lua 或配置接口；这是玩家自己的设置。
- 按 **Esc**、**P** 或手柄 **Start** 暂停。同样的按键（外加 **BTN2**）可关闭菜单。暂停
  期间 `_update` 被跳过，但 `_draw` 仍每帧运行，暂停浮层绘制在最上层。音乐在菜单打开时
  暂停，关闭时继续。
- 在开发模式下按 **Shift+Esc** 退出游戏。
- 引擎会在内存中始终保留最近约 5 秒（默认值，见「配置」中的 `gif_length`）的游戏画面。
  按 **F9** 或 **Cmd/Ctrl + G** 把该缓冲区写成 GIF，输出到用户下载目录，命名为
  `<game>-YYYYMMDD-HHMMSS.gif`（`<game>` 是你的 `game_id` 配置的短形式，例如
  `~/Downloads/snake-20260101-120000.gif`）。文件会放大 2 倍（640×360），以便在线嵌入时
  看得清楚。这是滚动缓冲区：要在精彩瞬间**之后**再触发保存，而不是之前。逐帧时间反映真实
  的帧 dt，并被钳制到 30fps 下限，因此卡顿的游戏生成的 GIF 播放速度与游戏实际运行速度
  一致。
- 按 **F8** 或 **Cmd/Ctrl + F** 把 PNG 截图保存到同一个下载位置。与 GIF 录制器相同的 2 倍
  放大，无损，调色板精确。
- 按 **Shift+M** 切换音频静音。音量在 `0.0` 与 `settings.json` 中存的值之间切换（音乐与
  音效在首次启动时都默认为 `1.0`，之后跟随玩家通过暂停菜单设置的值）。设置与
  `save.json` 位于同一个按游戏隔离的操作系统数据目录；在 Web 上则通过
  `localStorage` 中的 `usagi.settings.<game_id>` 路由。

### 编写利于热重载的脚本

所有 Lua 代码块在保存时都会重新执行，因此任何顶层的 `local` 绑定都会在自动重载时被重新
绑定。在模块作用域写 `local State` 会在每次保存时被重置为一个全新的表，从而摧毁正在运行
的游戏；它必须是全局的。模式如下：

- **可变的游戏状态** → 单一的、首字母大写的全局变量，惯例上是 `State`，只在 `_init` 中
  赋值。`_init` 在启动时以及[重置](#重置)时各运行一次，因此该表的寿命超过重载。保存代码
  改动可以让进行中的游戏保持完整。
- **常量** → 文件作用域的 `local`。每次重载重新绑定到相同的值是无害的。
- **引入的模块** → 要么文件作用域 `local Foo = require("foo")`，要么在你想让 `Foo` 无需
  重复 require 就能从每个文件访问时，用首字母大写的全局 `Foo = require("foo")`。两种都
  可行；全局形式对 `Player`、`Enemy` 这类引擎级表很方便。

总体建议：如果你希望某个东西跨越热重载保留下来，就把它放进 `State`。如果你在调某个东西、
希望看到它自动变化，就把它留在原地。

`usagi init` 生成的 `.luarc.json` 启用了 `lowercase-global` 诊断，用来抓住最常见的坑：
忘记写 `local`，无意间创建了名为 `score`、`timer` 之类的全局变量。凡是你真的想做成全局的
东西就首字母大写；小写的顶层赋值会给出警告。

一些示例见
[`examples/hello_usagi.lua`](https://github.com/brettchalupa/usagi/blob/main/examples/hello_usagi.lua)
与
[`examples/input.lua`](https://github.com/brettchalupa/usagi/blob/main/examples/input.lua)。

### 重置

Usagi 会监视正在运行的脚本文件，并在你保存时重新执行它。新的 `_update` 与 `_draw` 会在
下一帧生效。你当前的游戏状态可以跨越重载**得以保留**，这样你就能在游玩途中调整逻辑而不
丢失进度。

- 保存触发的热重载**不会**调用 `_init()`。

按 **F5**（或 **Ctrl+R** / **Cmd+R**）执行硬重置。暂停菜单中的 **Reset Game** 项效果
相同。重置会重新运行 `_init()`，因此你在其中构建的一切都会从头开始，同时不影响会话的其余
部分。

重置会清掉什么：

- `State` 以及你在 `_init` 中赋值的任何其它全局变量，因为 `_init` 会重新运行。
- 进行中的引擎效果：`effect.flash`、`effect.screen_shake`、`effect.hitstop`、
  `effect.slow_mo`。它们在 `_init` 运行之前就被清除，以便新一局可以注册新的效果。
- Lua 中的 `usagi.menu_item` 注册。如果你用到了它们，请在 `_init` 内部重新注册。

重置不会碰什么：

- `usagi.elapsed` 会从会话开始持续累计。若需要按「每局」计时的计时器，请在 `_init` 中
  自建计数器。
- 正在播放的音乐和音效。如果你希望重置时静音，请在 `_init` 中停止它们。
- 磁盘上的状态：存档数据、暂停菜单音量、全屏设置，以及键盘 / 手柄重映射。
- 已加载的素材（`sprites.png`、音效、音乐）。
- `_init` 之外的任何 Lua 状态。虚拟机本身不会被拆除，因此在其它地方赋值的文件作用域
  local 与全局变量会跨重置保留，除非 `_init` 覆盖它们。

你也可以利用 `usagi.IS_DEV` 在重置时设置你的 `State`，让自己停留在想要快速打磨的某个
场景或配置里。

## 示例

[在 Codeberg 上查看示例。](https://codeberg.org/brettchalupa/usagi/src/branch/main/examples)

有一系列示例演练了完整的 Usagi API，你可以浏览并改写。它们的源码全部属于公有领域，随你
怎么用。

[Bomberfrog: Alpha](https://github.com/brettchalupa/bomberfrog/tree/alpha.1) 是一个用
Usagi 做成的完整射击游戏，你可以参考它，或把它当作自己游戏的起点。它包含场景切换、
仅开发期可用的功能、分数记录等等。

[SokoWorld](https://github.com/brettchalupa/sokoworld) 是一个用 Usagi 做的推箱子解谜
游戏，含自定义关卡解析代码、场景切换与存档数据记录。

## 工具

![Usagi 工具窗口，显示选中了 TilePicker，并有 Hexany Ives 制作的怪物精灵](./website/tools.png)

`usagi tools [path]` 会打开一个 1280×720 的窗口，带标签栏用于切换可用工具。路径是可选的；
传入项目目录（或一个 `.lua` 文件）即可加载它的 `sprites.png` 和 `sfx/` 素材。不给路径时
工具以空状态打开。

通过标签按钮或按键切换工具：**1**（点唱机）、**2**（瓦片拾取器）、**3**（存档检查器）、
**4**（调色板）。

点唱机与瓦片拾取器会热重载各自的素材：往 `sfx/` 里丢一个新的 WAV，或保存一张新的
`sprites.png`，工具会在下一帧接收。

### 点唱机

列出 `<project>/sfx/` 下的每个 `.wav` 并让你试听。选中的声音会在选择变化时自动播放
（Pico-8 音效编辑器的风格），因此你只要按方向键上下走过列表就能逐个听到。

- **上** / **下** 或 **W** / **S** 选择。
- **空格** 或 **回车** 重播当前选择。
- 点击名字即选中 + 播放。
- 点击右窗格中的 **Play** 按钮重播。

### 瓦片拾取器

显示 `<project>/sprites.png`，并叠加与 `gfx.spr` 匹配的、从 1 开始的网格。点击某个瓦片
复制它的索引，或按住右键拖动来框选一个矩形用于 `sspr`。当前选择显示在标题栏中，并在图集
上高亮。

- **WASD**、按住**鼠标中键**拖动，或按住**空格**并用鼠标左键拖动来平移。**Q** / **E**
  或**滚轮**缩小 / 放大（0.5×–20×）。滚轮缩放以光标为锚点，因此鼠标下的像素保持不动。
  **0** 重置视图。
- **R** 切换网格与索引浮层。
- **B** 循环切换视口背景色（灰 / 黑 / 白），让瓦片在任何调色板下都看得清。
- **左键点击**某个瓦片复制它从 1 开始的 `spr` 索引。
- **右键点击 + 拖动**框选一个与瓦片对齐的矩形，并复制形如 `sx,sy,sw,sh` 的内容，可直接
  粘贴进 `gfx.sspr(...)`。拖动方向无关紧要；矩形会被归一化并钳制在图集范围内。
- 当你把光标移到图像上时，标题栏会显示当前选择以及光标处的图集像素坐标。

### 存档检查器

读取项目的 `game_id` 配置，把当前 `save.json` 的内容与解析出的文件路径一起显示出来。
适合调试存档格式，以及不必离开编辑器就能在两次运行之间检查状态。

- 存档 JSON 按原样显示；引擎在写入时已经做过美化。
- **R** 或 **Refresh** 按钮会从磁盘重新读取文件；检查器不会自动轮询，因此在运行中的游戏
  保存之后，请手动刷新。
- **Clear** 删除存档文件。下次 `usagi.load()` 会返回 `nil`。
- **Open in File Manager** 用操作系统默认文件管理器打开所在目录（Linux 上 `xdg-open`，
  macOS 上 `open`，Windows 上 `explorer`）。

### 调色板

展示 16 个默认颜色或你自定义的 `palette.png` 中每种颜色的色块，点击即可把对应的 Lua 值
复制到剪贴板。

### 自带工具

Usagi 不包含精灵编辑器、音效生成器或音乐跟踪器。你可以在
[opengameart.org](https://opengameart.org/) 和 [itch.io](https://itch.io) 上找到可用素材，
也可以自己做。下面是一些与 Usagi 配合良好的工具，值得一看：

- **精灵编辑器**：
  - [Aseprite](https://www.aseprite.org/)：出色的像素画编辑器
  - [Piskel](https://www.piskelapp.com/)：免费的在线精灵编辑器
- **声音**：
  - [jsfxr](https://sfxr.me/)：8 位音效生成器；可下载 WAV
  - [1BITDRAGON](https://1bitdragon.com/)：易上手的音乐创作工具
- **地图编辑器**：
  - [Tiled](https://www.mapeditor.org/)：免费开源的地图编辑器，支持导出 Lua

## 导出

`usagi export <path>` 把游戏打包以便分发。默认输出包含全部平台外加一个可移植包：

```
$ usagi export examples/snake
$ tree export
export
├── snake-linux.zip          # Linux x86_64 融合 exe
├── snake-linux-aarch64.zip  # Linux arm64 融合 exe（树莓派、ARM 单板机、ARM 掌机）
├── snake-macos.zip          # macOS 通用（Apple Silicon + Intel）融合 exe
├── snake-windows.zip        # Windows x86_64 融合 exe
├── snake-web.zip            # Web 导出：index.html + usagi.{js,wasm} + game.usagi
└── snake.usagi              # 可移植包（usagi run snake.usagi）
```

或用 `--target` 只挑一个：

```
$ usagi export examples/snake --target web
$ usagi export examples/snake --target windows
$ usagi export examples/snake --target bundle
```

### macOS 注意事项

导出的 `.app` 包未签名，因此首次启动会被 Gatekeeper 拦截：玩家需要右键点击应用并选择
Open（否则 macOS 会提示它已损坏或来自未识别的开发者）。这是每次下载后的一次性步骤。

macOS 还可能在启动时请求麦克风权限。那是音频引擎在初始化 Core Audio，并不是 Usagi 在
读取麦克风（它从不读取）。玩家可以点击 Don't Allow，声音依然正常。

### 跨平台模板

非宿主平台来自随每个 Usagi 版本一同发布的「运行时模板」。CLI 在首次使用时获取它们，按
操作系统缓存，并在解压前用对应的 `sha256` 附属文件校验每个归档。

- **缓存位置**：Linux `~/.cache/usagi/templates/`，macOS
  `~/Library/Caches/com.usagiengine.usagi/templates/`，Windows
  `%LOCALAPPDATA%\usagiengine\usagi\cache\templates\`。
- **查看 / 清除**：`usagi templates list`、`usagi templates clear`。
- **强制重新下载**：`--no-cache`。
- **镜像或 fork**：设置 `USAGI_TEMPLATE_BASE` 覆盖默认的 GitHub Releases 基础 URL。

宿主平台始终可离线工作。Linux x86_64 上运行 `usagi export --target linux`（或
`--target all` 中的 linux 部分）会直接与正在运行的二进制做融合：不查缓存，不走网络。
首次跨平台导出需要联网；之后都是离线。

也可以显式覆盖模板来源：

- `--template-path PATH/TO/usagi-<ver>-<os>.{tar.gz|zip}` 指向本地归档。跳过校验与缓存。
- `--template-url https://example.com/usagi-...` 从任意 URL 获取。校验仍会执行（该 URL
  必须有同目录的 `.sha256`）。

### 为不受支持的平台构建

Usagi 为 Linux x86_64、Linux aarch64、macOS 通用（Apple Silicon 与 Intel）、
Windows x86_64 以及 Web（wasm）发布二进制。如果你使用的平台不在其中（比如 FreeBSD），
官方下载无法工作，但你可以从源码构建引擎并为自己导出游戏：

1. 获取你想要的版本的源码。要么克隆仓库并 `git checkout v<version>`，要么从
   [发布页面](https://codeberg.org/brettchalupa/usagi/releases)下载源码归档。
2. 用 `cargo build --release` 构建。各平台的前置依赖见
   [DEVELOPING.md](DEVELOPING.md#dependencies)（Windows 尤其需要 vcpkg + zlib）。
3. 用 `target/release/usagi` 处的二进制来开发和导出：

   ```sh
   target/release/usagi export path/to/game
   ```

在发布集合之外的宿主上，`usagi export`（默认 `--target all`）还会在四个已发布平台的 zip
之外，额外生成一个名为 `<slug>-<os>-<arch>.zip` 的宿主融合 zip。若你只想要那个 zip 而不
去获取跨平台模板，请用 `--target host`。

宿主 zip 只能在你构建所用的同一操作系统/架构上运行；要发布到多个不受支持的平台，需要在
每个平台上分别构建引擎。

### Web 外壳

Web 导出会附带一个承载 canvas 的默认 HTML 页面。要使用自定义页面，请在 `main.lua` 旁边
放一个 `shell.html`，`usagi export` 会自动采用。也可用 `--web-shell PATH` 按构建覆盖。

### 说明

- 原生 zip 里是一个以项目命名的融合可执行文件（Windows zip 中命名为 `<name>.exe`）。
  Web zip 解压后直接提供服务即可。
- `<name>` 是项目目录名（对于扁平的 `.lua` 文件则是脚本主干名）。`-o <path>` 覆盖输出
  位置。
- 导出产物中热重载被禁用；[重置](#重置)仍会重新运行 `_init()`。
- 融合格式简单且可追加：exe 末尾的一个魔数尾部指回附加在后面的包。`.usagi` 文件就是同样
  的包字节但去掉尾部，它可以通过 `usagi run` 在任何平台运行。

## 移植到 Love2D

当一个项目超出 Usagi 的适用范围时（你想要 iOS / Android、四个动作按钮、完整的 Love2D
模块面），有一条一次性移植路径通向 [Love2D](https://love2d.org) 11.5。

```sh
usagi loveify path/to/your-game path/to/your-game-love
cd path/to/your-game-love
love .
```

`usagi loveify` 会遍历源码目录，为兼容 LuaJIT 改写复合赋值运算符
（`x += 1` → `x = x + (1)`），原样复制所有素材，并放入 Love 垫片运行时：
`usagi_shim.lua`（约 1800 行纯 Lua，基于 Love 的 API 重新实现 `gfx.*`、`input.*`、
`sfx.*`、`music.*`、`usagi.*`、`util.*`、`effect.*`，以及自定义 font.png + palette.png
的路径），外加一个 `conf.lua`（抑制 Love 默认的 800×600 窗口，让你配置的
`game_width / game_height` 在启动时生效）。如果你的源码没有自定义 `font.png`，引擎内置的
monogram 字体也会一并放入，这样 `gfx.text` 开箱即能清晰渲染。拒绝覆盖已存在的目标目录。

这被设计为**一次性操作**。移植之后，你的游戏就从 Usagi「毕业」了：你保留玩法代码，但垫片
文件与项目布局归你所有，后续改动发生在你的 fork 里，而不是靠重新运行 `loveify`。你可以
编辑垫片、掏空它、用惯用的 Love 代码替换它，带你的游戏往任何方向走。

**移植解锁的用例：**

- iOS / Android，通过 [love-android](https://github.com/love2d/love-android) 与
  [love-iOS](https://github.com/love2d/love-ios)。
- 多个精灵文件。
- 渲染目标，以及 `love.graphics` 的其余部分。
- 通过 Love 绑定接入 Steam / Steamworks。
- 超过 3 个动作按钮、自定义键位映射界面等等。

**有意不迁移的东西。** 这些需要你在自己的 fork 里重新实现：

- **暂停菜单**（`usagi.menu_item` / `clear_menu_items`）。这些 Lua 调用在垫片中是无操作
  的空壳，这样注册了菜单项的项目不会加载失败，但不会渲染任何浮层。
- **输入重映射**（来自 `usagi tools` 的键位 / 手柄映射覆盖系统）。请在垫片默认绑定的基础
  上自行实现重映射界面。
- **着色器**（`gfx.shader_set` / `gfx.shader_uniform`）。无操作空壳。请直接使用 Love 的
  原生着色器 API（`love.graphics.newShader` 等）。
- **热重载（F5）。** 属于 Usagi 特有的开发循环功能；已发布的 Love 游戏不会重载。
- **FPS 浮层。** 请用 `love.timer.getFPS()` 与 `gfx.text` 自行实现。
- **`usagi tools`、`usagi export`、`usagi font bake`。** 这些是 Usagi 的 CLI，不是运行时
  API。请使用 Love 自己的打包方式（`love --fused`、
  [love-release](https://github.com/MisterDA/love-release)、
  [makelove](https://github.com/pfirsich/makelove)）。

对一个已 loveify 的项目做 Web 导出尚未验证。Love 11.5 没有 Web 目标。你需要通过
[love.js](https://github.com/Davidobot/love.js) 或当前最好的那个 fork 来跑这次移植。垫片
里没有 Web 专属代码（它不使用线程或其它在 emscripten 下会崩的模块），所以理论上应该能跑，
但尚未测试。若 Web 是主要需求，请使用 `usagi export --target web`。

垫片源码是注释良好的纯 Lua，位于 `<your-project>/usagi_shim.lua`。当你运行
`usagi loveify` 后，它就是你的代码了！打开它、读它、改它。原始规范副本位于 Usagi 仓库的
[`examples/loveify/`](https://codeberg.org/brettchalupa/usagi/src/branch/main/examples/loveify)。
垫片的更新会随新的 Usagi 版本发布；一旦你完成移植，你就在自己的副本上了，这正是预期的
结果。你可以继续使用 Usagi API、扩展它，或者彻底离开它。完全由你决定。

## 调试

有了热重载，最快的调试循环通常就是 `print`。把 `print` 放进 `_update` 或 `_draw` 并打印
你在意的值，保存，然后一边看游戏继续运行、一边在终端里看它不断输出。

对于表，标准 Lua 的 `print(my_table)` 只会显示类似 `table: 0x55a...` 的东西，没什么用。
用 `usagi.dump(t)` 可以获得任何值的递归美化打印：

```lua
print(usagi.dump(state))
```

表会按键排序递归展开；数组按顺序渲染；循环引用显示为 `<cycle>`；函数 / userdata / 线程
显示为占位符。结果是一个字符串，因此开发期间你也可以用 `gfx.text` 把它画到屏幕上。

其它值得了解的 Lua 工具：

- `print(debug.traceback())` 把当前调用栈写到 stdout。适合回答「我们是怎么走到这一步的？
  」。
- `assert(cond, msg)` 在 `cond` 为假值时抛错。这是守卫不变量的廉价方式：
  `assert(player, "player is nil in _update")`。
- `error(msg)` 直接抛错。在 `usagi dev` 中它会传播到游戏内错误浮层（带 traceback 的红屏），
  因此当状态明显不对时你可以当场停住，而不必去追几帧之后才浮现的隐性数据损坏。
- `pcall(fn, ...)` 调用 `fn`，出错时返回 `false, msg` 而不是展开错误。用于包裹可能失败的
  代码（解析可选数据、从脆弱的来源加载），同时让游戏其余部分继续运行。

在 Lua 里，一点点防御式编程回报很高。这门语言是动态且沉默的：一个笔误把真实的值变成了
`nil`，而你要到几帧之后、某个毫不相干的代码试图索引那个 nil 时才会发现。断言你的假设
——尤其是在 `_init` 中和函数边界上——能把这个距离压缩掉：失败点会指向真正的 bug，而不是
指向它引发的连锁反应。

### 详细模式（`USAGI_VERBOSE=1`）

在 shell 中设置 `USAGI_VERBOSE=1` 可开启两路额外输出：

- **启动快照。** 在 `_init` 之后紧接着打印的一次性摘要：构建配置（debug / release）、平台、
  Lua GC 参数、分辨率、精灵尺寸、是否使用暂停菜单 / 自定义调色板 / 自定义字体、脚本路径，
  以及 `_init` 之后的 Lua 堆大小。适合粘进 bug 报告。
- **每秒帧摘要。** 每秒输出一行的滚动信息，含帧时间统计（`avg / p50 / p99 / max` 毫秒）、
  超出 16.7 ms 预算的帧数，以及当前 Lua 堆大小（KB）。它专门用来捕捉「一切仍在**运行**但
  更慢了」这类回归（例如某次 GC 调参失误，把 16 ms 的帧悄悄变成 43 ms 的帧）。

Raylib 自己的启动杂项（GL 信息、音频设备、手柄检测）以及它逐帧的 TEXTURE 日志，由
`USAGI_RAYLIB_VERBOSE=1` 单独控制。两者刻意分开，以免诊断信息流被 raylib 的逐帧输出淹没。
需要全部信息时同时设置两者：

```
USAGI_VERBOSE=1 USAGI_RAYLIB_VERBOSE=1 usagi dev path/to/game
```

一个健康 60 FPS 游戏的输出示例：

```
[usagi] -- startup snapshot --
[usagi] build release on linux
[usagi] gc inc pause=250 stepmul=200 stepsize=11200
[usagi] resolution 320x180 pixel-perfect=off sprite-size=16
[usagi] pause-menu=on palette=pico-8 font=bundled
[usagi] script=examples/hello_usagi.lua lua-heap-after-init=80 KB
[usagi] -- end startup snapshot --
[usagi] frame avg 16.67ms (p50 16.67 / p99 16.67 / max 16.67); over-budget 0/61; lua heap 164 KB
```

「仍在跑但更慢」形态的回归会显示成这样：

```
[usagi] frame avg 43.21ms (p50 43.00 / p99 48.10 / max 51.20); over-budget 61/61; lua heap 12 KB
```

`avg` 跳了 2-3 倍，`over-budget` 顶到上限，而 `lua heap` 贴着零（GC 在每个分配上扫荡，
没有东西能活过一帧）。

`examples/diagnostics` 就是为此而生的：在 `_update` 中做短命的内存分配，并带有调节速率的
控件和一个突发按钮。用 `USAGI_VERBOSE=1 just example diagnostics` 运行它并观察终端。

未设置该环境变量时输出是零开销：格式化宏会在触碰格式参数之前短路。

设置 `NO_COLOR=1`（任意值，只检查是否存在）可以抑制 `usagi` 自身日志行上的 ANSI 颜色转义。
当你把输出管道到文件，或投喂给不擅长渲染 ANSI 的 CI 日志查看器时很有用。Usagi 遵循
[no-color.org](https://no-color.org) 约定，并且当 stdout/stderr 不是终端时也会自动禁用
颜色，因此大多数管道 / 重定向场景无需额外设置就已覆盖。PowerShell 同样认这个环境变量；
当前会话设置用 `$env:NO_COLOR = "1"`，持久设置用
`[Environment]::SetEnvironmentVariable("NO_COLOR", "1", "User")`。cmd 用
`set NO_COLOR=1`。

## 参与开发

- `just run` - 运行 hello_usagi 示例
- `just ok` - 运行所有检查
- `just fmt` - 格式化 Rust 代码
- `just serve-web` - 构建并在 <http://localhost:3535> 提供 Web 构建
  （需要 PATH 上有 `emcc`；见 [docs/web-build.md](docs/web-build.md)）

## 参考与灵感

- Pico-8
- Pyxel
- Love2D
- Playdate SDK
- DragonRuby Game Toolkit（DRGTK）

## 引擎素材

如果你出于任何原因需要，可以
[下载 Usagi Engine 的标志素材](https://chalupa.storageshare.net/s/Gp9Nzfy9dt7takH)。

## 致谢

Usagi 使用 [Rust](https://rust-lang.org/) 构建。

- **Raylib 与 sola-raylib 的 Rust 绑定** —— Usagi 由 [Raylib](https://raylib.com) 驱动，
  它承担了大量繁重工作，从处理输入到渲染再到声音。

- **mlua** —— Lua 的 Rust 绑定，是 Usagi 能够工作的关键。

- **monogram-extended** —— 内置字体（`assets/monogram.png`，单个 PNG，字形元数据在 zTXt
  区块中），用于 `gfx.text`（当没有放入自定义字体时）以及所有引擎 UI 浮层（FPS、错误浮层、
  暂停菜单、工具窗口）。5×7 像素字体，约 500 个字形，覆盖 Basic Latin、Latin-1、
  Latin Extended-A、部分希腊文与部分西里尔文。作者
  [datagoblin](https://datagoblin.itch.io/monogram)，以 Creative Commons Zero（CC0）
  发布。源 TTF 位于 `assets/monogram-extended.ttf`；要重新烘焙，请运行
  `cargo run -- font bake assets/monogram-extended.ttf 15 --out assets/monogram.png`。

- **Silver** —— 由 `examples/custom_font` 演示使用，用来展示自定义字体的放入方式
  （项目根目录的 `font.png`）。一款约 5×9 的像素字体，具备较广的欧洲字符 + 部分 CJK 覆盖，
  作者 Poppy Works（[poppyworks.itch.io/silver](https://poppyworks.itch.io/silver)），
  以
  [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)
  授权。

- **FreeType** —— 由 `usagi font bake` 使用，把 TTF/OTF 轮廓光栅化为单色位图，并启用
  TrueType 字节码 hinting（这样经过 `ttfautohint` hinting 的像素字体能在其设计尺寸上正确
  渲染）。通过 `freetype-rs` crate 的 `bundled` 特性以静态方式内置链接；用户侧无需安装
  系统库。以 FreeType License（BSD 风格）授权。

Usagi 依赖的每一个传递性 Rust crate 的完整清单，以及各许可证的全文，都在
[usagiengine.com/third-parties](https://usagiengine.com/third-parties)（同时也随每个发布
归档打包在二进制旁边的 `THIRD_PARTY_LICENSES.md` 中）。改动依赖后请用 `just licenses`
重新生成；若发生漂移，CI 会失败。

## （非）许可证

Usagi 的源码已贡献至公有领域。完整细节见 [UNLICENSE](./UNLICENSE)。

