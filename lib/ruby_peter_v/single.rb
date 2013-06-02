class RubyPeterV::UniquenessError < StandardError ; end

module Enumerable

  def single(&block)
    filtered = block_given? ? self.select(&block) : self
    _size = filtered.size
    raise RubyPeterV::UniquenessError, "size of set was #{_size}" if _size > 1
    filtered.first
  end

end
