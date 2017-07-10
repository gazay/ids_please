require 'spec_helper'

describe 'google grabber', external: true do
  context 'public profile' do
    let(:grabbed) do
      recognizer = IdsPlease.new('https://plus.google.com/communities/109254488709825102030')
      recognizer.grab[:google_plus].first
    end

    it "does return correct data" do
      expect(grabbed.errors).to be_empty
      expect(URI.parse(grabbed.avatar)).to be_truthy
      expect(grabbed.display_name).to be_truthy
      expect(grabbed.username).to be_truthy
      expect(grabbed.network_id).to be_truthy
      expect(grabbed.link).to be_truthy
      expect(grabbed.data).to be_truthy
      expect(grabbed.data[:description]).to be_truthy
    end
  end

  context 'user profile' do
    let(:grabbed) do
      recognizer = IdsPlease.new('https://plus.google.com/+VladimirBokov')
      recognizer.grab[:google_plus].first
    end

    it "does return correct data" do
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