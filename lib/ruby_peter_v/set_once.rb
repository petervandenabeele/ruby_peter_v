class RubyPeterV::SetOnceError < StandardError ; end

class Object

  def set_once(attribute, value)
    ivar_symbol = ivar_symbol(attribute)
    instance_value = instance_variable_get(ivar_symbol)
    validate_immutable(attribute, instance_value, value)
    instance_variable_set(ivar_symbol, value)
  end

private

  def ivar_symbol(attribute)
    unless attribute.is_a?(Symbol)
      raise(ArgumentError, 'first argument must be a symbol for the attribute')
    end
    :"@#{attribute}"
  end

  def validate_immutable(attribute, old_value, new_value)
    if (old_value && old_value != new_value)
      raise(
        RubyPeterV::SetOnceError,
        "Value of #{attribute} was #{old_value}, trying to set it to #{new_value}")
    end
  end

end
