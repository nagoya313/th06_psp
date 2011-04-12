何か問題があればすぐに消します。

Minimalist PSPSDK for Windowsを使っていますが、
ほげほげ\pspsdk\psp\include\oslib\intraFontに入っている"libccc.h"を
ほげほげ\pspsdk\psp\sdk\includeにコピーしてやらないとイントラフォント周りで
ヘッダが読み込めませんと怒られるみたいです。

あと何気にBoostを使ってますので、
適宜MakefileのBoostのインクルードディレクトリっぽいところを
適当にいじってやってください。

画像ファイルや音声ファイルは
各フォルダに入ってるれあどめを読んで適当に配置してやってください。

MakeFileで指定しているico.pngはXMBで表示されるアイコン、
pic.pngはアイコン選択時に表示される背景の画像ファイルなので
それぞれ140*80、480*272の同名のpngファイルを適当に用意して
Makefileと同じディレクトリに置いてやってください。
