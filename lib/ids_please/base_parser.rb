class IdsPlease::BaseParser

  def self.network_name
    self.name.split('::').last
  end

  def self.parse(links)
    links.map { |l| parse_link(l) }.compact
  end

  def self.parse_link(link)
    link.path.split('/')[1]
  end

end
