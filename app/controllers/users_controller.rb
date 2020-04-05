class UserController < ApplicationController #for all information from appcontroller



    get "/signup" do #user is going to navigate to this route 
     if Helpers.logged_in?(session)
        user = Helpers.current_user(session)
       redirect to "/users/#{user.id}"
     else 
       erb :'/users/signup'
     end 
    end


    get "/login" do 
     if Helpers.logged_in?(session)
       user = Helpers.current_user(session)
      redirect to "/users/#{user.id}"
     else 
      erb :'/users/login'
     end 
    end

    post '/login' do 
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "/users/#{user.id}"
      else
        redirect to '/signup'
      end
    end

 post "/user" do 
    #   binding.pry
    @user = User.create(params) #params grabs my current params hash attributes
    session[:user_id] = user.id
   redirect to "/users/#{users.id}"
 end

 get "/users/:id" do 
    if User.find_by(id: params[:id]) 
      @user = User.find_by(id: params[:id])
     erb :'/users/show'
  else
     redirect to '/'
  end
 end
end