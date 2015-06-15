require 'rspec'
require 'rack/test'
require './base_controller'

class TestController < BaseController
  get '/read', scope: [:read] do
    "#{current_user} can read"
  end

  get '/admin' do
    "#{current_user} is admin"
  end
end

describe BaseController do
  include Rack::Test::Methods

  subject(:app) { TestController.new }

  it 'works' do
    get '/read', name: 'Vasya'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('Vasya can read')

    get '/admin', name: 'Masha'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('Masha is admin')

    get '/admin', name: 'Vasya'
    expect(last_response.status).to eq(401)
    expect(last_response.body).to eq('Vasya is not an admin')
  end
end