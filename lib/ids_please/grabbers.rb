require_relative 'grabbers/base'
require_relative 'grabbers/facebook'
require_relative 'grabbers/vkontakte'

class IdsPlease
  module Grabbers

    NETWORKS = [
      IdsPlease::Grabbers::Facebook
    ]

    def self.each
      NETWORKS.each { |n| yield n }
    end

  end
end
