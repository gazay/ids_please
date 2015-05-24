class IdsPlease::Grabbers::Twitter < IdsPlease::Grabbers::Base
  
  def grab_link
    @page_source ||= open(link).read
    @network_id  = @page_source.scan(/data-user-id="(\d+)"/).flatten.first
    @avatar = @page_source.scan(/ProfileAvatar-image " src="([^"]+)"/).flatten.first
    @display_name = @page_source.scan(/ProfileHeaderCard-nameLink[^>]+>([^<]+)</).flatten.first
    @username = @page_source.scan(/<title>[^\(]+\(@([^\)]+)\)/).flatten.first
    @data = {}
    {
      description: @page_source.scan(/ProfileHeaderCard-bio[^>]+>([^<]+)</).flatten.first.encode('utf-8'),
      location: @page_source.scan(/ProfileHeaderCard-locationText[^>]+>([^<]+)</).flatten.first.encode('utf-8'),
      join_date: @page_source.scan(/ProfileHeaderCard-joinDateText[^>]+>([^<]+)</).flatten.first.encode('utf-8'),
    }.each do |k, v|
      next if v.nil? || v == ''
      @data[k] = CGI.unescapeHTML(v)
    end
    self
  rescue => e
    p e
    return self
  end
end
