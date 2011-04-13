require('script/actor')
require('script/logo')
require('script/title')
require('script/mode')
require('script/player_select')
require('script/spell_select')
require('script/replay')
require('script/score')
require('script/music')
require('script/option')
require('script/game')
require('script/music_table')
require('script/se_table')

local co

function init()
  co = coroutine.create(logo)
end

function update()
  coroutine.resume(co)
end
