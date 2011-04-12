local music_name = {
  '　１、赤より紅い夢',
  '　２、ほおずきみたいに紅い魂',
  '　３、妖魔夜行',
  '　４、ルーネイトエルフ',
  '　５、おてんば恋娘',
  '　６、上海紅茶館　～ Chinese Tea',
  '　７、明治十七年の上海アリス',
  '　８、ヴワル魔法図書館',
  '　９、ラクトガール　～ 少女密室',
  '１０、メイドと血の懐中時計',
  '１１、月時計　～ ルナ・ダイアル',
  '１２、ツェペシュの幼き末裔',
  '１３、亡き王女の為のセプテット',
  '１４、魔法少女達の百年祭',
  '１５、U.N.オーエンは彼女なのか？',
  '１６、紅より儚い永遠',
  '１７、紅楼　～ Eastern Dream...'
}

local music_key = {'No1', 'No2', 'No3', 'No4', 'No5', 'No6', 'No7', 'No8', 'No9', 'No10', 'No11', 'No12', 'No13', 'No14', 'No15', 'No16', 'No17'}

local music_message = {
  'No1. 赤より紅い夢\n　タイトル画面テーマです。\n  東方なんで、和風にしてみました。いやほんと。\n　ゲームはまるで和風じゃないくせに(^^;\n　ＳＴＧとは思えないような曲です。\n　そももそタイトル画面に曲は必要なのでしょうか（笑）？',
  'No2. ほおずきみたいに紅い魂\n　一面テーマです。\n　夜の森もイメージしてあります。一面だし、曲に勇ましさがあると\n　やる気が出るかなと思い、ちょっと元気ある曲を目指しました。\n　勇ましさというかコミカルな百鬼夜行って感じかな？',
  'No3. 妖魔夜行\n　ルーミアのテーマです。\n　この曲に限らず、今回、全体的に軽快な曲になっています。\n　この曲は夜の妖怪をイメージしました、\n　　　・・・って言っても良いんだろうか(^^;\n　ノリ的には結構\馬鹿っぽいです。',
  'No4. ルーネイトエルフ\n ２面のテーマです。\n　水と霧をイメージして、ちょっと不気味さも混ぜて見ました。\n　過去の東方のイメージとほとんど同じ感じとも言える。\n　２面って言うと、なんの為にあるのかよく分からないからなぁ(^^;',
  'No5. おてんば恋娘\n　チルノのテーマです。\n　やっぱり、頭の悪い少女をイメージしてます。\n　その割には明るいんだか暗いんだか分からない曲に仕上がって\n　なんとも、ハイスピードニしっとりとしたメインメロディとか。\nまぁ、２面だし（ぉ',
  'No6. 上海紅茶館　～ Chinese Tea\n　３面テーマです。\n　中華風に仕上げる予定でしたが、結果そんなでも無いようです(^^;\n　でも曲は東洋風です。４面以降に東洋風の曲を作ることが出来なさ\n　そうだったので、ここでつくっときました(^^;\n　Fusionというより New Age風かな？',
  'No7. 明治十七年の上海アリス\n　紅　美鈴（ホン・メイリン）のテーマです。\n　欧羅巴の香りとゲーム音楽の香りを混ぜてあります。（2:8位で）\n　中華でも何でも無いあたりがアレです。上海のフランス租界をイメ\n　－ジしているからです。\n　もっとも、美鈴も人間では無いみたいだけど、何物なんだろう（ぉ',
  'No8. ヴワル魔法図書館\n　４面テーマです。\nこの面から室内ステージです。曲も室内の雰囲気をだしてみまし\nた。後半、中ボスあたりから不気味さが出るように曲調が変化し\n　ます。\n　それ以外には特に特徴も無いですが、強いていえば、ＳＴＧの曲\n　ではない（笑）',
  'No9. ラクトガール　～ 少女密室\n　パチュリー・ノーレッジのテーマです。\n　ああ、またいつもの悪い病気が...\n　暗い曲です。こんなにも激しいのに明るさも軽快さも感じません\n　もうちょっと気持ちよければいいんですが、この曲聴くと微妙に\n　暗い気分になる感じがします（笑）',
  'No10. メイドと血の懐中時計\n　５面のテーマです。\n　不思議な不思議な曲です。\n　スピードを出そうとしてつんのめりそ\n　うな曲になってるのは、特殊な拍子のせいでしょうか？\n　ロックにしたかったんですが、私はあまりロックを聴かない所為\n　か、ロックというものを誤解している可能性大(^^;',
  'No11. 月時計　～ ルナ・ダイアル\n　十六夜　咲夜（いざよい・さくや）のテーマです。\n　メイドさんといえばハードロック（嘘）\n\n　やっぱり誤解してるのかなぁ(^^; >ロック\n　私的詩的ロックということで',
  'No12. ツェペシュの幼き末裔\n　最終面のテーマです。\n最終面はいつもしっとりさせすぎていたので、今回は軽快なノリ\n　で。短いステージのただのつなぎの曲なので、あまり自己主張\n　させないような曲にしました。',
  'No13. 亡き王女の為のセプテット\n　レミリア・スカーレットのテーマです。\nこれがラストだ！といわんばかりの曲を目指しました。\n　あんまり重厚さを出したり不気味さを出したり、そういうありが\n　ちラストは嫌なので、ジャズフュージョンチックにロリっぽさを\n　混ぜて. . .、ってそれじゃあいつもとあんまり変らんな。\n　このメロディは自分でも理解しやすく、気に入っています。',
  'No14. 魔法少女達の百年祭\n　エキストラステージのテーマです。\n　時折中華風です。時折ニューエイジ風です。それはなぜか？ \n　何もテーマも考えずにキーボードを弾いてしまったら、こうなっ\n　てしまいました。\n　私の惰性の集大成見たいな曲です。よく聴くと、謎めいたフレー\n　ズが詰まっています。私のおもちゃ箱ですね。',
  'No15. U.N.オーエンは彼女なのか？\n　フランドール・スカーレットのテーマです。\n　今回のもっともお気に入りです。いかにして悪魔っ娘を東洋風に\n　かつ、ミステリアスに表\現できるかに挑戦した結果です。\n　ロリっぽいこのメロディは、今作品でももっとも私らしいメロディ\n　で、鍵盤弾くのが楽しかったです。',
  'No16. 紅より儚い永遠\n　エンディングテーマです。\n　曲名から想像つくように、タイトル画面の曲の編曲みたいなもの\n　です。そのため和風です。\n　というか、和風で良いんですが。',
  'No17. 紅楼　～ Eastern Dream...\n スタッフロールのテーマです。\n　いつもは絶望的に暗い曲ばっかのスタッフロールでしたが、今回\n　は希望的に明るくしました。多分。\n　相変わらずスタッフが少ないので、あまり長い曲には出来ません。\n　もっと壮大な曲でも良かったんですが、割と印ルーム名印象の\n　曲になりました。これは意図していません（笑）'
}

