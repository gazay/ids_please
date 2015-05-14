# IDs, please

[![Build Status](https://travis-ci.org/gazay/ids_please.svg)](https://codeclimate.com/github/gazay/ids_please) [![ids_please API Documentation](https://www.omniref.com/ruby/gems/ids_please.png)](https://www.omniref.com/ruby/gems/ids_please)

Grab some hidden in html data from social account page. Get social network IDs or screen names from links to social network accounts.

Sometimes you need to get a social network account name from a link —
to store a screen name in your database instead of parsing the link every time,
or maybe to work with these accounts using social network APIs (as I do).
Would be easier to have a library that extracts this kind of information
from all known social networks for your pleasure.

<a href="https://evilmartians.com/?utm_source=ids_please">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54">
</a>

## Installation

```bash
gem install ids_please
```

Or, put this in your Gemfile:

```ruby
gem 'ids_please'
```

## Usage

This gem works in two modes – you can get real data from social network by http request and page parsing
and you can just parse link to social account to find username/id. Sometimes username from link can't be
used with social network's API, in this case try to get real ID with grab mode.

### Grabbing data from social account's page

This functionality works through real http requests, so if you feed it with many links – it can take a while.

As Facebook shows data only from public pages and public groups – in most cases you can't gather data from
any profile page. Same thing about private `instagram` accounts, profiles and private groups in `vk`.

Also you should provide real urls with right protocols. For example you will not receive any data from `http://facebook.com/Microsoft`,
but from `https://facebook.com/Microsoft` you'll receive all data as in example below:

```ruby
ids = IdsPlease.new('https://instagram.com/microsoft/', 'https://facebook.com/Microsoft')
ids.grab
=> {:instagram=>
    [IdsPlease::Grabbers::Instagram#70339427221180
      @link=https://instagram.com/microsoft/,
      @network_id=524549267,
      @avatar=https://igcdn-photos-h-a.akamaihd.net/hphotos-ak-xpf1/t51.2885-19/10729318_654650964633655_619168277_a.jpg,
      @display_name=Microsoft,
      @username=microsoft,
      @data={:bio=>"The official Instagram account of Microsoft. Celebrating people who break boundaries, achieve their goals, and #DoMore every day.", :website=>"http://msft.it/MSFTDoMore"}],
    :facebook=>
    [IdsPlease::Grabbers::Facebook#70339427168960
      @link=https://facebook.com/Microsoft,
      @network_id=20528438720,
      @avatar=https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfa1/v/t1.0-1/394366_10151053222893721_1961351328_n.jpg?oh=f3efc47a669cf291221ca421eaf016fb&oe=55C61365&__gda__=1440162054_3bf920ed0b4c0c7873c4ec44affcec15,
      @display_name=Microsoft,
      @username=Microsoft,
      @data={:type=>"company", :description=>"Welcome to the official Microsoft Facebook page, your source for news and conversation about..."}
    ]
   }

insta = ids.grabbed[:instagram].first
insta.avatar
=> "https://igcdn-photos-h-a.akamaihd.net/hphotos-ak-xpf1/t51.2885-19/10729318_654650964633655_619168277_a.jpg"
```

Social networks supported for grabbing at the moment:

* [Facebook](https://www.facebook.com)
* [Instagram](http://instagram.com)
* [Vkontakte](https://vk.com)

### Link parsing

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
