class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |p|
       p.string :username
       p.string :email
       p.string :password_digest #uses bcrypt gem and encrypts password 
    end
  end
end
