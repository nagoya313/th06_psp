local kImageFileNameList = {'image/slpl00a.dds', 'image/slpl00b.dds', 'image/slpl01a.dds', 'image/slpl01b.dds'}
local kSpellList = {'spell1_select', 'spell2_select'}
local kSpellSelectImageFileName = 'image/select03.dds'
local kSpellImageFileName = 'image/select04.dds'

local function init(character_select, card_select)
  move_actor(kPlayerList[character_select].key, 172, 32)
  set_actor_alpha(kPlayerList[character_select].key, 0x80)
  move_actor(kPlayerList[character_select + 1].key, 172, 160)
  set_actor_alpha(kPlayerList[character_select + 1].key, 0x80)
  add_image('spell_select', kSpellSelectImageFileName)
  resize_actor('spell_select', 128, 32)
  move_actor('spell_select', 320, 64)
  set_actor_uv('spell_select', 0, 32, 128, 32)
  for i, key in ipairs(kSpellList) do
    add_bright_image(key, kSpellImageFileName)
    local x = 320
    if i ~= card_select then
      x = x + 8
      set_actor_alpha(key, 0x80)
    end
    resize_actor(key, 128, 24)
    move_actor(key, x, 96 + i * 24)
    set_actor_uv(key, 0, 24 * (i - 1 + (math.floor(character_select / 2)) * 2), 128, 24)
  end
end

local function clean()
  erase_actor('spell_select')
  erase_actor('spell1_select')
  erase_actor('spell2_select')
end

local function select_down(card_select)
  stop_se('select')
  play_se('select', 1)
  set_actor_alpha(kSpellList[card_select], 0x80)
  card_select = card_select + 1 > 2 and 1 or 2 
  set_actor_alpha(kSpellList[card_select], 0xFF)
  return card_select
end

local function select_up(card_select)
  stop_se('select')
  play_se('select', 1)
  set_actor_alpha(kSpellList[card_select], 0x80)
  card_select = card_select - 1 < 1 and 2 or 1 
  set_actor_alpha(kSpellList[card_select], 0xFF)
  return card_select
end

local function cancel()
  stop_se('cancel')
  play_se('cancel', 1)
  coroutine.yield()
  clean()
end

local function update(card_select)
  while true do
    if key_triger(kDown) == true then
      card_select = select_down(card_select)
    elseif key_triger(kUp) == true then
      card_select = select_up(card_select)
    elseif key_triger(kCircle) == true then
    elseif key_triger(kCross) == true then
      cancel()
      break
    end
    coroutine.yield()
  end
end

function spell_select(character_select)
  local card_select = 1
  init(character_select, card_select)
  update(card_select)
end
