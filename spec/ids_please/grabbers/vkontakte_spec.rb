require 'spec_helper'

describe 'vk grabber', external: true do
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
      expect(grabbed.link).to eq URI.parse('https://vk.com/amplifr')
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
      expect(grabbed.link).to eq URI.parse('https://vk.com/id1')
      expect(grabbed.data).to be_truthy
    end
  end
end
