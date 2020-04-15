# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public' #styling and images
    set :views, 'app/views'  #look for my views folder inside of my app folder
    enable :sessions  #allows us to use sessions to keep track of current user
    set :session_secret, "secret" #helps set the password
  end

  get "/" do #Method displays my homepage via get route
    # if Helpers.logged_in?(session) 
    #   @user = Helpers.current_user(session)
    # end
    erb :welcome
  end
end
