class CreateApiV1Users < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :api_v1_users, :email, unique: true
  end
end
