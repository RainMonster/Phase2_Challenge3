enable :sessions


get '/' do
  @messages = session[:messages]
  session[:messages] = []
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  if User.authenticate(params[:email], params[:password])
    session[:user] = User.authenticate(params[:email], params[:password])
    redirect '/'
  else
    session[:messages] << "Invalid login"
    redirect '/'
  end
end

delete '/sessions/:id' do
  session[:user] = nil
  session[:messages] << "You have signed out"
  redirect '/'
end

#----------- USERS -----------

get '/users/new' do
  erb :sign_up
end

post '/users/:name/:email/:password' do
  @new_user = User.create(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
  if User.last == @new_user
    session[:user] = User.last
    redirect '/'
  else 
    session[:messages] << "Sorry, sign up failed. Please use a different email."
    redirect '/'
  end 
end

  ## sending the password over params seems unsafe, is that typical practice?
