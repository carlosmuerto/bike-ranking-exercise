object @api_v1_record => :record
attributes :id, :travelled_distance, :created_at, :user

child user: :user do
  attributes :id, :name, :email
end
