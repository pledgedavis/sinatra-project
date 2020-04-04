class User < ActiveRecord::Base #active record grabs columns from table
    has_many :dogs
  has_secure_password 

end