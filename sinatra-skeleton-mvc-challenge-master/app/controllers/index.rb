

get '/dashboard/:user_id' do
  if signed_in?
    @user = User.find(params[:user_id])

    @followees = @user.followees - [@user]

    @all_blahs = []
    @user.followees.each do |follower|
      follower.blahs.each do |blah|
        @all_blahs << blah
     end
    end

  p @search_results = User.where("full_name LIKE '#{params[:search]}'")

  @wall_blahs = @all_blahs.sort_by {|blah| blah.created_at }
  @sorted_blahs = @wall_blahs.reverse

  @other_users = (User.all - @user.followees).sample(10)
  @image_src = "http://www.gravatar.com/avatar/#{@hash}"
  erb :dashboard
  end
end

post '/dashboard/:id/blah' do
  if signed_in?
    @user = User.find(params[:id])
    @user.blahs.create(content: params[:content])
    redirect "/dashboard/#{@user.id}"
  end
end

post '/dashboard/:user_id/follow/:other_id' do
  @user1 = User.find(params[:user_id])
  @user2 = User.find(params[:other_id])
  @user2.followers << @user1
  redirect "/dashboard/#{@user1.id}"
end

post '/dashboard/:user_id/unfollow/:other_id' do
  if signed_in?
    @user = User.find(params[:user_id])
    @user.followees.delete(User.find(params[:other_id]))
    redirect "/dashboard/#{@user.id}"
  end
end

post '/dashboard/:id/search' do
  redirect "/dashboard/#{params[:id]}?search=#{params[:search]}"
end

post '/profile/:id/search' do
  redirect "/profile/#{params[:id]}?search=#{params[:search]}"
end

