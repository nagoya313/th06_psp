local kResultImageFileName = 'image/result.dds'
local kDreanImageFileName = 'image/result00.dds'

local function init()
  add_back_image('score', kResultImageFileName)
  add_image('dream', kDreanImageFileName)
  resize_actor('dream', 256, 48)
  set_actor_uv('dream', 0, 0, 256, 48)
  move_actor('dream', 16, 16)
end

local function clean()
  erase_actor('score')
  erase_actor('dream')
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

function score(menu_select)
  init()
  update(menu_select)
end
