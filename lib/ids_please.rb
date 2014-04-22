require 'uri'
require 'cgi'

class IdsPlease

  VERSION = '0.0.2'

  attr_accessor :original, :recognized, :unrecognized, :options, :parsed

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
    @options = duped_args.pop if duped_args.last.is_a?(Hash)
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

require_relative 'ids_please/base_parser'
Dir[File.dirname(__FILE__) + '/ids_please/*.rb'].each do |file|
  next if file =~ /base_parser/
  require file
end
