require 'rubygems'
require 'bundler'
require 'bundler/setup'
Bundler.require

require './config/environments'

require './model/joke'

class Jokes < Grape::API
  format :json

  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response('{ "status": 404, "message": "Not Found." }', 404)
  end

  resource :jokes do
    desc 'Return all jokes'
    get do
      Joke.all
    end

    desc 'Create new joke'
    params do
      requires :joke, type: String, desc: 'Joke'
      requires :punchline, type: String, desc: 'Punchline'
    end
    post do
      Joke.create!(
        joke: params[:joke],
        punchline: params[:punchline]
      )
    end

    route_param :id do
      desc 'View a single joke'
      get do
        Joke.find(params[:id])
      end

      desc 'Update a joke'
      params do
        requires :joke, type: String, desc: 'Joke'
        requires :punchline, type: String, desc: 'Punchline'
      end
      put do
        Joke.find(params[:id]).update({
          joke: params[:joke],
          punchline: params[:punchline]
        })
      end

      desc 'Delete a joke'
      delete do
        Joke.find(params[:id]).delete
      end
    end
  end
end
