class Dog < ActiveRecord::Base #active record grabs columns from table
belongs_to :user
has_many :breeds

end