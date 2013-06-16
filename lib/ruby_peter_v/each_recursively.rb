class Object

  def each_recursively(&block)
    if self.respond_to?(:each)
      loop_over_collection(self, &block)
    else
      yield(self)
    end
    self
  end

private

  def loop_over_collection(entry_or_collection, &block)
    entry_or_collection.each do |inner_entry_or_collection|
      inner_entry_or_collection.each_recursively(&block)
    end
  end

end
