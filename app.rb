require 'rubygems'
require 'bundler'
require 'bundler/setup'
require 'json'
require 'sinatra/json'
Bundler.require

require './config/environments'

require './model/joke'
require './serializers/joke_serializer'

register Sinatra::ActiveRecordExtension

before do
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = '*'
end

get '/jokes' do
  json Joke.all, root: false
end

post '/jokes' do
  @joke = Joke.new(params[:joke])

  if @joke.save
    status 201
  else
    status 422
  end
end

get '/jokes/:id' do
  begin
    @joke = Joke.find(params[:id])
  rescue Exception
    status 404
    return
  end

  json @joke, root: false
end

put '/jokes/:id' do
  begin
    @joke = Joke.find(params[:id])
  rescue Exception
    status 404
    return
  end

  if @joke.update(params[:joke])
    status 204
  else
    status 422
  end
end

delete '/jokes/:id' do
  begin
    @joke = Joke.find(params[:id])

    @joke.delete
  rescue Exception
  end

  status 204
end
