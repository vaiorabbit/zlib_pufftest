# puff.c|h のテスト #

    Last Update: Jul 08, 2012
    Since: Jul 08, 2012

zlib の contrib/puff/puff.c|h の利用方法をまとめたもの

## 実行方法 ##

    $ make
	$ ./inflate loremipsum.txt.ZL
	$ head -1 loremipsum.txt
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
	# ...

## 内容 ##

*   loremipsum.txt.ZL
	*   下記 deflate.rb で loremipsum.txt を圧縮したファイル

*   deflate.rb
	*   zlib を使ってファイルを圧縮
		*   $ ruby deflate.rb loremipsum.txt
		*   $ ls loremipsum*
		    loremipsum.txt        loremipsum.txt.ZL     loremipsum.txt.backup

*   inflate.cpp
	*   puff() を使った圧縮ファイルの展開

*   puff.c, puff.h
	*   zlib 1.2.7 からのコピー

*   inflate.rb
	*   zlib inflate を使ったファイルの展開
		*   $ ruby inflate.rb loremipsum.txt.ZL

## 圧縮ファイルのフォーマット ##

    |元ファイルのサイズ(uint32)|
	|圧縮セグメントのサイズ(uint32)| |圧縮セグメント(uint8 x 直前のサイズ)|
	|圧縮セグメントのサイズ(uint32)| |圧縮セグメント(uint8 x 直前のサイズ)|
	...
	|0(uint32)|

## メモ ##

*   元ファイルを 8K ごとのセグメントで圧縮しているけれど、このサイズはストリーミング展開に使えるバッファサイズを越えない範囲で大きくしてOK。
*   『「圧縮」するとサイズが増えることがあるので，圧縮バッファサイズは元バッファサイズの少なくとも0.1％増しとし，…余裕を見て大きめに取っておけばいいでしょう。』
	*   参考 : http://oku.edu.mie-u.ac.jp/~okumura/compression/zlib.html
*   'source + 2'? : zlib の uncompress() にはそのまま渡せるのに対し、puff() にとっては先頭2バイトが余計なデータとなっている模様。
	*   参考 : tinf - tiny inflate library http://www.ibsensoftware.com/download.html
