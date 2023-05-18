object @api_v1_record => :record
extends 'api/v1/records/_show'

child user: :user do
  extends 'api/v1/users/_show'
end
