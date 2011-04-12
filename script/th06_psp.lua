require('script/logo')
require('script/title')
require('script/mode')
require('script/player_select')
require('script/spell_select')
require('script/replay')
require('script/score')
require('script/music')
require('script/option')
require('script/music_table')
require('script/se_table')

local co

function init()
  co = coroutine.create(logo)
  for i, se in ipairs(kSeList) do
    add_se(se.key, se.file)
  end
end

function update()
  coroutine.resume(co)
end
