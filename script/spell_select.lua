local image_table = {'image/slpl00a.dds', 'image/slpl00b.dds', 'image/slpl01a.dds', 'image/slpl01b.dds'}
local spell_table = {'spell1_select', 'spell2_select'}
local s_select = 1

local function init(select, mode)
  move_actor(p_table[select], 172, 32)
  set_actor_alpha(p_table[select], 0x80)
  move_actor(p_table[select + 1], 172, 160)
  set_actor_alpha(p_table[select + 1], 0x80)
  add_image('spell_select', 'image/select03.dds')
  resize_actor('spell_select', 128, 32)
  move_actor('spell_select', 320, 64)
  set_actor_uv('spell_select', 0, 32, 128, 32)
  for i, key in ipairs(spell_table) do
    add_bright_image(key, 'image/select04.dds')
    local x = 320
    if i ~= s_select then
      x = x + 8
      set_actor_alpha(key, 0x80)
    end
    resize_actor(key, 128, 24)
    move_actor(key, x, 96 + i * 24)
    set_actor_uv(key, 0, 24 * (i - 1 + (math.floor(select / 2)) * 2), 128, 24)
  end
  --[[add_bright_image(key_table[select], image_table[select])
  resize_actor(key_table[select], 128, 128)
  move_actor(key_table[select], 172, 32)
  set_actor_alpha(key_table[select], 0x80)
  add_bright_image(key_table[select + 1], image_table[select + 1])
  resize_actor(key_table[select + 1], 128, 128)
  move_actor(key_table[select + 1], 172, 160)
  set_actor_alpha(key_table[select + 1], 0x80)
  add_image('spell_select', 'image/select03.dds')
  resize_actor('spell_select', 128, 32)
  move_actor('spell_select', 320, 64)
  set_actor_uv('spell_select', 0, 32, 128, 32)
  for i, key in ipairs(spell_table) do
    add_bright_image(key, 'image/select04.dds')
    local x = 320
    if i ~= s_select then
      x = x + 8
      set_actor_alpha(key, 0x80)
    end
    resize_actor(key, 128, 24)
    move_actor(key, x, 96 + i * 24)
    set_actor_uv(key, 0, 24 * (i - 1 + (math.floor(select / 2)) * 2), 128, 24)
  end]]
end

local function clean(select)
  erase_actor('select')
  --erase_actor(key_table[select])
  --erase_actor(key_table[select + 1])
  --erase_actor('spell_select')
  --erase_actor('spell1_select')
  --erase_actor('spell2_select')
  erase_actor('mode')
end

local function clean2(select)
  move_actor(p_table[select], 256, 32)
  move_actor(p_table[select + 1], 256, 160)
  set_actor_alpha(p_table[select], 0xFF)
  set_actor_alpha(p_table[select + 1], 0xFF)
  erase_actor('spell_select')
  erase_actor('spell1_select')
  erase_actor('spell2_select')
end

function spell_select(select, mode)
  init(select, mode)
  while true do
    if key_triger(kDown) == true then
      stop_se('select')
      play_se('select', 1)
      set_actor_alpha(spell_table[s_select], 0x80)
      s_select = s_select + 1 > 2 and 1 or 2 
      set_actor_alpha(spell_table[s_select], 0xFF)
    elseif key_triger(kUp) == true then
      stop_se('select')
      play_se('select', 1)
      set_actor_alpha(spell_table[s_select], 0x80)
      s_select = s_select - 1 < 1 and 2 or 1 
      set_actor_alpha(spell_table[s_select], 0xFF)
    elseif key_triger(kCircle) == true then
    elseif key_triger(kCross) == true then
      stop_se('cancel')
      play_se('cancel', 1)
      coroutine.yield()
      clean2(select)
      player_select2(mode)
    end
    coroutine.yield()
  end
end
