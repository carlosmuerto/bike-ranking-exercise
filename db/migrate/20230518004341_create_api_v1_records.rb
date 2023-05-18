class CreateApiV1Records < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_records, id: :uuid do |t|
      t.float :travelled_distance
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
