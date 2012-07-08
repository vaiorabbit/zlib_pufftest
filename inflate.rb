require 'zlib'

module ZLConfig
  ORIG_LENGTH = 8192
  DEST_LENGTH = 8300
end

def decompress( f_in, f_out )
  comp_segment_size = f_in.read(4).unpack("L")[0]
  while !f_in.eof? && comp_segment_size != 0
    comp_segment = f_in.read(comp_segment_size)
    orig_segment = Zlib::Inflate.new.inflate( comp_segment )

    comp_segment_size = f_in.read(4).unpack("L")[0]
    # print "comp_segment_size > DEST_LENGTH\n" if orig_segment.size > ZLConfig::DEST_LENGTH

    f_out << orig_segment
  end
end

if __FILE__ == $0
  if ARGV[0].slice(/...$/) == ".ZL"
    in_filename = ARGV[0]
    out_filename = in_filename.chomp(".ZL")
    f_in = File.new( in_filename, "r:BINARY" )
    f_out = File.new( out_filename, "w:BINARY" )

    original_file_size = f_in.read(4).unpack("L")[0]
    # print( "Original File Size = #{original_file_size}\n" )

    decompress( f_in, f_out )

    f_in.close()
    f_out.close()
  end
end
