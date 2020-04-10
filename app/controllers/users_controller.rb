class UserController < ApplicationController #for all information from appcontroller
   
    get '/users' do
      if Helpers.logged_in?(session)
        @users = User.all
      else
        redirect to '/'
      end
      erb :'users/index'
    end
  
    get '/signup' do
      if Helpers.logged_in?(session)
        user = Helpers.current_user(session)
        redirect to "/users/#{user.id}"
      end
      erb :'users/signup'
    end
  
    get '/users/:id' do
        if Helpers.logged_in?(session) && User.find_by(id: params[:id])
          @user = User.find_by(id: params[:id])
          @dogs = @user.dogs
        else
          redirect to '/'
        end
        erb :'users/show'
      end

    get '/login' do
      if Helpers.logged_in?(session)
        user = Helpers.current_user(session)
        redirect to "/users/#{user.id}"
      end
      erb :'users/login'
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
  
    post '/signup' do
      user = User.create(params)
      if user.valid?
        session[:user_id] = user.id
        redirect to "/users/#{user.id}"
      else
        redirect to '/signup'
      end
    end

    get '/logout' do
      session.clear
      redirect to '/'
    end  
  end
  



