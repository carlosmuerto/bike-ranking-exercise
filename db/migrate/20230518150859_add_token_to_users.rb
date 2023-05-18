class AddTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :api_v1_users, :token, :string
  end
end