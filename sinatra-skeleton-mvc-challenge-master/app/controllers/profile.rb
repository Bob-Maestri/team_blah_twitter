get '/profile/:user_id' do
  @all_users = User.all
  @user = User.find(params[:user_id])
  @other_users = @all_users - @user.followees
  erb :profile
end

post '/profile/:user_id/unfollow/:other_id' do
  @user = User.find(params[:user_id])
  @user.followees.delete(User.find(params[:other_id]))
  redirect "/profile/#{@user.id}"
end

post '/profile/new_blah/:user_id' do
  @user = User.find(params[:user_id])
  @user.blahs.create(content: params[:content])
  redirect "/profile/#{@user.id}"
end