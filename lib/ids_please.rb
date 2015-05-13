require 'uri'
require 'cgi'
require_relative 'ids_please/parsers/base'
require_relative 'ids_please/parsers/facebook'
require_relative 'ids_please/parsers/google_plus'
require_relative 'ids_please/parsers/instagram'
require_relative 'ids_please/parsers/blogger'
require_relative 'ids_please/parsers/ameba'
require_relative 'ids_please/parsers/hi5'
require_relative 'ids_please/parsers/livejournal'
require_relative 'ids_please/parsers/linkedin'
require_relative 'ids_please/parsers/pinterest'
require_relative 'ids_please/parsers/reddit'
require_relative 'ids_please/parsers/twitter'
require_relative 'ids_please/parsers/tumblr'
require_relative 'ids_please/parsers/vimeo'
require_relative 'ids_please/parsers/youtube'
require_relative 'ids_please/parsers/soundcloud'
require_relative 'ids_please/parsers/vkontakte'
require_relative 'ids_please/parsers/odnoklassniki'
require_relative 'ids_please/parsers/moikrug'

class IdsPlease

  attr_accessor :original, :unrecognized, :parsed

  PARSERS = [
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

  def initialize(*args)
    @original = args.dup
  end

  def recognize
    @recognized = {}
    @unrecognized = []
    original.each { |l| recognize_link(l) }
  end

  def recognized
    Hash[@recognized.map { |parser, links| [ parser.to_sym, links ] }]
  end

  def parse
    recognize
    @parsed = Hash.new { |hash, parser| hash[parser.to_sym] = [] }
    @recognized.each do |parser, links|
      @parsed[parser].concat parser.parse(links)
    end
  end

  private

  def recognize_link(link)
    link = "http://#{link}" unless link =~ /\Ahttps?:\/\//
    parsed_link = URI(URI.encode(link))
    PARSERS.each do |network|
      if parsed_link.host =~ network::MASK
        @recognized[network] ||= []
        @recognized[network] << parsed_link
        return
      end
    end
    unrecognized << link
  end

end
