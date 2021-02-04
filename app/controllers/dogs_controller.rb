class DogController < ApplicationController #for all information from appcontroller

  get '/dogs' do #uses a get verb/route to load all dogs 
    redirect_if_not_logged_in 
   @current_user =  Helpers.current_user(session).username
   @dogs = Dog.all
   erb :'dogs/index'
  end
  
  get '/dogs/new' do # checks if user is not logged in then if so redirects to the homepage
    redirect_if_not_logged_in
   erb :'dogs/new'
  end
    
  get '/dogs/:id' do
    redirect_if_not_logged_in #if user is not logged in redirect to the homepage
    @dog = Dog.find_by(id: params[:id]) # then finds a dog  and if the dog isnt fond then redirects to the hompage 
    dog_owner = @dog.user #allows a dog to have a user
   if !dog_owner
    redirect to '/'
   end
    erb :'dogs/show'
  end

  get '/dogs/:id/edit' do
   @dog = Dog.find_by(id: params[:id])
  #  binding.pry
   redirect_if_not_allowed(@dog)
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
   @dog = Dog.find_by(id: params[:id])
   redirect_if_not_allowed(@dog)  
   @dog.update(params[:dog])
   redirect to "/dogs/#{@dog.id}"
  end
  
  delete '/dogs/:id/delete' do 
   dog = Dog.find_by(id: params[:id])
   redirect_if_not_allowed(dog)
   dog.destroy
   redirect to '/dogs'
  end
end
  