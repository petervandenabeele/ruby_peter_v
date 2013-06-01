class Module

  def define_equality(*attributes)

    self.send(:define_method, :eql?) do |other|
      self.class == other.class &&
      attributes.all? do |attribute|
        self.send(attribute).eql?(other.send(attribute))
      end
    end

    self.send(:define_method, :==) do |other|
      self.class == other.class &&
      attributes.all? do |attribute|
        self.send(attribute) == (other.send(attribute))
      end
    end

    self.send(:define_method, :hash) do
      ([:class] + attributes).inject(0) do |acc, attribute|
        acc ^ send(attribute).hash
      end
    end

  end

end
