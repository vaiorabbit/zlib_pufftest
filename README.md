# puff.c|h �Υƥ��� #

    Last Update: Jul 08, 2012
    Since: Jul 08, 2012

zlib �� contrib/puff/puff.c|h ��������ˡ��ޤȤ᤿���

## �¹���ˡ ##

    $ make
	$ ./inflate loremipsum.txt.ZL
	$ head -1 loremipsum.txt
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
	# ...

## ���� ##

*   loremipsum.txt.ZL
	*   ���� deflate.rb �� loremipsum.txt �򰵽̤����ե�����

*   deflate.rb
	*   zlib ��Ȥäƥե�����򰵽�
		*   $ ruby deflate.rb loremipsum.txt
		*   $ ls loremipsum*
		    loremipsum.txt        loremipsum.txt.ZL     loremipsum.txt.backup

*   inflate.cpp
	*   puff() ��Ȥä����̥ե������Ÿ��

*   puff.c, puff.h
	*   zlib 1.2.7 ����Υ��ԡ�

*   inflate.rb
	*   zlib inflate ��Ȥä��ե������Ÿ��
		*   $ ruby inflate.rb loremipsum.txt.ZL

## ���̥ե�����Υե����ޥå� ##

    |���ե�����Υ�����(uint32)|
	|���̥������ȤΥ�����(uint32)| |���̥�������(uint8 x ľ���Υ�����)|
	|���̥������ȤΥ�����(uint32)| |���̥�������(uint8 x ľ���Υ�����)|
	...
	|0(uint32)|

## ��� ##

*   ���ե������ 8K ���ȤΥ������Ȥǰ��̤��Ƥ��뤱��ɡ����Υ������ϥ��ȥ꡼�ߥ�Ÿ���˻Ȥ���Хåե���������ۤ��ʤ��ϰϤ��礭������OK��
*   �ءְ��̡פ���ȥ������������뤳�Ȥ�����Τǡ����̥Хåե��������ϸ��Хåե��������ξ��ʤ��Ȥ�0.1�������Ȥ�����;͵�򸫤��礭��˼�äƤ����Ф����Ǥ��礦����
	*   ���� : http://oku.edu.mie-u.ac.jp/~okumura/compression/zlib.html
