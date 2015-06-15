require 'sinatra'
require './scoping'

class BaseController < Sinatra::Base
  register Extensions::Scoping

  configure do
    set :raise_errors, true
  end  
end