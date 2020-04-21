class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |p|
     p.string :name
     p.string :second_name
     p.integer :user_id
    end
  end
end
