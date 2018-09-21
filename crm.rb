require_relative 'contact'
require 'sinatra'

get '/' do
  erb :index
end



after do
  ActiveRecord::Base.connection.close
end
