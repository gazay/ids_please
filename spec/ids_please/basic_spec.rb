require 'spec_helper'

describe IdsPlease do

  describe 'recognize' do
    recognazible_links = %w(
        https://www.facebook.com/fb_acc
        http://instagram.com/inst_acc
        http://vk.com/vk_acc
        https://twitter.com/twi_acc
        https://vimeo.com/vimeo_acc
        https://plus.google.com/12341234
        https://plus.google.com/+VladimirBokov
        https://soundcloud.com/sc_acc
        https://youtube.com/channels/yb_acc
        http://tumblr-acc.tumblr.com
      )

    not_recognazible_links = %w(
        http://fucebook.com/not_recognized
        http://vka.com/not_recognized
      )

    it 'not recognizes wrong links' do
      recognizer = IdsPlease.new(*not_recognazible_links)
      recognizer.recognize
      expect(recognizer.recognized.values.flatten.count).to eq(0)
    end

    context 'recognize social networks properly' do
      before :each do
        @recognizer = IdsPlease.new(*recognazible_links)
        @recognizer.parse
      end

      it 'recognizes social links' do
        expect(@recognizer.recognized.values.flatten.count).to eq(recognazible_links.count)
      end

      it 'get right id from facebook link' do
        expect(@recognizer.parsed[:facebook].first).to eq('fb_acc')
      end

      it 'get right id from instagram link' do
        expect(@recognizer.parsed[:instagram].first).to eq('inst_acc')
      end

      it 'get right id from vk link' do
        expect(@recognizer.parsed[:vkontakte].first).to eq('vk_acc')
      end

      it 'get right id from twitter link' do
        expect(@recognizer.parsed[:twitter].first).to eq('twi_acc')
      end

      it 'get right id from vimeo link' do
        expect(@recognizer.parsed[:vimeo].first).to eq('vimeo_acc')
      end

      it 'get right id from google+ link' do
        expect(@recognizer.parsed[:google_plus]).to eq(['12341234', 'VladimirBokov'])
      end

      it 'get right id from soundcloud link' do
        expect(@recognizer.parsed[:soundcloud].first).to eq('sc_acc')
      end

      it 'get right id from youtube link' do
        expect(@recognizer.parsed[:youtube].first).to eq('yb_acc')
      end

      it 'get right id from tumblr link' do
        expect(@recognizer.parsed[:tumblr].first).to eq('tumblr-acc')
      end

    end

  end

end
