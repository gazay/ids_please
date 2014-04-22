class IdsPlease::Tumblr < IdsPlease::BaseParser

  MASK = /tumblr/i

  def self.parse(links)
    links.map do |link|
      next if link.host.sub('.tumblr.com', '') == link.host
      parse_link(link)
    end.compact
  end

  def self.parse_link(link)
    if link.query.present?
      query = CGI.parse(link.query)
      query['id'].first if query.keys.include?('id')
    elsif link.path =~ /\/pages\//
      link.path.split('/').last
    else
      link.path.split('/')[1]
    end
  end

end
