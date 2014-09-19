

get '/dashboard/:user_id' do
  @user = User.find(params[:user_id])

  @all_blahs = []
  @user.followees.each do |follower|
    follower.blahs.each do |blah|
      @all_blahs << blah
    end
  end

  @wall_blahs = @all_blahs.sort_by {|blah| blah.created_at }
  @sorted_blahs = @wall_blahs.reverse

  @other_users = (User.all - @user.followees).sample(10)

  erb :dashboard
end

post '/dashboard/:id/blah' do
  @user = User.find(params[:id])
  @user.blahs.create(content: params[:content])
  redirect "/dashboard/#{@user.id}"
end

post '/profile/:user_id/follow/:other_id' do
  @user1 = User.find(params[:user_id])
  @user2 = User.find(params[:other_id])
  @user2.followers << @user1
  redirect "/dashboard/#{@user1.id}"
end

post '/dashboard/:user_id/unfollow/:other_id' do
  @user = User.find(params[:user_id])
  @user.followees.delete(User.find(params[:other_id]))
  redirect "/dashboard/#{@user.id}"
end



