##
# Modified from the equitable function from ruby facets
#
# https://github.com/rubyworks/facets/blob/master/lib/standard/facets/equitable.rb
#
# Copyright (c) 2005,2010 Thomas Sawyer
# Licensed under the Ruby license and GPL license
# See https://github.com/rubyworks/facets/blob/master/LICENSE.txt
#
# This modified version falls under the license for this package

module DefineEquality

  # NOTE added :class as a default accessor
  def self.identify(base, *accessors)
    base.send(:define_method, :equality_accessors){ [:class] + accessors }
    self
  end

  def ==(o)
    equality_accessors.all?{ |a| send(a) == o.send(a) }
  end

  def eql?(o)
    equality_accessors.all?{ |a| send(a).eql?(o.send(a)) }
  end

  def hash
    equality_accessors.inject(0){ |acc, a| acc ^ send(a).hash }
  end

end

class Module

  # In `include DefineEquality(:foo)`
  # * this _method_ is called first
  # * it sets the equality_accessors list of accessors
  # * that returns self (the module DefineEquality)
  # * which is then included and overrides the
  #   equality and hash methods
  def DefineEquality(*accessors)
    DefineEquality.identify(self, *accessors)
  end

end
