class CreateDogs < ActiveRecord::Migration
  def change
     create_table :dogs do |p|
        p.string :name
        p.integer :age
        p.string :color
        p.integer :owner_id
    end
  end
end
