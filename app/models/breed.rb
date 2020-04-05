class Breed < ActiveRecord::Base #active record grabs columns from table
    belongs_to :dog

end