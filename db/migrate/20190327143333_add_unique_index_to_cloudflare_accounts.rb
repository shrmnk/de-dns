class AddUniqueIndexToCloudflareAccounts < ActiveRecord::Migration[5.2]
  def change
    add_index :cloudflare_accounts, :email, unique: true
  end
end
