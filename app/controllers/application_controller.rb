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
    def redirect_if_not_allowed(instance = nil) #made equal to nil so when called on the value is optional
     if !Helpers.logged_in?(session) || !instance && !! instance.user != Helpers.current_user(session) 
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
