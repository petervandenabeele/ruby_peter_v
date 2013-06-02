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
  element in the set. Using first is fine, but if
  inadvertently more elements are present, the first
  will happily choose a random entry (certainly with
  ActiveRecord first) which is a silent bug.

### max_with_nil on Object

  Finding the max of two arguments, but if one of them
  is nil, take the other one, and both nil, return nil.
  This is similar to the behavior ios nil would be considered
  smaller than all other objects.

### set_once(attribute, value) on Object

  Setting the instance variable with name attribute (a symbol),
  once to a value value. This acts as a simple form of an
  immutable attribute. After initialization of the object, it
  can still be set once from nil to a specific value, but after
  that, it can never be changed to a different value. Writing
  it twice with the same value does not trow an exception.

### do_recursively(entry_or_collection, &block) on Object

  Call the block on each entry that is given as entry, in a
  collection, or in a colletion in a collection to unrestricted
  depth. This implementation only uses each and loops recursively,
  so it never instantiates an array or actual collection of all
  objects (this allows streaming, lazy evaluation, e.g. for looping
  over objects that are read from a file that is much larger than
  the memory size, needed for Big Data processing).


