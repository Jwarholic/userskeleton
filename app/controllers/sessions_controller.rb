get '/sessions/new' do
	erb :'sessions/new'
end

post '/sessions' do
	@user = User.authenticate(params[:user])
	if @user
		session[:id] = @user.id
		redirect '/'
	else
		@error = "Email and password not a valid combination."
		erb :'sessions/new'
	end
end

delete '/sessions' do
	session[:id] = nil
	redirect '/'
end