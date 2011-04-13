local kFrontImageFileName = 'image/front.dds'
local kLogaList = {
  {key = 'to', x = 320, y = 140}, 
  {key = 'ho', x = 360, y = 140},
  {key = 'ko', x = 360, y = 180},
  {key = 'ma', x = 360, y = 220},
  {key = 'kyo', x = 400, y = 220}
}
local kPlayerImageFileNameList = {'image/player00.dds', 'image/player01.dds'}
local x = 240
local y = 160

local function init(character_select)
  add_image('player', kPlayerImageFileNameList[character_select == 1 and 1 or 2])
  set_actor_uv('player', 0, 0, 16, 24)
  resize_actor('player', 32, 48)
  move_actor('player', x, y)
  set_bgm(kMusicList[kStage1Music].file, kMusicList[kStage1Music].offset)
  play_bgm()
  for i = 1, 8 do
  	for j = 1, 9 do
      local key = 'frame' .. tostring(i) .. '_' .. tostring(j)
      add_image(key, kFrontImageFileName)
      resize_actor(key, 32, 32)
      set_actor_uv(key, 0, 224, 32, 32)
      local x = i > 2 and i + 7 or i
      move_actor(key, -32 + x * 32, -32 + 32 * j)
    end 
  end
  add_image('loop', kFrontImageFileName)
  resize_actor('loop', 96, 96)
  move_actor('loop', 336, 160)
  set_actor_uv('loop', 128, 128, 128, 128)
  for i, title in ipairs(kLogaList) do
    add_image(title.key, kFrontImageFileName)
    resize_actor(title.key, 48, 48)
    i = i - 1
    set_actor_uv(title.key, (i % 4) * 64, math.floor(i / 4) * 64, 64, 64)
    move_actor(title.key, title.x, title.y)
  end
  add_image('high_score', kFrontImageFileName)
  resize_actor('high_score', 64, 16)
  set_actor_uv('high_score', 0, 192, 64, 16)
  move_to_actor('high_score', 296, 8)
  add_image('score', kFrontImageFileName)
  resize_actor('score', 32, 16)
  set_actor_uv('score', 0, 208, 32, 16)
  move_to_actor('score', 296, 28)
  add_image('player_num', kFrontImageFileName)
  resize_actor('player_num', 48, 16)
  set_actor_uv('player_num', 0, 176, 48, 16)
  move_to_actor('player_num', 296, 48)
  add_image('bomb', kFrontImageFileName)
  resize_actor('bomb', 48, 16)
  set_actor_uv('bomb', 0, 160, 48, 16)
  move_to_actor('bomb', 296, 68)
  add_image('power', kFrontImageFileName)
  resize_actor('power', 48, 16)
  set_actor_uv('power', 32, 208, 48, 16)
  move_to_actor('power', 296, 88)
  add_image('graze', kFrontImageFileName)
  resize_actor('graze', 48, 16)
  set_actor_uv('graze', 32, 224, 48, 16)
  move_to_actor('graze', 296, 108)
  add_image('point', kFrontImageFileName)
  resize_actor('point', 16, 16)
  set_actor_uv('point', 48, 160, 16, 16)
  move_to_actor('point', 296, 128)
end

local list = {}

local function update(character_select)
  local frame = 0
  local cnt = 0
  while true do
    for i, ballet in ipairs(list) do
      local x, y = ballet:get_position()
      ballet:update()
      if y < -16 then
        ballet:erase()
        table.remove(list, i)
      end
    end
    set_actor_uv('player', 32 * (cnt % 4), 0, 32, 48)
    if frame % 4 == 0 then
      cnt = cnt + 1
    end
    local move_x = 0
    local move_y = 0
    if frame % 4 == 0 and key_down(kCircle) == true then
      table.insert(list, shot:new(kPlayerImageFileNameList[character_select == 1 and 1 or 2]))
    end
    if key_down(kUp) == true then
      move_y = -4
    end
    if key_down(kDown) == true then
      move_y = 4
    end
    if key_down(kRight) == true then
      move_x = 4
    end
    if key_down(kLeft) == true then
      move_x = -4
    end
    if move_x ~=0 and move_y ~= 0 then
      move_x = move_x / 1.41421356
      move_y = move_y / 1.41421356
    end
    local x, y = get_actor_position('player')
    x = x + move_x
    x = x > 264 and 264 or x
    x = x < 58 and 58 or x
    y = y + move_y
    y = y > 236 and 236 or y
    y = y < 0 and 0 or y
    move_to_actor('player', x, y)
    frame = frame + 1
    coroutine.yield()
  end
end

function game(character_select)
  init(character_select)
  update(character_select)
end
