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

get '/contacts/new' do
  erb :new
end


get '/contacts/:id' do
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

get '/contacts/search/' do
  #search all contacts for object by key value provided
  p params
  @temp_contacts = Contact.all
  @contacts = []
  @temp_contacts.each do |contact|
    if (contact.first_name == params[:first_name])||(contact.last_name == params[:last_name])
      @contacts << contact
    end
  end

  if @contacts.size == 1
    @contact = @contacts[0]
    erb :show_contact
  elsif @contacts.size > 1
    erb :contacts
  else
    raise Sinatra::NotFound
  end

  #if contacts.size > 1 render contacts.erb with list of found items
  #if contacts.size == 1 render show contact

end


put '/contacts/:id' do

  if Contact.exists?(:id => params[:id].to_i)
    @contact = Contact.find(params[:id].to_i)
  end

  if @contact
    @contact.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      note: params[:note]
    )
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end


delete '/contacts/:id' do

  if Contact.exists?(:id => params[:id].to_i)
    @contact = Contact.find(params[:id].to_i)
  end

  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
  # instructions for how to handle requests to this route will go here
  if Contact.exists?(:id => params[:id].to_i)
    @contact = Contact.find(params[:id].to_i)
  end

  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end


after do
  ActiveRecord::Base.connection.close
end
