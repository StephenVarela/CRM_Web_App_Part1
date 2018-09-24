require_relative 'contact'
require 'sinatra'

get '/' do
  erb :index
end

get '/contacts' do
  @contacts = Contact.all
  erb :contacts
end


post '/contacts' do
  my_contact = Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    note: params[:note]
  )

  redirect to('/contacts')
end

get '/about' do
  erb :about
end



get '/contact/:id' do
  # instructions for how to handle requests to this route will go here

  if Contact.exists?(:id => params[:id].to_i)
    @contact = Contact.find(params[:id].to_i)
  end

  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end

end

get '/contacts/new' do
  erb :new
end


after do
  ActiveRecord::Base.connection.close
end
