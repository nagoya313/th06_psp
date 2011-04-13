local kSelectImageFileName = 'image/select00.dds'
local kReplayImageFileName = 'image/replay00.dds'
local kReplayWidth = 256
local kReplayHeight = 32
local kReplayU = 0
local kReplayV = 0
local kReplayX = 112
local kReplayY = 16

local function init()
  add_back_image('select', kSelectImageFileName)
  add_image('replay', kReplayImageFileName)
  resize_actor('replay', kReplayWidth, kReplayHeight)
  set_actor_uv('replay', kReplayU, kReplayV, kReplayWidth, kReplayHeight)
  move_actor('replay', kReplayX, kReplayY)
end

local function clean()
  erase_actor('select')
  erase_actor('replay')
end

local function cancel(menu_select)
  stop_se('cancel')
  play_se('cancel', 1)
  coroutine.yield()
  clean()
  title(menu_select)
end

local function update(menu_select)
  while true do
    if key_triger(kCross) == true then
      cancel(menu_select)
    end
    coroutine.yield()
  end
end

function replay(menu_select)
  init()
  update(menu_select)
end
