require 'spec_helper'

describe IdsPlease do

  describe 'recognize' do
    recognazible_links = %w(
        https://www.facebook.com/fb_acc
        http://instagram.com/inst_acc
        http://vk.com/vk_acc
        https://twitter.com/twi_acc
        https://vimeo.com/vimeo_acc
        https://plus.google.com/2/u/b/12341234/1234/asdfasd
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
        expect(@recognizer.parsed['Facebook'].first).to eq('fb_acc')
      end

      it 'get right id from instagram link' do
        expect(@recognizer.parsed['Instagram'].first).to eq('inst_acc')
      end

      it 'get right id from vk link' do
        expect(@recognizer.parsed['Vkontakte'].first).to eq('vk_acc')
      end

      it 'get right id from twitter link' do
        expect(@recognizer.parsed['Twitter'].first).to eq('twi_acc')
      end

      it 'get right id from vimeo link' do
        expect(@recognizer.parsed['Vimeo'].first).to eq('vimeo_acc')
      end

      it 'get right id from google+ link' do
        expect(@recognizer.parsed['GooglePlus'].first).to eq('12341234')
      end

      it 'get right id from soundcloud link' do
        expect(@recognizer.parsed['Soundcloud'].first).to eq('sc_acc')
      end

      it 'get right id from youtube link' do
        expect(@recognizer.parsed['Youtube'].first).to eq('yb_acc')
      end

      it 'get right id from tumblr link' do
        expect(@recognizer.parsed['Tumblr'].first).to eq('tumblr-acc')
      end

    end

  end

end
