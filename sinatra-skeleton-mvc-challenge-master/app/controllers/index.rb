# could the user id be dropped from this URL somehow?
get '/dashboard/:user_id' do
  # sort of weird to check for signed-in-ness BEFORE having the user's info;
  #  maybe make it all available as part of a helper?
  if signed_in?
    @user = User.find(params[:user_id])

    # what's going on here?
    @followees = @user.followees - [@user]

    @all_blahs = []
    @user.followees.each do |follower|
      follower.blahs.each do |blah|
        @all_blahs << blah
     end
    end

  # shouldn't be any puts statements in production-ready code
  p @search_results = User.where("full_name LIKE '#{params[:search]}'")

  @wall_blahs = @all_blahs.sort_by {|blah| blah.created_at }
  @sorted_blahs = @wall_blahs.reverse
  @email_address = @user[:email].downcase
  @hash = Digest::MD5.hexdigest(@email_address)
  @other_users = (User.all - @user.followees).sample(10)
  @image_src = "http://www.gravatar.com/avatar/#{@hash}"
  erb :dashboard
  end
end

# a blah is not a product of a dashboard; should probably look more like
#  POST '/users/:id/blah'
post '/dashboard/:id/blah' do
  if signed_in?
    if params[:content].length > 140
      @user = User.find(params[:id])
      # that's some pretty harsh validation!
      redirect "/dashboard/#{@user.id}"
    else
    @user = User.find(params[:id])
    @user.blahs.create(content: params[:content])
    redirect "/dashboard/#{@user.id}"
  end
  end
end

# the following 2 routes could alternatively look like POST/DELETE to:
#  '/dashboard/:user_id/followers/:other_id'
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

