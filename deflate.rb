# -*- coding: utf-8 -*-
require 'zlib'

module ZLConfig
  ORIG_LENGTH = 8192
  DEST_LENGTH = 8300
end

def compress( f_in, f_out )
  f_out << [f_in.size].pack("L") # ファイル先頭は元ファイルのサイズ
  while !f_in.eof?
    # |圧縮セグメントのサイズ||圧縮セグメント| の順に連結
    z = Zlib::Deflate.new( Zlib::BEST_COMPRESSION )
    comp_segment = z.deflate( f_in.read(ZLConfig::ORIG_LENGTH), Zlib::FINISH )
    # [注意] 「圧縮」の結果、元データよりも圧縮データのサイズが大きくなる場合もある
    f_out << [comp_segment.size].pack("L")
    f_out << comp_segment
  end
  f_out << [0].pack("L") # 終端を示す unsigned int 0
end

if __FILE__ == $0
  in_filename = ARGV[0]
  out_filename = in_filename + ".ZL"
  f_in = File.new( in_filename, "r:BINARY" )
  f_out = File.new( out_filename, "w:BINARY" )
  compress( f_in, f_out )
  f_in.close()
  f_out.close()
end
