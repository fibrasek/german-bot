require 'sinatra'
require 'json'
require 'nokogiri'
require 'open-uri'

#return if params[:token] != ENV['SLACK_TOKEN']

get '/word' do
  @doc = Nokogiri::XML(open("http://feeds.feedblitz.com/german-word-of-the-day"))

  @content = Nokogiri::HTML(@doc.xpath('//content:encoded')[0].content)

  title = @doc.xpath("//title")[0].text
  word = @doc.xpath("//title")[1].text

  word_type = @content.css('td')[0].text
  german_sentence = @content.css('td')[1].text
  english_sentence = @content.css('td')[2].text

  msg = "#{title}\nWord: #{word}\nWord type: #{word_type}\nGerman Sentence: #{german_sentence}\nEnglish Sentence: #{english_sentence}"

  respond_message msg
end

def respond_message message
  content_type :json

  resp = { text: message}

  resp.to_json
end
