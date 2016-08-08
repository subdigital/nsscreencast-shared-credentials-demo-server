require 'sinatra'
require './user'
require 'json'

enable :sessions

set :session_secret, ENV['SESSION_SECRET'] || 'testsecretfordevelopment'

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/logout' do
  session[:user] = nil
  redirect '/'
end

post '/login' do
  if user = User.authenticate(params[:email], params[:password])
    session[:user] = user
    redirect '/private'
  else
    @email = params[:email]
    @error = "Invalid login"
    erb :login
  end
end

get '/private' do
  puts "Session: #{session[:user].inspect}"
  unless session[:user]
    redirect '/login'
    return
  end

  erb :private
end
