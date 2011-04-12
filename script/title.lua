local key_table = {'to', 'ho', 'ko', 'ma', 'kyo'}
local menu_table = {'play', 'extra', 'plactice', 'replay', 'score', 'music', 'option'}
local select_menu_table = {'select_play', 'select_extra', 'select_plactice', 'select_replay', 'select_score', 'select_music', 'select_option'}
local menu_size = {40, 88, 96, 48, 48, 80, 48}
local menu_uv = {{u = 0, v = 0}, {u = 40, v = 0}, {u = 0, v = 96}, {u = 0, v = 16}, {u = 48, v = 16}, {u = 48, v = 80}, {u = 0, v = 32}}
local select = 1

local function init()
  add_back_image('title', 'image/title00.dds')
  for i, key in ipairs(key_table) do
    i = i - 1
    if (i == 2) then
      add_image(key, 'image/title03.dds')
      set_actor_uv(key, 0, 0, 48, 48)
    else
      add_image(key, 'image/title02.dds')
      local j = i > 2 and i - 1 or i
      set_actor_uv(key, (j % 2) * 48, math.floor(j / 2) * 48, 48, 48)
    end
    resize_actor(key, 48, 48)
    move_actor(key, 48, 24 + 40 * i)
  end
  for i, menu in ipairs(menu_table) do
    add_image(menu, 'image/title01.dds')
    move_actor(menu, 336 - i * 4, 112 + i * 16)
    resize_actor(menu, menu_size[i], 16)
    set_actor_uv(menu, menu_uv[i].u, menu_uv[i].v, menu_size[i], 16)
    add_image(select_menu_table[i], 'image/title01s.dds')
    move_actor(select_menu_table[i], 336 - i * 4, 112 + i * 16)
    resize_actor(select_menu_table[i], menu_size[i], 16)
    set_actor_uv(select_menu_table[i], menu_uv[i].u, menu_uv[i].v, menu_size[i], 16)
    if (i == select) then
      sleep_actor(menu_table[i])
    else
      sleep_actor(select_menu_table[i])
    end
  end
end

local function clean()
  erase_actor('title')
  for i, key in ipairs(key_table) do
    erase_actor(key)
  end
  for i, menu in ipairs(menu_table) do
    erase_actor(menu)
    erase_actor(select_menu_table[i])
  end
end

function title()
  init()
  while true do
    if key_triger(kDown) == true then
      stop_se('select')
      play_se('select', 1)
      active_actor(menu_table[select])
      sleep_actor(select_menu_table[select])
      select = select + 1 > 7 and 1 or select + 1
      active_actor(select_menu_table[select])
      sleep_actor(menu_table[select])
    elseif key_triger(kUp) == true then
      stop_se('select')
      play_se('select', 1)
      active_actor(menu_table[select])
      sleep_actor(select_menu_table[select])
      select = select - 1 < 1 and 7 or select - 1
      active_actor(select_menu_table[select])
      sleep_actor(menu_table[select])
    elseif key_triger(kCircle) == true then
      if select == 1 then
        stop_se('ok')
        play_se('ok', 1)
        coroutine.yield()
        clean()
        mode()
      elseif select == 4 then
        stop_se('ok')
        play_se('ok', 1)
        coroutine.yield()
        clean()
        replay()
      elseif select == 5 then
        stop_se('ok')
        play_se('ok', 1)
        coroutine.yield()
        clean()
        score()
      elseif select == 6 then
        stop_se('ok')
        play_se('ok', 1)
        coroutine.yield()
        clean()
        music()
      end
    end
    coroutine.yield()
  end
end
