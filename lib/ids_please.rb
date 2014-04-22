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

  VERSION = '0.0.3'

  attr_accessor :original, :recognized, :unrecognized, :parsed

  SOCIAL_NETWORKS = %w(
    GooglePlus
    Vkontakte
    Twitter
    Facebook
    Instagram
    Soundcloud
    Vimeo
    Youtube
    Odnoklassniki
    Tumblr
  )

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
    recognized.each do |klass_name, links|
      @parsed[klass_name] ||= []
      @parsed[klass_name] += parser(klass_name).parse(links)
    end
  end

  private

  def recognize_link(link)
    network, handle = nil
    link = "http://#{link}" unless link =~ /\Ahttps?:\/\//
    parsed_link = URI(URI.encode(link))
    SOCIAL_NETWORKS.each do |network|
      if parsed_link.host =~ parser(network)::MASK
        recognized[network] ||= []
        recognized[network] << parsed_link
        return
      end
    end
    unrecognized << link
  end

  def parser(name)
    "IdsPlease::#{name}".split('::').inject(Module) do |acc, val|
      acc.const_get(val)
    end
  end

end
