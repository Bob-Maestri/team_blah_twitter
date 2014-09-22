get '/' do
  erb :homepage, layout: false
end

# empty?
post '/' do
end

get '/logout' do
  # nice!
  session.clear
  redirect '/'
end

post '/signup' do
  @all_users = User.all
    # nice quick validation step!
    @new_user = @all_users.find_by(full_name: params[:full_name] )
    if @new_user != nil
      redirect '/'
    else
      @user = User.create(full_name: params[:full_name], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      @user.followees << @user
      redirect "/dashboard/#{@user.id}"
    end
end

get '/dashboard/' do
  redirect '/'
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


