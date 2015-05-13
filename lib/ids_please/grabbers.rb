require_relative 'grabbers/base'
require_relative 'grabbers/facebook'

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
