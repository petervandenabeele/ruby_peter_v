# RubyPeterV

Ruby helpers for Peter Vandenabeele

## Installation

Add this line to your application's Gemfile:

    gem 'ruby_peter_v'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_peter_v

## Usage

* .single on enumerable (instead of unstable .first)

  The background of this is that in many cases,
  the developer knows there _should_ only be 1
  element in the set. Using first is fine, but if
  inadvertently, more elements are present, the first
  will happily choose a random entry (certainly with
  ActiveRecord first) which is silent bug.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
