class NilClass

  def single
    self
  end

end

module Enumerable

  def single
    raise "INTERNAL ERROR: size of set was #{size}" if size > 1
    first
  end

end
