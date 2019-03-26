class CreateZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zones do |t|
      t.string :identifier, null: false
      t.string :name, null: false

      t.references :cloudflare_account, null: false

      t.timestamps
    end
  end
end
