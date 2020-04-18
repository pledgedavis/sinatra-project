class UserController < ApplicationController #for all information from appcontroller
   
    get '/users' do
      # if Helpers.logged_in?(session)
      redirect_if_not_logged_in
        @users = User.all
      # else
      #   redirect to '/'
      # end
      erb :'users/index' 
    end

    get '/login' do
        if Helpers.logged_in?(session)
          user = Helpers.current_user(session)
          redirect to "/users/#{user.id}"
        end
        erb :'users/login'
      end
    
  
    get '/signup' do
      if Helpers.logged_in?(session)
        user = Helpers.current_user(session)
        redirect to "/users/#{user.id}"
      end
      erb :'users/signup'
    end
  
    get '/users/:id' do #my get request interacts with my post /login and intepolated user id
        if Helpers.logged_in?(session) && User.find_by(id: params[:id])
          @user = User.find_by(id: params[:id])
          @dogs = @user.dogs
        else
          redirect to '/'
        end
        erb :'users/show'
      end

    
    post '/login' do
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id #checks the session hash if the current user id matches without the session the users id would be lost
        redirect to "/users/#{user.id}"
      else
        redirect to '/signup'
      end
    end
  
    post '/signup' do #uses a form method in my erb file with the action as well
      user = User.create(params) #using create to create and save to the the new created user to the database with the attributes from my params hash
    # binding.pry
      if user.valid?
        session[:user_id] = user.id
        redirect to "/users/#{user.id}" #uses interpolation to redirect to the specific /users/ page
      else
        # flash[:message] = "Log into your account"
        redirect to '/signup'
      end
    end

    get '/logout' do
      session.clear
      redirect to '/'
    end  
  end
  



