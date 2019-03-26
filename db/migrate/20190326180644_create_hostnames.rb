class CreateHostnames < ActiveRecord::Migration[5.2]
  def change
    create_table :hostnames do |t|
      t.string :name, null: false
      t.string :a, null: false
      t.string :aaaa
      t.string :mx
      t.references :zone, foreign_key: true, null: false

      t.timestamps
    end
  end
end
