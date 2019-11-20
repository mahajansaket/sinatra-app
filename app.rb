#!/usr/bin/ruby
require 'sinatra'
require 'sinatra/reloader' if development?
require './const'
require './students'
require './comments'
require 'dm-timestamps'

# ===== Database Config =====

configure :development do
  DataMapper.setup(
    :default,
    "sqlite3://#{Dir.pwd}/data.db"
  )
end

configure :production do
  DataMapper.setup(
    :default,
    ENV['DATABASE_URL']
  )
end

# if not db not exist, create it 
Student.auto_migrate! unless DataMapper.repository(:default).adapter.storage_exists?('students')
Comment.auto_migrate! unless DataMapper.repository(:default).adapter.storage_exists?('comments')


# ===== Username / Password =====

configure do
  enable :sessions
  set :user, "user"
  set :pass, "pass"
end

# ===== Routes =====

get ['/', '/home'] do
  @title = "Home"
  erb :home
end

get '/about' do
  #@name = :view
  @title = "About"
  erb :about
end

get '/comments' do
  @title = "Comments"
  if logged == false
    erb :login
  else
    erb :comments
  end
end

get '/video' do
  @title = "Video"
  erb :video
end

post '/login' do
  if params[:username] == settings.user && params[:password] == settings.pass
    session[:logged] = true
    redirect to "/#{params[:title].downcase}"
  else
    erb :denied
  end
end

get '/logout' do
  session[:logged] = false
  redirect to '/'
end

not_found do
  erb :notfound, :layout=>false
end