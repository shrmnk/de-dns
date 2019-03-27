class AddTokenToHostname < ActiveRecord::Migration[5.2]
  def change
    add_column :hostnames, :token, :string, null: false
  end
end
