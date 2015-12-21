require 'sinatra'
require 'json'
require 'nokogiri'
require 'open-uri'

#return if params[:token] != ENV['SLACK_TOKEN']

get '/' do
  @doc = Nokogiri::HTML(open("http://feeds.feedblitz.com/german-word-of-the-day"))

  title = @doc.css('title').text
  word = @doc.xpath("//title")[1].text
  word_type = @doc.css('td')[0].text
  german_sentence = @doc.css('td')[1].text
  english_sentence = @doc.css('td')[2].text

  msg = [
    "#{title}",
    "Word: #{word}",
    "Word type: #{word_type}",
    "German Sentence: #{german_sentence}",
    "English Sentence: #{english_sentence}"
  ]

  respond_message msg
end

def respond_message message
  content_type :json

  resp = { text: []}

  message.each do | msg |
    resp[:text] << msg
  end

  resp.to_json
end
