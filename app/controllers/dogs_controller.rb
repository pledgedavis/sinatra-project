class DogController < ApplicationController #for all information from appcontroller

    get '/dogs' do
      @dogs = Dog.all
      erb :'dogs/index'
    end
  
    get '/dogs/new' do # checks if user is not logged in then if so redirects to the homepage
      if !Helpers.logged_in?(session)
        redirect '/'
      end
      erb :'dogs/new'
    end
    
    get '/dogs/:id' do
      if !Helpers.logged_in?(session) #if user is not logged in redirect to the homepage
        redirect '/'
      end
      @dog = Dog.find_by(id: params[:id]) # then finds a dog  and if the dog isnt fond then redirects to the hompage 
      if !@dog
        redirect to '/'
      end
      erb :'dogs/show'
    end
  
    get '/dogs/:id/edit' do
        @dog = Dog.find_by(id: params[:id])
      if !Helpers.logged_in?(session) || !@dog || @dog.user != Helpers.current_user(session) #checks if the user is not logged in or if the dog cannot be found or if the user is not the current user 
        redirect '/'
      end
      erb :'/dogs/edit'
    end
  

    post '/dogs' do #connected to my dogs/new <form> which helps create the users input
        dog = Dog.create(params)  #creates a dog with the attrabutes i assigned it 
        user = Helpers.current_user(session) #finds the current logged in user 
        dog.user = user 
        dog.save #assignes the current user the created dog and then saves it
        redirect to "/users/#{user.id}" #then redirects to the users page
    end


    patch '/dogs/:id' do
        dog = Dog.find_by(id: params[:id])
      if dog && dog.user == Helpers.current_user(session) #checks if current user and dog is the current logged in user 
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
  