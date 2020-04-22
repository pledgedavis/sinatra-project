# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public' #styling and images
    set :views, 'app/views'  #look for my views folder inside of my app folder
    enable :sessions  #allows us to use sessions to keep track of current user
    set :session_secret, "secret" #helps set the password
  end

  get "/" do #Method displays my homepage via get route
   if Helpers.logged_in?(session) 
    user = Helpers.current_user(session)
    redirect to "/users/#{user.id}"
   end
    erb :welcome
  end

  helpers do
    def redirect_if_not_allowed(instance) #Argument is set to an instance so i'm able to use instances when called upon
     if !Helpers.logged_in?(session) || !instance || instance.user != Helpers.current_user(session) 
      #if not logged in is false or if an instance does not exist and also is not equal to the current users session were going to redirect to the homepage
       redirect '/'
     end
    end

    def redirect_if_not_logged_in #method checks if users are not logged in if not redirects to homepage
     if !Helpers.logged_in?(session)
      redirect '/'
     end
    end
  end
end
