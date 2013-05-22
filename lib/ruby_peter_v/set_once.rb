class SetOnceError < StandardError ; end

class Object

  def set_once(attribute, value)
    ivar_symbol = :"@#{attribute}"
    instance_value = instance_variable_get(ivar_symbol)
    if (instance_value && instance_value != value)
      raise(
        SetOnceError,
        "Value of #{attribute} was #{instance_value}, trying to set it to #{value}")
    end
    instance_variable_set(:"@#{attribute}", value)
  end

end
