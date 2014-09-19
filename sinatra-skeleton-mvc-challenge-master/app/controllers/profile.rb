get '/profile/:user_id' do
  @all_users = User.all
  @user = User.find(params[:user_id])
  @other_users = @all_users - @user.followees
  erb :profile
end

post '/profile/:user_id/follow/:other_id' do
  @user1 = User.find(params[:user_id])
  @user2 = User.find(params[:other_id])
  @user2.followers << @user1
  redirect "/profile/#{@user1.id}"
end

post '/profile/:user_id/edit' do
  @user = User.find(params[:user_id])
  @user.about_me = params[:about_me]
  @user.save
  redirect "/profile/#{@user.id}"
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

get '/profile/:blah_id/delete_blah' do
  @blah = Blah.find(params[:blah_id])
  @user = @blah.user
  @blah.delete
  redirect "/profile/#{@user.id}"
end