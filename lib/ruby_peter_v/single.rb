class RubyPeterV::UniquenessError < StandardError ; end

module Enumerable

  def single(&block)
    filtered = block_given? ? self.select(&block) : self
    if filtered.respond_to?(:size)
      _size = filtered.size
      message = _size
    else
      _size = filtered.first(2).size
      message = "greater than 1 (on Enumerable, the size cannot be calculated)"
    end
    raise RubyPeterV::UniquenessError, "size of collection was #{message}." if _size > 1
    filtered.first
  end

end
