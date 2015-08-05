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
require_relative 'parsers/mailru'

class IdsPlease
  module Parsers

    NETWORKS = {
      google_plus: IdsPlease::Parsers::GooglePlus,
      vkontakte: IdsPlease::Parsers::Vkontakte,
      twitter: IdsPlease::Parsers::Twitter,
      facebook: IdsPlease::Parsers::Facebook,
      instagram: IdsPlease::Parsers::Instagram,
      blogger: IdsPlease::Parsers::Blogger,
      ameba: IdsPlease::Parsers::Ameba,
      hi5: IdsPlease::Parsers::Hi5,
      linkedin: IdsPlease::Parsers::Linkedin,
      livejournal: IdsPlease::Parsers::Livejournal,
      reddit: IdsPlease::Parsers::Reddit,
      pinterest: IdsPlease::Parsers::Pinterest,
      soundcloud: IdsPlease::Parsers::Soundcloud,
      vimeo: IdsPlease::Parsers::Vimeo,
      youtube: IdsPlease::Parsers::Youtube,
      odnoklassniki: IdsPlease::Parsers::Odnoklassniki,
      tumblr: IdsPlease::Parsers::Tumblr,
      moikrug: IdsPlease::Parsers::Moikrug,
      mailru: IdsPlease::Parsers::Mailru
    }

    def self.each
      NETWORKS.values.each { |n| yield n }
    end

    def self.by_symbol(sym)
      NETWORKS[sym]
    end

  end
end
