class AddUniqueIndexToHostnames < ActiveRecord::Migration[5.2]
  def change
    add_index :hostnames, :name, unique: true
  end
end
