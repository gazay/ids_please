require 'spec_helper'

describe 'facebook grabber', external: true do
  context 'facebook public page' do
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
      expect(grabbed.link).to eq URI.parse('https://www.facebook.com/amplifr/')
      expect(grabbed.data).to be_truthy
    end
  end

  context 'facebook user page' do
    let(:grabbed) do
      recognizer = IdsPlease.new('https://www.facebook.com/zuck')
      recognizer.grab[:facebook].first
    end

    it "does return correct data set for user page" do
      expect(grabbed.errors).to be_empty
      expect(URI.parse(grabbed.avatar)).to be_truthy
      expect(grabbed.display_name).to be_truthy
      expect(grabbed.username).to be_truthy
      expect(grabbed.link).to eq URI.parse('https://www.facebook.com/zuck')
      expect(grabbed.data[:type]).to be_truthy
      expect(grabbed.data[:description]).to be_truthy
    end
  end
end
