class CreateCloudflareAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :cloudflare_accounts do |t|
      t.string :email, null: false
      t.string :key, null: false
      t.string :name, null: true

      t.references :user, null: false

      t.timestamps
    end
  end
end
