kPlayerList = {
  {key = 'reimu_up', file = 'image/slpl00a.dds'},
  {key = 'reimu_down', file = 'image/slpl00b.dds'},
  {key = 'marisa_up', file = 'image/slpl01a.dds'},
  {key = 'marisa_down', file = 'image/slpl01b.dds'}
}
local kPlayerSelectImageFileName = 'image/select03.dds'
local kPlayerMin = 1
local kPlayerMax = 3

local function init(mode_select, character_select)
  move_to_actor(kModeList[mode_select], 4, 192)
  set_actor_alpha(kModeList[mode_select], 0x80)
  for i, player in ipairs(kPlayerList) do
    add_bright_image(player.key, player.file)
    resize_actor(player.key, 160, 160)
    set_actor_uv(player.key, 0, 0, 256, 256)
    if i % 2 == 0 then
      move_actor(player.key, 256, 140)
    else
      move_actor(player.key, 256, -20)
    end
  end
  if character_select == 1 then
    sleep_actor(kPlayerList[3].key)
    sleep_actor(kPlayerList[4].key)
  else
    sleep_actor(kPlayerList[1].key)
    sleep_actor(kPlayerList[2].key)
  end
  add_image('player_select', kPlayerSelectImageFileName)
  resize_actor('player_select', 256, 64)
  move_actor('player_select', 112, 8)
  set_actor_uv('player_select', 0, 0, 256, 64)
end

local function clean()
  for i, player in ipairs(kPlayerList) do
    erase_actor(player.key)
  end
  erase_actor('player_select')
end

local function reset(character_select)
  move_to_actor(kPlayerList[character_select].key, 256, -20)
  move_to_actor(kPlayerList[character_select + 1].key, 256, 140)
  set_actor_alpha(kPlayerList[character_select].key, 0xFF)
  set_actor_alpha(kPlayerList[character_select + 1].key, 0xFF)
  add_image('player_select', kPlayerSelectImageFileName)
  resize_actor('player_select', 256, 64)
  move_actor('player_select', 112, 8)
  set_actor_uv('player_select', 0, 0, 256, 64)
end

local function clean_to_spell_select()
  erase_actor('player_select')
end

local function change_not_select(character_select)
  sleep_actor(kPlayerList[character_select].key)
  sleep_actor(kPlayerList[character_select + 1].key)
end

local function change_select(character_select)
  active_actor(kPlayerList[character_select].key)
  active_actor(kPlayerList[character_select + 1].key)
end

local function select_right(character_select)
  stop_se('select')
  play_se('select', 1)
  change_not_select(character_select)
  character_select = character_select + 2 > kPlayerMax and kPlayerMin or kPlayerMax 
  change_select(character_select)
  return character_select
end

local function select_left(character_select)
  stop_se('select')
  play_se('select', 1)
  change_not_select(character_select)
  character_select = character_select - 2 < kPlayerMin and kPlayerMax or kPlayerMin 
  change_select(character_select)
  return character_select
end

local function decide(character_select)
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean_to_spell_select()
  spell_select(character_select)
  reset(character_select)
end

local function cancel()
  stop_se('cancel')
  play_se('cancel', 1)
  coroutine.yield()
  clean()
end

local function update(mode_select, character_select)
  while true do
    if key_triger(kRight) == true then
      character_select = select_right(character_select)
    elseif key_triger(kLeft) == true then
      character_select = select_left(character_select)
    elseif key_triger(kCircle) == true then
      decide(character_select)
    elseif key_triger(kCross) == true then
      cancel()
      break
    end
    coroutine.yield()
  end
end

function player_select(mode_select)
  local character_select = 1
  init(mode_select, character_select)
  update(mode_select, character_select)
end
