class AddUniqueIndexToZones < ActiveRecord::Migration[5.2]
  def change
    add_index :zones, :identifier, unique: true
    add_index :zones, :name, unique: true
  end
end
