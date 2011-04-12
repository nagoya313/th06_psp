kModeList = {'easy', 'normal', 'hard', 'lunatic'}
local kSelect = 'select'
local kSelectImageFileName = 'image/select00.dds'
local kMode = 'mode'
local kModeImageFileNameList = {'image/select01.dds', 'image/select02.dds'}
local kModeMin = 1
local kModeMax = 4

local function init(mode_select)
  add_back_image(kSelect, kSelectImageFileName)
  add_image(kMode, kModeImageFileNameList[1])
  resize_actor(kMode, 128, 32)
  move_actor(kMode, 172, 16)
  set_actor_uv(kMode, 0, 96, 128, 32)
  for i, mode in ipairs(kModeList) do
    i = i - 1
    add_bright_image(mode, kModeImageFileNameList[math.floor(i / 2) + 1])
    resize_actor(mode, 128, 48)
    move_actor(mode, 172, 48 + 50 * i)
    set_actor_uv(mode, 0, 48 * math.floor(i % 2), 128, 48)
    if i ~= mode_select - 1 then 
      set_actor_alpha(mode, 0x80)
    end
  end
end

local function clean()
  erase_actor(kSelect)
  erase_actor(kMode)
  for i, mode in ipairs(kModeList) do
    erase_actor(mode)
  end
end

local function clean_to_player_select(mode_select)
  erase_actor(kMode)
  for i, mode in ipairs(kModeList) do
    if i ~= mode_select then
      sleep_actor(mode)
    end
  end
end

local function reset(mode_select)
  add_image(kMode, kModeImageFileNameList[1])
  resize_actor(kMode, 128, 32)
  move_actor(kMode, 172, 16)
  set_actor_uv(kMode, 0, 96, 128, 32)
  for i, mode in ipairs(kModeList) do
    if i == mode_select then
      move_actor(mode, 172, 48 + 50 * (mode_select - 1))
      set_actor_alpha(mode, 0xFF)
    else
      active_actor(mode)
    end
  end
end

local function select_up(mode_select)
  stop_se('select')
  play_se('select', 1)
  set_actor_alpha(kModeList[mode_select], 0x80)
  mode_select = mode_select - 1 < kModeMin and kModeMax or mode_select - 1
  set_actor_alpha(kModeList[mode_select], 0xFF)
  return mode_select
end

local function select_down(mode_select)
  stop_se('select')
  play_se('select', 1)
  set_actor_alpha(kModeList[mode_select], 0x80)
  mode_select = mode_select + 1 > kModeMax and kModeMin or mode_select + 1
  set_actor_alpha(kModeList[mode_select], 0xFF)
  return mode_select
end

local function decide(mode_select)
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean_to_player_select(mode_select)
  player_select(mode_select)
  reset(mode_select)
end

local function cancel(menu_select)
  stop_se('cancel')
  play_se('cancel', 1)
  coroutine.yield()
  clean()
  title(menu_select)
end

local function update(menu_select, mode_select)
  while true do
    if key_triger(kDown) == true then
      mode_select = select_down(mode_select)
    elseif key_triger(kUp) == true then
      mode_select = select_up(mode_select)
    elseif key_triger(kCircle) == true then
      decide(mode_select)
    elseif key_triger(kCross) == true then
      cancel(menu_select)
    end
    coroutine.yield()
  end
end

function mode(menu_select)
  local mode_select = 1
  init(mode_select)
  update(menu_select, mode_select)
end
