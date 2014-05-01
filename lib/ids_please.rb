require 'uri'
require 'cgi'
require_relative 'ids_please/base_parser'
require_relative 'ids_please/facebook'
require_relative 'ids_please/google_plus'
require_relative 'ids_please/instagram'
require_relative 'ids_please/blogger'
require_relative 'ids_please/ameba'
require_relative 'ids_please/livejournal'
require_relative 'ids_please/linkedin'
require_relative 'ids_please/pinterest'
require_relative 'ids_please/reddit'
require_relative 'ids_please/twitter'
require_relative 'ids_please/tumblr'
require_relative 'ids_please/vimeo'
require_relative 'ids_please/youtube'
require_relative 'ids_please/soundcloud'
require_relative 'ids_please/vkontakte'
require_relative 'ids_please/odnoklassniki'
require_relative 'ids_please/moikrug'

class IdsPlease

  VERSION = '1.0.6'

  attr_accessor :original, :unrecognized, :parsed

  SOCIAL_NETWORKS = [
    IdsPlease::GooglePlus,
    IdsPlease::Vkontakte,
    IdsPlease::Twitter,
    IdsPlease::Facebook,
    IdsPlease::Instagram,
    IdsPlease::Blogger,
    IdsPlease::Ameba,
    IdsPlease::Linkedin,
    IdsPlease::Livejournal,
    IdsPlease::Reddit,
    IdsPlease::Pinterest,
    IdsPlease::Soundcloud,
    IdsPlease::Vimeo,
    IdsPlease::Youtube,
    IdsPlease::Odnoklassniki,
    IdsPlease::Tumblr,
    IdsPlease::Moikrug
  ]

  def initialize(*args)
    duped_args = args.dup
    @original = duped_args
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
    SOCIAL_NETWORKS.each do |network|
      if parsed_link.host =~ network::MASK
        @recognized[network] ||= []
        @recognized[network] << parsed_link
        return
      end
    end
    unrecognized << link
  end

end
