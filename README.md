Bash3D
======

Bash **だけ** で3Dレンダリングしようという謎のプロジェクト。

ルール
-------------

 * dc / bcのような電卓は使わない。expr（整数演算のみ）使ってよし。
 * Perl/Ruby/Python/awkのような、チューリング完全のスクリプト言語を使ってはいけない（当たり前）
 * jq（シェルからjsonがいじれるコマンド）やそれに類する便利コマンドは標準では入ってないのでダメ
     * データ構造はリスト構造（ネストは出来るが、大きな速度ペナルティあり）のみ使用可能
 * 「bash」縛りなので、bashの拡張は使ってOK

