class Object

  def do_recursively(entry_or_collection, &block)
    if entry_or_collection.respond_to?(:each)
      loop_over_collection(entry_or_collection, &block)
    else
      yield(entry_or_collection)
    end
  end

  def loop_over_collection(entry_or_collection, &block)
    entry_or_collection.each do |inner_entry_or_collection|
      do_recursively(inner_entry_or_collection, &block)
    end
  end

end
