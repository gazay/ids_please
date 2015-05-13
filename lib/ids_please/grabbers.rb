require_relative 'grabbers/base'
require_relative 'grabbers/facebook'
require_relative 'grabbers/vkontakte'
require_relative 'grabbers/instagram'

class IdsPlease
  module Grabbers

    NETWORKS = [
      IdsPlease::Grabbers::Facebook,
      IdsPlease::Grabbers::Vkontakte,
      IdsPlease::Grabbers::Instagram
    ]

    def self.each
      NETWORKS.each { |n| yield n }
    end

    def self.by_symbol(sym)
      klass_name = "#{sym.to_s[0].upcase}#{sym.to_s[1..-1]}"
      self.const_get(klass_name)
    end

  end
end
