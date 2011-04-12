local kTitle = 'title'
local kTitleImage = 'image/title00.dds'
local kTitleLogoTable = {'to', 'ho', 'ko', 'ma', 'kyo'}
local kTitleMenuImage = 'image/title01.dds'
local kTitleSelectMenuImage = 'image/title01s.dds'
local kTitleLogoWhiteImage = 'image/title02.dds'
local kTitleLogoRedImage = 'image/title03.dds'
local kMenuTable = {
  {key = 'play', select_key = 'select_play', size = 40, u = 0, v = 0},
  {key = 'extra', select_key = 'select_extra', size = 88, u = 40, v = 0},
  {key = 'plactice', select_key = 'select_plactice', size = 96, u = 0, v = 96}, 
  {key = 'replay', select_key = 'select_replay', size = 48, u = 0, v = 16},
  {key = 'score', select_key = 'select_score', size = 48, u = 48, v = 16},
  {key = 'music', select_key = 'select_music', size = 80, u = 48, v = 80},
  {key = 'option', select_key = 'select_option', size = 48, u = 0, v = 32}
}
local kMenuMax = 7
local kMenuMin = 1
local menu_select = 1

local function init()
  add_back_image(kTitle, kTitleImage)
  for i, title_logo in ipairs(kTitleLogoTable) do
    i = i - 1
    if (i == 2) then
      add_image(title_logo, kTitleLogoRedImage)
      set_actor_uv(title_logo, 0, 0, 48, 48)
    else
      add_image(title_logo, kTitleLogoWhiteImage)
      local j = i > 2 and i - 1 or i
      set_actor_uv(title_logo, (j % 2) * 48, math.floor(j / 2) * 48, 48, 48)
    end
    resize_actor(title_logo, 48, 48)
    move_actor(title_logo, 48, 24 + 40 * i)
  end
  for i, menu in ipairs(kMenuTable) do
    add_image(menu.key, kTitleMenuImage)
    move_actor(menu.key, 336 - i * 4, 112 + i * 16)
    resize_actor(menu.key, menu.size, 16)
    set_actor_uv(menu.key, menu.u, menu.v, menu.size, 16)
    add_image(menu.select_key, kTitleSelectMenuImage)
    move_actor(menu.select_key, 336 - i * 4, 112 + i * 16)
    resize_actor(menu.select_key, menu.size, 16)
    set_actor_uv(menu.select_key, menu.u, menu.v, menu.size, 16)
    if (i == menu_select) then
      sleep_actor(menu.key)
    else
      sleep_actor(menu.select_key)
    end
  end
end

local function clean()
  erase_actor(kTitle)
  for i, title_logo in ipairs(kTitleLogoTable) do
    erase_actor(title_logo)
  end
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

local function select_up()
  stop_se('select')
  play_se('select', 1)
  change_not_select(menu_select)
  menu_select = menu_select - 1 < kMenuMin and kMenuMax or menu_select - 1
  change_select(menu_select)
end

local function select_down()
  stop_se('select')
  play_se('select', 1)
  change_not_select(menu_select)
  menu_select = menu_select + 1 > kMenuMax and kMenuMin or menu_select + 1
  change_select(menu_select)
end

local function play()
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean()
  mode()
end

local function extra()
end

local function plactice()
end

local function replay()
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean()
  replay()
end

local function score()
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean()
  score()
end

local function music()
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean()
  music()
end

local function option()
end

local kFunctorTable = {play, extra, plactice, replay, score, music, option}

local function update()
  while true do
    if key_triger(kDown) == true then
      select_down()
    elseif key_triger(kUp) == true then
      select_up()
    elseif key_triger(kCircle) == true then
      kFunctorTable[menu_select]()
    end
    coroutine.yield()
  end
end

function title()
  init()
  update()
end
