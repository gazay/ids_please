class IdsPlease::Tumblr < IdsPlease::BaseParser

  MASK = /tumblr/i

  def self.parse(links)
    links.map do |link|
      next if link.host.sub('.tumblr.com', '') == link.host
      parse_link(link)
    end.compact
  end

  def self.parse_link(link)
    link.host.sub('.tumblr.com', '')
  end

end
