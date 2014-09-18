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
end

post '/login' do
end


