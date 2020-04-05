class User < ActiveRecord::Base #active record grabs columns from table
    has_many :dogs
    validates :username, presence: true, uniqueness: true
    validates :email , presence: true, uniqueness: true
  has_secure_password 

end