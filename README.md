# EmojiTranslate

EmojiTranslate Ruby gem allows you to 📚 translate text to ✨ emoji ✨

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'emoji_translate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install emoji_translate

## Usage

Require the gem and use `EmojiTranslate#translate(text)` to replace words with emojis. Make sure your development environment supports Unicode.

    require 'emoji_translate'
    
    EmojiTranslate.translate "A quick brown fox jumped over a lazy dog"
    => "🅰️ quick 🐴 fox jumped over 🅰️ lazy 🐶"

All punctuation and line breaks are preserved in the result string.

    EmojiTranslate.translate "Hello, world!"
    => "👋, 🌎!"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vpukhanov/emoji_translate.

I am new to Ruby, so any help with making the code more idiomatic (and cleaning it up in general) would be of great help and really appreciated!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
