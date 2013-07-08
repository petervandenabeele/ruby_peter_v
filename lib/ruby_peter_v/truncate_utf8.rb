class String

  def truncate_utf8(max_byte_size)
    self.bytes.to_a[0...max_byte_size].pack('c*').force_encoding('UTF-8').encode("UTF-16BE", :invalid => :replace, :replace =>"").encode("UTF-8")
  end

end
