p_table = {'reimu_up', 'reimu_down', 'marisa_up', 'marisa_down'}
local image_table = {'image/slpl00a.dds', 'image/slpl00b.dds', 'image/slpl01a.dds', 'image/slpl01b.dds'}
local p_select = 1

local function init(mode_select)
  move_actor(mode_table[mode_select], 32, 192)
  set_actor_alpha(mode_table[mode_select], 0x80)
  for i, key in ipairs(p_table) do
    add_bright_image(key, image_table[i])
    resize_actor(key, 128, 128)
    set_actor_uv(key, 0, 0, 128, 128)
    if i % 2 == 0 then
      move_actor(key, 256, 160)
    else
      move_actor(key, 256, 32)
    end
  end
  if p_select == 1 then
    sleep_actor(p_table[3])
    sleep_actor(p_table[4])
  else
    sleep_actor(p_table[1])
    sleep_actor(p_table[2])
  end
  add_image('player_select', 'image/select03.dds')
  resize_actor('player_select', 128, 32)
  move_actor('player_select', 172, 24)
  set_actor_uv('player_select', 0, 0, 128, 32)
end

local function clean()
  for i, key in ipairs(p_table) do
    erase_actor(key)
  end
  erase_actor('player_select')
end

local function clean2()
  erase_actor('player_select')
end

local function update(mode_select)
  while true do
    if key_triger(kRight) == true then
      stop_se('select')
      play_se('select', 1)
      sleep_actor(p_table[p_select])
      sleep_actor(p_table[p_select + 1])
      p_select = p_select + 2 > 3 and 1 or 3 
      active_actor(p_table[p_select])
      active_actor(p_table[p_select + 1])
    elseif key_triger(kLeft) == true then
      stop_se('select')
      play_se('select', 1)
      sleep_actor(p_table[p_select])
      sleep_actor(p_table[p_select + 1])
      p_select = p_select - 2 < 1 and 3 or 1 
      active_actor(p_table[p_select])
      active_actor(p_table[p_select + 1])
    elseif key_triger(kCircle) == true then
      stop_se('ok')
      play_se('ok', 1)
      coroutine.yield()
      clean2()
      spell_select(p_select, mode_select)
    elseif key_triger(kCross) == true then
      stop_se('cancel')
      play_se('cancel', 1)
      coroutine.yield()
      clean()
      mode2(mode_select)
    end
    coroutine.yield()
  end
end

function player_select(mode_select)
  init(mode_select)
  update(mode_select)
end

function player_select2(mode_select)
  add_image('player_select', 'image/select03.dds')
  resize_actor('player_select', 128, 32)
  move_actor('player_select', 172, 24)
  set_actor_uv('player_select', 0, 0, 128, 32)
  update(mode_select)
end
