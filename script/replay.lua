local function init()
  add_back_image('select', 'image/select00.dds')
  add_image('replay', 'image/replay00.dds')
  resize_actor('replay', 128, 16)
  set_actor_uv('replay', 0, 0, 128, 16)
  move_actor('replay', 172, 48)
end

local function clean()
  erase_actor('select')
  erase_actor('replay')
end

local function update()
  while true do
    if key_triger(kCross) == true then
      stop_se('cancel')
      play_se('cancel', 1)
      coroutine.yield()
      clean()
      title()
    end
    coroutine.yield()
  end
end

function replay()
  init()
  update()
end
