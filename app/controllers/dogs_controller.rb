class DogController < ApplicationController #for all information from appcontroller

    get '/dogs' do
      @dogs = Dog.all
      erb :'dogs/index'
    end
  
    get '/dogs/new' do
      if !Helpers.logged_in?(session)
        redirect '/'
      end
      erb :'dogs/new'
    end
    
    get '/dogs/:id' do
      if !Helpers.logged_in?(session)
        redirect '/'
      end
      @dog = Dog.find_by(id: params[:id])
      if !@dog
        redirect to '/'
      end
      erb :'dogs/show'
    end
  
    get '/dogs/:id/edit' do
        @dog = Dog.find_by(id: params[:id])
      if !Helpers.logged_in?(session) || !@dog || @dog.user != Helpers.current_user(session)
        redirect '/'
      end
      erb :'/dogs/edit'
    end
  

    post '/dogs' do
        dog = Dog.create(params)
        user = Helpers.current_user(session)
        dog.user = user
        dog.save
        redirect to "/users/#{user.id}"
    end


    patch '/dogs/:id' do
        dog = Dog.find_by(id: params[:id])
      if dog && dog.user == Helpers.current_user(session)
        dog.update(params[:dog])
        redirect to "/dogs/#{dog.id}"
      else
        redirect to "/dogs"
    end
   end
  
   delete '/dogs/:id/delete' do
      dog = Dog.find_by(id: params[:id])
    if dog && dog.user == Helpers.current_user(session)
     dog.destroy
    end
     redirect to '/dogs'
  end
end
  