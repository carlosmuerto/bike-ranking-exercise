object @api_v1_user => :user
extends "api/v1/users/_show"

child :records => :records do
    extends "api/v1/records/_show"
end