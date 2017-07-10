require 'spec_helper'

describe 'mail grabber', external: true do
  context 'public profile' do
    let(:grabbed) do
      recognizer = IdsPlease.new('https://my.mail.ru/community/test-group-102/')
      recognizer.grab[:mailru].first
    end

    it "does return correct data for public" do
      expect(grabbed.errors).to be_empty
      expect(URI.parse(grabbed.avatar)).to be_truthy
      expect(grabbed.display_name).to be_truthy
      expect(grabbed.username).to be_truthy
      expect(grabbed.network_id).to be_truthy
      expect(grabbed.link).to be_truthy
      expect(grabbed.data).to be_truthy
    end
  end

  context 'user profile' do
    let(:grabbed) do
      recognizer = IdsPlease.new('https://my.mail.ru/mail/wild_dima/')
      recognizer.grab[:mailru].first
    end

    it "does return correct data for user" do
      expect(grabbed.errors).to be_empty
      expect(URI.parse(grabbed.avatar)).to be_truthy
      expect(grabbed.display_name).to be_truthy
      expect(grabbed.username).to be_truthy
      expect(grabbed.network_id).to be_truthy
      expect(grabbed.link).to be_truthy
      expect(grabbed.data).to be_truthy
    end
  end
end
