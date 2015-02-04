require 'sinatra'
require "sinatra/json"
require 'json'
require 'haml'
require 'spinel'

get '/' do
  haml :index
end

get '/search' do
  spinel = Spinel.new
  json spinel.search(params[:term].to_s, {limit: 20}).map{|data| {value: data["body"], label: data["body"]}}
end
