class String

  def truncate_utf8(max_byte_size)
    cut_off = self.bytes.to_a[0...max_byte_size].pack('c*').force_encoding('UTF-8')
    while ! cut_off.valid_encoding? do
      cut_off = cut_off[0..-2]
    end
    cut_off
  end

end
