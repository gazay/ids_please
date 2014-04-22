# Ids, please

Helps to get ids or screen names from links to social accounts.

Sometimes you need to get ids or screen names from links to social accounts.
Maybe to store not whole link in your db, maybe to work with those accounts
through social networks API (as I do). And you don't want to write or double your
code from project to project to do this. So I wrote this gem to store all this logic
in one place.

Sponsored by [Evil Martians](http://evilmartians.com).

## Installation

```bash
gem install ids_please
```

Or in Gemfile

```ruby
gem 'ids_please'
```

## Usage

You can use this gem to get ids from links:

```ruby
ids = IdsPlease.new('https://twitter.com/gazay', 'http://facebook.com/alexey.gaziev')
ids.parse
puts ids.parsed['Twitter']  # => "gazay"
puts ids.parsed['Facebook'] # => "alexey.gaziev"

puts ids.original           # => ["https://twitter.com/gazay", "http://facebook.com/alexey.gaziev"]
```

Or you can just check that link relates or not to some social network:

```ruby
ids = IdsPlease.new('https://twitter.com/gazay', 'http://some-unknown-network.com/gazay')
ids.recognize
puts ids.recognized   # => {"Twitter"=>[#<URI::HTTP:0x007fea3bba7e30 URL:http://twitter.com/gazay>]}
puts ids.unrecognized # => ["http://some-unknown-network.com/gazay"]
```

Right now gem supports next social networks:

* Facebook
* Twitter
* Instagram
* Soundcloud
* GooglePlus
* Youtube
* Tumblr
* Vimeo
* Vkontakte
* Odnoklassniki

## Contributors

* @gazay

## Notes

Gem named under impression of awesome game [Papers, please](http://papersplea.se/)

## License

The MIT License
