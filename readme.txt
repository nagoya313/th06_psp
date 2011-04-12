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
