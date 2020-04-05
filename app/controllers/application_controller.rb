# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public' #styling and images
    set :views, 'app/views'  #look for my views folder inside of my app folder
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    # binding.pry
    erb :welcome
  end
end
