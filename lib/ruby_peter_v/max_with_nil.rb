class Object

  def max_with_nil(a,b)
    if b.nil?
      a
    else
      if a.nil?
        b
      else
        (b > a) ? b : a
      end
    end
  end

end
