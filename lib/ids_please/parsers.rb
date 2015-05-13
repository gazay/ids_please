require_relative 'parsers/base'
require_relative 'parsers/facebook'
require_relative 'parsers/google_plus'
require_relative 'parsers/instagram'
require_relative 'parsers/blogger'
require_relative 'parsers/ameba'
require_relative 'parsers/hi5'
require_relative 'parsers/livejournal'
require_relative 'parsers/linkedin'
require_relative 'parsers/pinterest'
require_relative 'parsers/reddit'
require_relative 'parsers/twitter'
require_relative 'parsers/tumblr'
require_relative 'parsers/vimeo'
require_relative 'parsers/youtube'
require_relative 'parsers/soundcloud'
require_relative 'parsers/vkontakte'
require_relative 'parsers/odnoklassniki'
require_relative 'parsers/moikrug'

class IdsPlease
  module Parsers

    NETWORKS = [
      IdsPlease::Parsers::GooglePlus,
      IdsPlease::Parsers::Vkontakte,
      IdsPlease::Parsers::Twitter,
      IdsPlease::Parsers::Facebook,
      IdsPlease::Parsers::Instagram,
      IdsPlease::Parsers::Blogger,
      IdsPlease::Parsers::Ameba,
      IdsPlease::Parsers::Hi5,
      IdsPlease::Parsers::Linkedin,
      IdsPlease::Parsers::Livejournal,
      IdsPlease::Parsers::Reddit,
      IdsPlease::Parsers::Pinterest,
      IdsPlease::Parsers::Soundcloud,
      IdsPlease::Parsers::Vimeo,
      IdsPlease::Parsers::Youtube,
      IdsPlease::Parsers::Odnoklassniki,
      IdsPlease::Parsers::Tumblr,
      IdsPlease::Parsers::Moikrug
    ]

    def self.each
      NETWORKS.each { |n| yield n }
    end
  end
end
