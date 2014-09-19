get '/' do
  erb :homepage
end

post '/' do
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/signup' do
  @user = User.create(full_name: params[:full_name], password: params[:password], email: params[:email])
  session[:user_id] = @user.id
  @user.followees << @user
  redirect "/dashboard/#{@user.id}"
end

post '/login' do
  session[:error] = nil if !session[:error]
  @user = User.find_by(full_name: params[:full_name] )
  if @user == nil
    redirect '/'
  elsif @user.password != params[:password]
    redirect '/'
  else
    session[:user_id] = @user.id
    redirect "/dashboard/#{@user.id}"
  end
end


