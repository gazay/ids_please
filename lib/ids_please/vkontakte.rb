class IdsPlease::Vkontakte < IdsPlease::BaseNetwork

  MASK = /vk\.com|vkontakte/i

  def self.parse(links)
    links.map { |l| parse_link(l) }.compact
  end

  def self.parse_link(link)
    if link.path =~ /id|club/
      id = link.path.sub(/\A\/id|\A\/club/, '')
      id.split(/[\/\?#]/).first
    elsif
      link.path.split('/')[1]
    end
  end

end
