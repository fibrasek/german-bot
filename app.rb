require 'sinatra'
require 'nokogiri'
require 'open-uri'

FEED_URL = "http://feeds.feedblitz.com/german-word-of-the-day"

get 'gwotd' do
  get_document


end

def get_document_and_parse
  @doc = Nokogiri::HTML(open(FEED_URL))

  title = @doc.css('title').text
  word_type = @doc.css('td')[0].text
  german_sentence = @doc.css('td')[1].text
  english_sentenct = @doc.css('td')[2].text

  "#{title} -> #{word_type}, "
end

def respond_message msg
  content_type :json

  {:text => message}.to_json
end
