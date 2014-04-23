require 'uri'
require 'cgi'
require_relative 'ids_please/base_parser'
require_relative 'ids_please/facebook'
require_relative 'ids_please/google_plus'
require_relative 'ids_please/instagram'
require_relative 'ids_please/twitter'
require_relative 'ids_please/tumblr'
require_relative 'ids_please/vimeo'
require_relative 'ids_please/youtube'
require_relative 'ids_please/soundcloud'
require_relative 'ids_please/vkontakte'
require_relative 'ids_please/odnoklassniki'

class IdsPlease

  VERSION = '1.0.3'

  attr_accessor :original, :recognized, :unrecognized, :parsed

  SOCIAL_NETWORKS = [
    IdsPlease::GooglePlus,
    IdsPlease::Vkontakte,
    IdsPlease::Twitter,
    IdsPlease::Facebook,
    IdsPlease::Instagram,
    IdsPlease::Soundcloud,
    IdsPlease::Vimeo,
    IdsPlease::Youtube,
    IdsPlease::Odnoklassniki,
    IdsPlease::Tumblr
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

  def parse
    recognize
    @parsed = {}
    recognized.each do |network_sym, links|
      parser = SOCIAL_NETWORKS.find { |sn| sn.to_sym == network_sym }

      @parsed[network_sym] ||= []
      @parsed[network_sym] += parser.parse(links)
    end
  end

  private

  def recognize_link(link)
    link = "http://#{link}" unless link =~ /\Ahttps?:\/\//
    parsed_link = URI(URI.encode(link))
    SOCIAL_NETWORKS.each do |network|
      if parsed_link.host =~ network::MASK
        recognized[network.to_sym] ||= []
        recognized[network.to_sym] << parsed_link
        return
      end
    end
    unrecognized << link
  end

end
