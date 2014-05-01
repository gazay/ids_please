# IDs, please

Get social network IDs or screen names from links to social network accounts.

Sometimes you need to get a social network account name from a link —
to store a screen name in your database instead of parsing the link every time,
or maybe to work with these accounts using social network APIs (as I do).
Would be easier to have a library that extracts this kind of information
from all known social networks for your pleasure.

Sponsored by [Evil Martians](http://evilmartians.com).

## Installation

```bash
gem install ids_please
```

Or, put this in your Gemfile:

```ruby
gem 'ids_please'
```

## Usage

This is how you get social IDs from from links:

```ruby
ids = IdsPlease.new('https://twitter.com/gazay', 'http://facebook.com/alexey.gaziev')
ids.parse
puts ids.parsed[:twitter]  # => ["gazay"]
puts ids.parsed[:facebook] # => ["alexey.gaziev"]

puts ids.original           # => ["https://twitter.com/gazay", "http://facebook.com/alexey.gaziev"]
```

Or you can just check that the link is for a known social network:

```ruby
ids = IdsPlease.new('https://twitter.com/gazay', 'http://some-unknown-network.com/gazay')
ids.recognize
puts ids.recognized   # => {:twitter=>[#<URI::HTTP:0x007fea3bba7e30 URL:http://twitter.com/gazay>]}
puts ids.unrecognized # => ["http://some-unknown-network.com/gazay"]
```

Social networks supported at the moment:

* [Facebook](https://www.facebook.com)
* [Twitter](https://twitter.com)
* [Instagram](http://instagram.com)
* [Soundcloud](http://soundcloud.com)
* [GooglePlus](https://plus.google.com)
* [Youtube](http://www.youtube.com)
* [Tumblr](http://tumblr.com)
* [Vimeo](http://vimeo.com)
* [Pinterest](http://pinterest.com)
* [Blogger](http://blogger.com)
* [Reddit](http://reddit.com)
* [Ameba](http://ameblo.jp)
* [Linkedin](http://linkedin.com)
* [Livejournal](http://livejournal.com)
* [Hi5](http://hi5.com)
* [Vkontakte](http://vk.com)
* [Odnoklassniki](http://odnoklassniki.ru)
* [Moikrug](https://moikrug.ru)

## Contributors

* @gazay

Special thanks to @ai, @yaroslav, @whitequark

## Notes

Gem named under an impression of an awesome game called [Papers, please](http://papersplea.se/)

## License

The MIT License
