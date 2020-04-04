class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |p|
      p.string
  end
end
