class CreateBreeds < ActiveRecord::Migration
  def change
    create_table :breed do |p|
      p.string :name
      p.integer :dog_id
    end
  end
end