music_intro = {
  0x102670,
  0x37E5D4,
  0x07BCA4,
  0x128C9C,
  0x0F9640,
  0x7919C8,
  0x3F5B30,
  0x0B2818,
  0x4F19FC,
  0x373E7C,
  0x0E9D18,
  0x0A2180,
  0x595D74,
  0x608258,
  0x0C07F0,
  0x186D40,
  0x0E9E20
}

local music_select = 1

local function init()
  add_back_image('music', 'image/music.dds')
  add_image('room', 'image/music00.dds')
  resize_actor('room', 128, 32)
  move_actor('room', 32, 8)
  set_actor_uv('room', 0, 0, 128, 32)
  for i, name in ipairs(music_name) do
    add_text(name, 16, 48 + 16 * i, music_name[i])
    add_text(music_key[i], 48, 192, music_message[i])
    resize_actor(music_key[i], 0.7, 0)
    set_actor_color(music_key[i], 0xAA, 0xAA, 0xFF)
  	if i == music_select then
      set_actor_color(name, 0xAA, 0xAA, 0xFF)
    else
      set_actor_color(name, 0x64, 0x64, 0x80)
    end
  	resize_actor(name, 0.8, 0)
    if i ~= 1 then
      sleep_actor(music_key[i])
    end
    if i > 7 then
      sleep_actor(name)
    end
  end
end

local function clean()
  erase_actor('music')
  erase_actor('room')
  erase_actor('name')
  for i, name in ipairs(music_name) do
    erase_actor(name)
    erase_actor(music_key[i])
  end
end

local function update()
  while true do
    if key_triger(kDown) == true then
      sleep_actor(music_key[music_select])
      set_actor_color(music_name[music_select], 0x64, 0x64, 0x80)
      music_select = music_select + 1 > 7 and 1 or music_select + 1
      active_actor(music_key[music_select])
      set_actor_color(music_name[music_select], 0xAA, 0xAA, 0xFF)
    elseif key_triger(kUp) == true then
      sleep_actor(music_key[music_select])
      set_actor_color(music_name[music_select], 0x64, 0x64, 0x80)
      music_select = music_select - 1 < 1 and 7 or music_select - 1
      active_actor(music_key[music_select])
      set_actor_color(music_name[music_select], 0xAA, 0xAA, 0xFF)
    elseif key_triger(kCross) == true then
      stop_se('cancel')
      play_se('cancel', 1)
      coroutine.yield()
      clean()
      title()
    end
    coroutine.yield()
  end
end

function music()
  init()
  update()
end
