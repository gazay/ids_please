require 'uri'
require 'cgi'
require_relative 'ids_please/parsers'
require_relative 'ids_please/grabbers'

class IdsPlease

  def self.parsers
    IdsPlease::Parsers
  end

  def self.grabbers
    IdsPlease::Grabbers
  end

  attr_accessor :original, :unrecognized, :parsed, :grabbed

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
    interact(:parsers)
  end

  def grab
    interact(:grabbers)
  end

  private

  def interact(interactors = :parsers)
    recognize
    interacted = Hash.new { |hash, network| hash[network] = [] }
    @recognized.each do |network, links|
      interactor = IdsPlease.send(interactors).by_symbol(network)
      interacted[network].concat interactor.parse(links)
    end
    self.instance_variable_set(interacted_var(interactors), interacted)

    interacted
  end

  def interacted_var(interactors)
    if interactors == :parsers
      :@parsed
    elsif interactors == :grabbers
      :@grabbed
    else
      throw 'Wrong interactors type'
    end
  end

  def recognize_link(link)
    link = "http://#{link}" unless link =~ /\Ahttps?:\/\//
    parsed_link = URI(URI.encode(link))
    IdsPlease::Parsers.each do |network|
      if parsed_link.host =~ network::MASK
        @recognized[network.to_sym] ||= []
        @recognized[network.to_sym] << parsed_link
        return
      end
    end
    unrecognized << link
  end

end
