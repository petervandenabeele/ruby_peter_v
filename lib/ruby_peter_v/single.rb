class RubyPeterV::UniquenessError < StandardError ; end

module Enumerable

  def single
    raise RubyPeterV::UniquenessError, "size of set was #{size}" if size > 1
    first
  end

end
