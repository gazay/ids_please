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

  end
end
