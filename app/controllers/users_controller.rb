#Display a list of all the users
get '/users' do
	@users = User.all
	erb :'users/index'
end

#Show form for creating a user
get '/users/new' do
	erb :'users/new'
end

#Add new user to database
post '/users' do
	@user = User.new(params[:user])
	if @user.save
		redirect '/users'
	else
		@errors = @user.errors.full_messages
		erb :'users/new'
	end
end

#User profile page/Show a specific user
#User profile page
get '/users/:id' do
	@user = User.find(params[:id])
	#Logic to see current user matches current page
	if current_user && params[:id].to_i == current_user.id #(or make a helper/model method)
   erb :'users/show'
	else
   #either display errors or re-route
   @errors = "This is not your profile page. Restricted Access."
	end
end

#Form to edit a user
get '/users/:id/edit' do
	@user = User.find(params[:id])

	erb :'users/edit'
end

#Update/Edit a user
put '/users/:id' do
  @user = User.find(params[:id])
  @user.assign_attributes(params[:user]) 

  if @user.save
    redirect '/users' 
  else
  	@errors = @user.errors.full_messages
    erb :'users/edit' 
  end

end

#Delete a user
delete '/users/:id' do
  @user = User.find(params[:id]) 
  @user.destroy 
  redirect '/users'
end




