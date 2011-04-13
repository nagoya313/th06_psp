local kTitle = 'title'
local kTitleImage = 'image/title00.dds'
local kTitleLogoTable = {'to', 'ho', 'ko', 'ma', 'kyo'}
local kTitleMenuImage = 'image/title01.dds'
local kTitleSelectMenuImage = 'image/title01s.dds'
local kTitleLogoWhiteImage = 'image/title02.dds'
local kTitleLogoRedImage = 'image/title03.dds'
local kMenuTable = {
  {key = 'play', select_key = 'select_play', width = 80, u = 0, v = 0},
  {key = 'extra', select_key = 'select_extra', width = 76, u = 80, v = 0},
  {key = 'plactice', select_key = 'select_plactice', width = 108, u = 0, v = 192}, 
  {key = 'replay', select_key = 'select_replay', width = 96, u = 0, v = 32},
  {key = 'score', select_key = 'select_score', width = 96, u = 96, v = 32},
  {key = 'music', select_key = 'select_music', width = 160, u = 96, v = 160},
  {key = 'option', select_key = 'select_option', width = 96, u = 0, v = 64}
}
local kLogoWidth = 96
local kLogoHeight = 96
local kLogoX = 48
local kLogoY = 0
local kLogoYDifference = 44
local kMenuX = 336
local kMenuXDifference = 4
local kMenuY = 40
local kMenuYDifferebce = 24
local kMenuHeight = 32
local kMenuMax = 7
local kMenuMin = 1

local function init(menu_select)
  add_back_image(kTitle, kTitleImage)
  --[[for i, title_logo in ipairs(kTitleLogoTable) do
    i = i - 1
    if (i == 2) then
      add_image(title_logo, kTitleLogoRedImage)
      set_actor_uv(title_logo, 0, 0, kLogoWidth, kLogoHeight)
    else
      add_image(title_logo, kTitleLogoWhiteImage)
      local j = i > 2 and i - 1 or i
      set_actor_uv(title_logo, (j % 2) * kLogoWidth, math.floor(j / 2) * kLogoHeight, kLogoWidth, kLogoHeight)
    end
    resize_actor(title_logo, kLogoWidth / 2, kLogoHeight / 2)
    move_actor(title_logo, kLogoX, kLogoY + kLogoYDifference * i)
  end]]
  for i, menu in ipairs(kMenuTable) do
    add_image(menu.key, kTitleMenuImage)
    move_actor(menu.key, kMenuX - i * kMenuXDifference, kMenuY + i * kMenuYDifferebce)
    resize_actor(menu.key, menu.width, kMenuHeight)
    set_actor_uv(menu.key, menu.u, menu.v, menu.width, kMenuHeight)
    add_image(menu.select_key, kTitleSelectMenuImage)
    move_actor(menu.select_key, kMenuX - i * kMenuXDifference, kMenuY + i * kMenuYDifferebce)
    resize_actor(menu.select_key, menu.width, kMenuHeight)
    set_actor_uv(menu.select_key, menu.u, menu.v, menu.width, kMenuHeight)
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

local function clean_to_option()
  for i, title_logo in ipairs(kTitleLogoTable) do
    erase_actor(title_logo)
  end
  for i, menu in ipairs(kMenuTable) do
    erase_actor(menu.key)
    erase_actor(menu.select_key)
  end
end

local function reset(menu_select)
  --[[for i, title_logo in ipairs(kTitleLogoTable) do
    i = i - 1
    if (i == 2) then
      add_image(title_logo, kTitleLogoRedImage)
      set_actor_uv(title_logo, 0, 0, kLogoWidth, kLogoHeight)
    else
      add_image(title_logo, kTitleLogoWhiteImage)
      local j = i > 2 and i - 1 or i
      set_actor_uv(title_logo, (j % 2) * kLogoWidth, math.floor(j / 2) * kLogoHeight, kLogoWidth, kLogoHeight)
    end
    resize_actor(title_logo, kLogoWidth, kLogoHeight)
    move_actor(title_logo, kLogoX, kLogoY + kLogoYDifference * i)
  end]]
  for i, menu in ipairs(kMenuTable) do
    add_image(menu.key, kTitleMenuImage)
    move_actor(menu.key, kMenuX - i * kMenuXDifference, kMenuY + i * kMenuYDifferebce)
    resize_actor(menu.key, menu.width, kMenuHeight)
    set_actor_uv(menu.key, menu.u, menu.v, menu.width, kMenuHeight)
    add_image(menu.select_key, kTitleSelectMenuImage)
    move_actor(menu.select_key, kMenuX - i * kMenuXDifference, kMenuY + i * kMenuYDifferebce)
    resize_actor(menu.select_key, menu.width, kMenuHeight)
    set_actor_uv(menu.select_key, menu.u, menu.v, menu.width, kMenuHeight)
    if (i == menu_select) then
      sleep_actor(menu.key)
    else
      sleep_actor(menu.select_key)
    end
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

local function select_up(menu_select)
  stop_se('select')
  play_se('select', 1)
  change_not_select(menu_select)
  menu_select = menu_select - 1 < kMenuMin and kMenuMax or menu_select - 1
  change_select(menu_select)
  return menu_select
end

local function select_down(menu_select)
  stop_se('select')
  play_se('select', 1)
  change_not_select(menu_select)
  menu_select = menu_select + 1 > kMenuMax and kMenuMin or menu_select + 1
  change_select(menu_select)
  return menu_select
end

local function play_mode(menu_select)
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean()
  mode(menu_select)
end

local function extra_mode(menu_select)
end

local function plactice_mode(menu_select)
end

local function replay_mode(menu_select)
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean()
  replay(menu_select)
end

local function score_mode(menu_select)
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean()
  score(menu_select)
end

local function music_mode(menu_select)
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean()
  music(menu_select)
end

local function option_mode(menu_select)
  stop_se('ok')
  play_se('ok', 1)
  coroutine.yield()
  clean_to_option()
  option(menu_select)
  reset(menu_select)
end

local kFunctorTable = {play_mode, extra_mode, plactice_mode, replay_mode, score_mode, music_mode, option_mode}

local function update(menu_select)
  while true do
    if key_triger(kDown) == true then
      menu_select = select_down(menu_select)
    elseif key_triger(kUp) == true then
      menu_select = select_up(menu_select)
    elseif key_triger(kCircle) == true then
      kFunctorTable[menu_select](menu_select)
    end
    coroutine.yield()
  end
end

function title(menu_select)
  init(menu_select)
  update(menu_select)
end
