class Helpers
#this helpers class maintains neatness throughout my application by defining usable instance methods in this file 
 def self.current_user(session)  
   User.find_by(id: session[:user_id]) #uses the sessions hash to find current user by id
 end

 def self.logged_in?(session)
    session[:user_id] ? true : false #method checks if users has an id because if so the user is logged in
 end
end
