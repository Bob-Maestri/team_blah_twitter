get '/profile/:user_id' do
  @all_users = User.all
  @user = User.find(params[:user_id])
  erb :profile
end