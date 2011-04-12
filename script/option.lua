local kTitleMenuImageList = {
  {no_select = 'image/title01.dds', select = 'image/title01s.dds'},
  {no_select = 'image/title02.dds', select = 'image/title02.dds'},
  {no_select = 'image/title04.dds', select = 'image/title04s.dds'}
}
local kMenuTable = {
  {key = 'player', select_key = 'select_play', width = 48, u = 48, v = 32, file = 1},
  {key = 'bomb', select_key = 'select_extra', width = 40, u = 0, v = 48, file = 1},
  {key = 'bgm', select_key = 'select_plactice', width = 40, u = 40, v = 48, file = 1}, 
  {key = 'sound', select_key = 'select_replay', width = 48, u = 80, v = 48, file = 1},
  {key = 'reset', select_key = 'select_score', width = 86, u = 0, v = 64, file = 3},
  {key = 'key_config', select_key = 'select_music', width = 72, u = 0, v = 96, file = 2},
  {key = 'quit', select_key = 'select_option', width = 32, u = 48, v = 48, file = 3}
}
local kMenuX = 64
local kMenuY = 16
local kMenuYDifferebce = 24
local kMenuHeight = 16
local kMenuMax = 7
local kMenuMin = 1

local function init(option_select)
  for i, menu in ipairs(kMenuTable) do
    add_image(menu.key, kTitleMenuImageList[menu.file].no_select)
    move_actor(menu.key, kMenuX, kMenuY + i * kMenuYDifferebce)
    resize_actor(menu.key, menu.width, kMenuHeight)
    set_actor_uv(menu.key, menu.u, menu.v, menu.width, kMenuHeight)
    add_image(menu.select_key, kTitleMenuImageList[menu.file].select)
    move_actor(menu.select_key, kMenuX, kMenuY + i * kMenuYDifferebce)
    resize_actor(menu.select_key, menu.width, kMenuHeight)
    if menu.file == 2 then
      set_actor_uv(menu.select_key, menu.u, menu.v + kMenuHeight, menu.width, kMenuHeight)
    else
      set_actor_uv(menu.select_key, menu.u, menu.v, menu.width, kMenuHeight)
    end
    if (i == option_select) then
      sleep_actor(menu.key)
    else
      sleep_actor(menu.select_key)
    end
  end
end

local function clean()
  for i, menu in ipairs(kMenuTable) do
    erase_actor(menu.key)
    erase_actor(menu.select_key)
  end
end

local function change_select(select)
  active_actor(kMenuTable[select].select_key)
  sleep_actor(kMenuTable[select].key)
end

local function change_not_select(select)
  active_actor(kMenuTable[select].key)
  sleep_actor(kMenuTable[select].select_key)
end

local function select_up(option_select)
  stop_se('select')
  play_se('select', 1)
  change_not_select(option_select)
  option_select = option_select - 1 < kMenuMin and kMenuMax or option_select - 1
  change_select(option_select)
  return option_select
end

local function select_down(option_select)
  stop_se('select')
  play_se('select', 1)
  change_not_select(option_select)
  option_select = option_select + 1 > kMenuMax and kMenuMin or option_select + 1
  change_select(option_select)
  return option_select
end

local function cancel()
  stop_se('cancel')
  play_se('cancel', 1)
  coroutine.yield()
  clean()
end

local function update(option_select, menu_select)
  while true do
    if key_triger(kDown) == true then
      option_select = select_down(option_select)
    elseif key_triger(kUp) == true then
      option_select = select_up(option_select)
    elseif key_triger(kCross) == true then
      cancel()
      break
    end
    coroutine.yield()
  end
end

function option(menu_select)
  local option_select = 1
  init(option_select)
  update(option_select, menu_select)
end
