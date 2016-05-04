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
    @original = args.flatten.dup
  end

  def recognize
    @recognized = {}
    @unrecognized = []
    original.each { |l| recognize_link(l) }
  end

  def recognized
    Hash[@recognized.map { |parser, links| [parser.to_sym, links] }]
  end

  def parse
    interact(:parsers)
  end

  def grab
    interact(:grabbers)
  end

  private

  def interact(interactors_group = :parsers)
    recognize
    interacted = Hash.new { |hash, network| hash[network] = [] }
    @recognized.each do |network, links|
      interactor = IdsPlease.send(interactors_group).by_symbol(network)
      interacted[network].concat interactor.interact(links)
    end
    instance_variable_set(interacted_var(interactors_group), interacted)

    interacted
  end

  def interacted_var(interactors_group)
    if interactors_group == :parsers
      :@parsed
    elsif interactors_group == :grabbers
      :@grabbed
    else
      throw 'Wrong interactors type'
    end
  end

  def recognize_link(link)
    link = "http://#{link}" unless link =~ /\Ahttps?:\/\//
    parsed_link = URI(URI.encode(link))

    network = IdsPlease::Parsers.to_a.find { |n| parsed_link.host =~ n::MASK }

    if network
      @recognized[network.to_sym] ||= []
      @recognized[network.to_sym] << parsed_link
    else
      @unrecognized << link
    end
  end
end
