# Vecmath

The purpose of this gem is to make Vec2D and Vec3D classes available through a gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vecmath'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vecmath

## Usage

All you need to do is `require 'vecmath'` to use `Vec2D` and `Vec3D` classes in your application.
For `:to_vertex` functionality you need to create a renderer:-
```ruby
@renderer = AppRender.new(graphics) # where graphics is instance of PGraphics
# Usage
vec.to_vertex(@renderer)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruby-processing/vecmath.
