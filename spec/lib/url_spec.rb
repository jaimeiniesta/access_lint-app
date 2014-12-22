require 'rails_helper'

describe URL do
  describe '#valid?' do
    it 'returns false if the url is not a valid url string' do
      expect(URL.new('').valid?).to be_falsey
      expect(URL.new('google').valid?).to be_falsey
    end

    it 'returns true if the url is a valid url string' do
      expect(URL.new('google.com').valid?).to be_truthy
      expect(URL.new('http://google.com').valid?).to be_truthy
    end
  end

  describe '#error' do
    it 'returns an appropriate error when the url is invalid' do
      empty_url_message = 'URL cannot be blank'
      invalid_url_message = 'This URL is invalid'

      expect(URL.new('').error).to eq empty_url_message
      expect(URL.new('google').error).to eq invalid_url_message
    end
  end

  describe '#to_s' do
    it 'returns a full url' do
      expect(URL.new('google.com').to_s).to eq 'http://google.com'
      expect(URL.new('google.com/results').to_s).to eq 'http://google.com/results'
    end
  end
end
