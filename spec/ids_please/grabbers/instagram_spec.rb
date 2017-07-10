require 'spec_helper'

describe 'instagram grabber', external: true do
  let(:grabbed) do
    recognizer = IdsPlease.new('https://www.instagram.com/instagram')
    recognizer.grab[:instagram].first
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
