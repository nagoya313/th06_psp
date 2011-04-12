mode_table = {'easy', 'normal', 'hard', 'lunatic'}
local mode_select = 1

local function init()
  add_back_image('select', 'image/select00.dds')
  add_image('mode', 'image/select01.dds')
  resize_actor('mode', 128, 32)
  move_actor('mode', 172, 16)
  set_actor_uv('mode', 0, 96, 128, 32)
  local mode_name = {'image/select01.dds', 'image/select02.dds'}
  for i, mode in ipairs(mode_table) do
    i = i - 1
    add_bright_image(mode, mode_name[math.floor(i / 2) + 1])
    resize_actor(mode, 128, 48)
    move_actor(mode, 172, 48 + 50 * i)
    set_actor_uv(mode, 0, 48 * math.floor(i % 2), 128, 48)
    if i ~= mode_select - 1 then 
      set_actor_alpha(mode, 0x80)
    end
  end
end

local function clean()
  erase_actor('select')
  erase_actor('mode')
  for i, mode in ipairs(mode_table) do
    erase_actor(mode)
  end
end

local function clean2(mode_select)
  erase_actor('mode')
  for i, mode in ipairs(mode_table) do
    if i ~= mode_select then
      sleep_actor(mode)
    end
  end
end

local function update()
  while true do
    if key_triger(kDown) == true then
      stop_se('select')
      play_se('select', 1)
      set_actor_alpha(mode_table[mode_select], 0x80)
      mode_select = mode_select + 1 > 4 and 1 or mode_select + 1
      set_actor_alpha(mode_table[mode_select], 0xFF)
    elseif key_triger(kUp) == true then
      stop_se('select')
      play_se('select', 1)
      set_actor_alpha(mode_table[mode_select], 0x80)
      mode_select = mode_select - 1 < 1 and 4 or mode_select - 1
      set_actor_alpha(mode_table[mode_select], 0xFF)
    elseif key_triger(kCircle) == true then
      stop_se('ok')
      play_se('ok', 1)
      coroutine.yield()
      clean2(mode_select)
      player_select(mode_select)
    elseif key_triger(kCross) == true then
      stop_se('cancel')
      play_se('cancel', 1)
      coroutine.yield()
      clean()
      title()
    end
    coroutine.yield()
  end
end

function mode2(mode_select)
  add_image('mode', 'image/select01.dds')
  resize_actor('mode', 128, 32)
  move_actor('mode', 172, 16)
  set_actor_uv('mode', 0, 96, 128, 32)
  for i, mode in ipairs(mode_table) do
    if i == mode_select then
      move_actor(mode, 172, 48 + 50 * (mode_select - 1))
      set_actor_alpha(mode_table[mode_select], 0xFF)
    else
      active_actor(mode)
    end
  end
  update()
end

function mode()
  init()
  update()
end
