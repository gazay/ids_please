require 'spec_helper'

describe IdsPlease do

  recognazible_links = %w(
      https://www.facebook.com/fb_acc
      https://www.facebook.com/fb_acc2<U+200>
      http://instagram.com/inst_acc
      http://hi5.com/hi5_acc
      http://www.hi5.com/profile.html?uid=12341234
      http://pinterest.com/pinterest_acc
      http://blogger-acc.blogspot.com
      http://livejournal-acc.livejournal.com
      http://livejournal-acc2.livejournal.ru
      https://www.blogger.com/blogger.g?blogID=12341234#overview/src=dashboard
      http://vk.com/vk_acc
      http://linkedin.com/in/xnutsive
      http://www.linkedin.com/company/evil-martians
      http://www.linkedin.com/profile/view?id=12341234&trk=nav_responsive_tab_profile
      http://Ameblo.jp/ameba_acc
      http://reddit.com/user/reddit_acc
      https://twitter.com/twi_acc
      https://vimeo.com/vimeo_acc
      https://plus.google.com/12341234
      https://plus.google.com/+VladimirBokov
      https://soundcloud.com/sc_acc
      https://youtube.com/channels/yb_acc
      http://tumblr-acc.tumblr.com
      http://odnoklassniki.com/profile/12341234/about
      http://ok.ru/profile/12341234/about
      http://odnoklassniki.com/group/43214321/about?some=123
      http://moikrug-acc.moikrug.ru
    )

  not_recognazible_links = %w(
      http://fucebook.com/not_recognized
      http://vka.com/not_recognized
    )

  not_parseble_links = %w(
      http://vk.com
      http://soundcloud.com
    )

  describe 'recognize' do

    it 'not recognizes wrong links' do
      recognizer = IdsPlease.new(*not_recognazible_links)
      recognizer.recognize
      expect(recognizer.recognized.values.flatten.count).to eq(0)
      expect(recognizer.unrecognized).to eq(not_recognazible_links)
    end

    context 'recognize social networks properly' do
      before :each do
        @recognizer = IdsPlease.new(*recognazible_links)
        @recognizer.parse
      end

      it 'recognizes social links' do
        expect(@recognizer.recognized.values.flatten.count).to eq(recognazible_links.count)
      end

      it 'recognizes facebook link' do
        expect(@recognizer.recognized[:facebook].count).to eq(2)
      end

      it 'recognizes hi5 link' do
        expect(@recognizer.recognized[:hi5].count).to eq(2)
      end

      it 'recognizes linkedin link' do
        expect(@recognizer.recognized[:linkedin].count).to eq(3)
      end

      it 'recognizes livejournal link' do
        expect(@recognizer.recognized[:livejournal].count).to eq(2)
      end

      it 'recognizes instagram link' do
        expect(@recognizer.recognized[:instagram].count).to eq(1)
      end

      it 'recognizes reddit link' do
        expect(@recognizer.recognized[:reddit].count).to eq(1)
      end

      it 'recognizes blogger link' do
        expect(@recognizer.recognized[:blogger].count).to eq(2)
      end

      it 'recognizes pinterest link' do
        expect(@recognizer.recognized[:pinterest].count).to eq(1)
      end

      it 'recognizes vk link' do
        expect(@recognizer.recognized[:vkontakte].count).to eq(1)
      end

      it 'recognizes twitter link' do
        expect(@recognizer.recognized[:twitter].count).to eq(1)
      end

      it 'recognizes vimeo link' do
        expect(@recognizer.recognized[:vimeo].count).to eq(1)
      end

      it 'recognizes google+ link' do
        expect(@recognizer.recognized[:google_plus].count).to eq(2)
      end

      it 'recognizes soundcloud link' do
        expect(@recognizer.recognized[:soundcloud].count).to eq(1)
      end

      it 'recognizes youtube link' do
        expect(@recognizer.recognized[:youtube].count).to eq(1)
      end

      it 'recognizes ameba link' do
        expect(@recognizer.recognized[:ameba].count).to eq(1)
      end

      it 'recognizes tumblr link' do
        expect(@recognizer.recognized[:tumblr].count).to eq(1)
      end

      it 'recognizes odnoklassniki link' do
        expect(@recognizer.recognized[:odnoklassniki].count).to eq(3)
      end

      it 'recognizes moikrug link' do
        expect(@recognizer.recognized[:moikrug].count).to eq(1)
      end

    end

  end

  describe 'parse' do

    it 'not parse wrong links' do
      @recognizer = IdsPlease.new(*not_parseble_links)
      @recognizer.parse
      expect(@recognizer.parsed[:vkontakte]).to eq([])
      expect(@recognizer.parsed[:soundcloud]).to eq([])
      expect(@recognizer.unrecognized).to eq([])
    end

    it 'contains the original passed args' do
      @recognizer = IdsPlease.new(*not_parseble_links)
      @recognizer.parse
      expect(@recognizer.original).to eq(not_parseble_links)
    end

    context 'parse social networks properly' do
      before :each do
        @recognizer = IdsPlease.new(*recognazible_links)
        @recognizer.parse
      end

      it 'parses social links' do
        expect(@recognizer.parsed.values.flatten.count).to eq(recognazible_links.count)
      end

      it 'get right id from facebook link' do
        expect(@recognizer.parsed[:facebook]).to eq(['fb_acc', 'fb_acc2'])
      end

      it 'get right id from linkedin link' do
        expect(@recognizer.parsed[:linkedin]).to eq(['xnutsive', 'evil-martians', '12341234'])
      end

      it 'get right id from instagram link' do
        expect(@recognizer.parsed[:instagram].first).to eq('inst_acc')
      end

      it 'get right id from pinterest link' do
        expect(@recognizer.parsed[:pinterest].first).to eq('pinterest_acc')
      end

      it 'get right id from blogger link' do
        expect(@recognizer.parsed[:blogger]).to eq(['blogger-acc', '12341234'])
      end

      it 'get right id from vk link' do
        expect(@recognizer.parsed[:vkontakte].first).to eq('vk_acc')
      end

      it 'get right id from twitter link' do
        expect(@recognizer.parsed[:twitter].first).to eq('twi_acc')
      end

      it 'get right id from reddit link' do
        expect(@recognizer.parsed[:reddit].first).to eq('reddit_acc')
      end

      it 'get right id from vimeo link' do
        expect(@recognizer.parsed[:vimeo].first).to eq('vimeo_acc')
      end

      it 'get right id from google+ link' do
        expect(@recognizer.parsed[:google_plus]).to eq(['12341234', '+VladimirBokov'])
      end

      it 'get right id from hi5 link' do
        expect(@recognizer.parsed[:hi5]).to eq(['hi5_acc', '12341234'])
      end

      it 'get right id from soundcloud link' do
        expect(@recognizer.parsed[:soundcloud].first).to eq('sc_acc')
      end

      it 'get right id from youtube link' do
        expect(@recognizer.parsed[:youtube].first).to eq('yb_acc')
      end

      it 'get right id from ameba link' do
        expect(@recognizer.parsed[:ameba].first).to eq('ameba_acc')
      end

      it 'get right id from tumblr link' do
        expect(@recognizer.parsed[:tumblr].first).to eq('tumblr-acc')
      end

      it 'get right id from livejournal link' do
        expect(@recognizer.parsed[:livejournal]).to eq(['livejournal-acc', 'livejournal-acc2'])
      end

      it 'get right id from odnoklassniki link' do
        expect(@recognizer.parsed[:odnoklassniki].sort).to eq(['12341234', '43214321', '12341234'].sort)
      end

      it 'get right id from moikrug link' do
        expect(@recognizer.parsed[:moikrug].first).to eq('moikrug-acc')
      end

    end
  end

end
