# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public' #styling and images
    set :views, 'app/views'  #look for my views folder inside of my app folder
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
    end
    erb :welcome
  end
end
