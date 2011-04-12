local function init()
  add_back_image('score', 'image/result.dds')
  add_image('dream', 'image/result00.dds')
  resize_actor('dream', 128, 24)
  set_actor_uv('dream', 0, 0, 128, 24)
  move_actor('dream', 32, 32)
end

local function clean()
  erase_actor('score')
  erase_actor('dream')
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

function score()
  init()
  update()
end
