require 'spec_helper'

describe IdsPlease do
  describe 'grab' do
    context 'from external', external: true do
      let!(:recognizer) do
        recognizer = IdsPlease.new(*recognazible_links)
        recognizer.grab
        recognizer
      end

      let(:recognazible_links) do
        %w(
          https://twitter.com/amplifr
          https://www.instagram.com/instagram/
          https://my.mail.ru/community/test-group-102/
          https://my.mail.ru/mail/gazay/
          https://plus.google.com/+VladimirBokov
          https://plus.google.com/communities/109254488709825102030
        )
      end

      describe 'vk grabber' do
        context 'vk public page' do
          let(:grabbed) do
            recognizer = IdsPlease.new('https://vk.com/amplifr')
            recognizer.grab[:vkontakte].first
          end

          it "does return correct data set for public" do
            expect(grabbed.errors).to be_empty
            expect(URI.parse(grabbed.avatar)).to be_truthy
            expect(grabbed.display_name).to be_truthy
            expect(grabbed.username).to be_truthy
            expect(grabbed.network_id).to be_truthy
            expect(grabbed.link).to be_truthy
            expect(grabbed.data).to be_truthy
          end
        end

        context 'vk user page' do
          let(:grabbed) do
            recognizer = IdsPlease.new('https://vk.com/id1')
            recognizer.grab[:vkontakte].first
          end
          it "does return correct data set for user page" do
            expect(grabbed.errors).to be_empty
            expect(URI.parse(grabbed.avatar)).to be_truthy
            expect(grabbed.display_name).to be_truthy
            expect(grabbed.username).to be_truthy
            expect(grabbed.link).to be_truthy
            expect(grabbed.data).to be_truthy
          end
        end
      end

      describe 'fb grabber' do
        context 'fb public page' do
          let(:grabbed) do
            recognizer = IdsPlease.new('https://www.facebook.com/amplifr/')
            recognizer.grab[:facebook].first
          end

          it "does return correct data set for public" do
            expect(grabbed.errors).to be_empty
            expect(URI.parse(grabbed.avatar)).to be_truthy
            expect(grabbed.display_name).to be_truthy
            expect(grabbed.username).to be_truthy
            expect(grabbed.network_id).to be_truthy
            expect(grabbed.link).to be_truthy
            expect(grabbed.data).to be_truthy
            expect(grabbed.data[:type]).to be_truthy
            expect(grabbed.data[:description]).to be_truthy
          end
        end

        context 'fb user page' do
          let(:grabbed) do
            recognizer = IdsPlease.new('https://www.facebook.com/zuck')
            recognizer.grab[:facebook].first
          end

          it "does return correct data set for user page" do
            expect(grabbed.errors).to be_empty
            expect(URI.parse(grabbed.avatar)).to be_truthy
            expect(grabbed.display_name).to be_truthy
            expect(grabbed.username).to be_truthy
            expect(grabbed.link).to be_truthy
            expect(grabbed.data[:type]).to be_truthy
            expect(grabbed.data[:description]).to be_truthy
          end
        end
      end

      it 'does return correct set of data for twitter' do
        recognizer.grabbed[:twitter].each do |g|
          expect(g.errors).to be_empty
          expect(URI.parse(g.avatar)).to be_truthy
          expect(g.display_name).to be_truthy
          expect(g.username).to be_truthy
          expect(g.link).to be_truthy
          expect(g.network_id).to be_truthy
          expect(g.data).to be_truthy
        end
      end

      it 'does return correct set of data for instagram' do
        recognizer.grabbed[:instagram].each do |g|
          expect(g.errors).to be_empty
          expect(URI.parse(g.avatar)).to be_truthy
          expect(g.display_name).to be_truthy
          expect(g.username).to be_truthy
          expect(g.link).to be_truthy
          expect(g.network_id).to be_truthy
          expect(g.data).to be_truthy
        end
      end

      it 'does return correct set of data for mail' do
        recognizer.grabbed[:mail].each do |g|
          expect(g.errors).to be_empty
          expect(URI.parse(g.avatar)).to be_truthy
          expect(g.display_name).to be_truthy
          expect(g.username).to be_truthy
          expect(g.link).to be_truthy
          expect(g.network_id).to be_truthy
          expect(g.data).to be_truthy
        end
      end

      it 'does return correct set of data for google' do
        recognizer.grabbed[:google].each do |g|
          expect(g.errors).to be_empty
          expect(URI.parse(g.avatar)).to be_truthy
          expect(g.display_name).to be_truthy
          expect(g.username).to be_truthy
          expect(g.link).to be_truthy
          expect(g.network_id).to be_truthy
          expect(g.data).to be_truthy
        end
      end
    end
  end
end