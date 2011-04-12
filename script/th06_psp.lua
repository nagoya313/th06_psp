require('script/logo')
require('script/title')
require('script/mode')
require('script/player_select')
require('script/spell_select')
require('script/replay')
require('script/score')
require('script/music')
require('script/music_table')

local co

function init()
  co = coroutine.create(logo)
  add_se('select', 'se/select00.wav')
  add_se('ok', 'se/ok00.wav')
  add_se('cancel', 'se/cancel00.wav')
end

function update()
  coroutine.resume(co)
end
