require_relative 'grabbers/base'
require_relative 'grabbers/facebook'
require_relative 'grabbers/vkontakte'
require_relative 'grabbers/instagram'
require_relative 'grabbers/twitter'

class IdsPlease
  module Grabbers

    NETWORKS = [
      IdsPlease::Grabbers::Facebook,
      IdsPlease::Grabbers::Vkontakte,
      IdsPlease::Grabbers::Twitter,
      IdsPlease::Grabbers::Instagram
    ]

    def self.each
      NETWORKS.each { |n| yield n }
    end

    def self.by_symbol(sym)
      Kernel.const_get("IdsPlease::Grabbers::#{sym.to_s.capitalize}")
    end

  end
end
