# RubyPeterV

Ruby helpers for Peter Vandenabeele

[![Gem Version](https://badge.fury.io/rb/ruby_peter_v.png)](http://badge.fury.io/rb/ruby_peter_v)
[![Build Status](https://travis-ci.org/petervandenabeele/ruby_peter_v.png?branch=master)](http://travis-ci.org/petervandenabeele/ruby_peter_v)

## Installation

Add this line to your application's Gemfile:

    gem 'ruby_peter_v'

## Usage

### single on Enumerable (instead of unstable .first)

  The background of this is that in many cases,
  the developer knows there _should_ only be 1
  element in a collection. Using first is fine, but if
  inadvertently more elements are present, `.first`
  will happily choose a random entry (certainly with
  ActiveRecord first) which is a silent bug.

  single also works smartly on an Enumerable that
  does not have a `size` method (a lazy collection).
  It will only evaluate the first(2) elements of
  the collection to determine that it is oversized.

  When given a block, single will filter (select) on
  that block.

```
$ irb
2.0.0-p195 :001 > require 'ruby_peter_v'
 => true
2.0.0-p195 :002 > [].single
 => nil
2.0.0-p195 :003 > [1].single
 => 1
2.0.0-p195 :004 > [1,2].single
RubyPeterV::UniquenessError: size of collection was 2.
...
2.0.0-p247 :005 > [1,2,2].single{ |e| e == 1 }
 => 1
2.0.0-p247 :006 > [1,2,2].single{ |e| e == 2 }
RubyPeterV::UniquenessError: size of collection was 2.
...
```

### set_once(attribute, value) on Object

  Setting the instance variable with name attribute (a symbol),
  once to a value value. This acts as a simple form of an
  immutable attribute. After initialization of the object, it
  can still be set once from nil to a specific value, but after
  that, it can never be changed to a different value. Writing
  it twice with the same value does not throw an exception.
```
2.0.0-p195 :009 > class A
2.0.0-p195 :010?>   attr_reader :foo
2.0.0-p195 :011?>   def foo=(_foo)
2.0.0-p195 :012?>     set_once(:foo, _foo)
2.0.0-p195 :013?>   end
2.0.0-p195 :014?> end
 => nil
2.0.0-p195 :015 > a = A.new
 => #<A:0x007fa82905f720>
2.0.0-p195 :016 > a.foo
 => nil
2.0.0-p195 :017 > a.foo = 1
 => 1
2.0.0-p195 :018 > a.foo
 => 1
2.0.0-p195 :019 > a.foo = 1
 => 1
2.0.0-p195 :020 > a.foo = 2
SetOnceError: Value of foo was 1, trying to set it to 2
```

### entry_or_collection.each_recursively on Object

  Call the block on each entry that is given as entry, in a
  collection, or in a collection in a collection, etc. to
  unrestricted depth. This implementation only uses each and it
  loops recursively, so it never instantiates an array or actual
  collection of all objects (this allows streaming, lazy evaluation,
  e.g. for looping over objects that are read from a file that is
  much larger than the memory size).

  Returns self.

```
2.0.0-p195 :021 > [:a, [:b, [:c]]].each_recursively{ |e| puts e.succ }
b
c
d
```

### DefineEquality(*accessors) on Module

  Defining the equality (eql?, ==, hash) between instances.
  The class is included by default in the accessor list in
  the usage `include DefineEquality(:foo, :bar)`.

  Defining equality for instances of different classes is
  possible by manually defining the `equality_accessors`
  function (see the spec with the b5 instance).

```
2.0.0-p195 :022 > class B
2.0.0-p195 :023?>   include DefineEquality(:foo)
2.0.0-p195 :024?>   attr_accessor :foo
2.0.0-p195 :025?> end
 => nil
2.0.0-p195 :026 > b1 = B.new
 => #<B:0x007fc1488f4ce0>
2.0.0-p195 :027 > b1.foo = '1'
 => "1"
2.0.0-p195 :028 > b2 = B.new
 => #<B:0x007fc1488a0028>
2.0.0-p195 :029 > b2.foo = '1'
 => "1"
2.0.0-p195 :030 > b1 == b2
 => true
2.0.0-p195 :031 > b2.foo = '2'
 => "2"
2.0.0-p195 :032 > b1 == b2
 => false
```

### truncate_utf8(max_byte_size) on String

  Cutting off on bytes inside a utf-8 encoded string will create invalid strings.
  This implementation limits the number of _bytes_ (not the number of characters).
  It is based on the response of "Angelo" on
  http://joernhees.de/blog/2010/12/14/how-to-restrict-the-length-of-a-unicode-string/

```
/Users/peter_v/p/ruby_peter_v $ irb
2.0.0-p247 :001 > require 'ruby_peter_v'
 => true
2.0.0-p247 :002 > s = 'ABCDüéàè'
 => "ABCDüéàè"
2.0.0-p247 :003 > s.size
 => 8
2.0.0-p247 :004 > s.bytesize
 => 12
2.0.0-p247 :005 > s.truncate_utf8(4)
 => "ABCD"
2.0.0-p247 :006 > s.truncate_utf8(5)
 => "ABCD"
2.0.0-p247 :007 > s.truncate_utf8(5).bytesize
 => 4
2.0.0-p247 :008 > s.truncate_utf8(6)
 => "ABCDü"
2.0.0-p247 :009 > s.truncate_utf8(7)
 => "ABCDü"
2.0.0-p247 :010 > s.truncate_utf8(7).valid_encoding?
 => true
```
