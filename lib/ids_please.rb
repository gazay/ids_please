require 'uri'
require 'cgi'
require_relative 'ids_please/parsers'
require_relative 'ids_please/grabbers'

class IdsPlease

  attr_accessor :original, :unrecognized, :parsed

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
    IdsPlease::Parsers.each do |network|
      if parsed_link.host =~ network::MASK
        @recognized[network] ||= []
        @recognized[network] << parsed_link
        return
      end
    end
    unrecognized << link
  end

end
