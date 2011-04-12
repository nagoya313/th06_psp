local kLogo = 'logo'
local kLogoImageNama = 'image/th06logo.dds'

local function init()
  add_back_image(kLogo, kLogoImageNama)
end

local function clean()
  erase_actor(kLogo)
end

local function update()
  while true do
    if key_triger(kCircle) == true then
	  break
	end
    coroutine.yield()
  end
  coroutine.yield()
  clean()
  set_bgm(kMusicList[1].file, kMusicList[1].offset)
  play_bgm()
  title()
end

function logo()
  init()
  update()
end
