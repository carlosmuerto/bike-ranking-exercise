class Api::V1::Record < ApplicationRecord
  belongs_to :user, class_name: 'Api::V1::User'

  validates :travelled_distance, presence: true, numericality: { greater_than: 0 }
  validates :user_id, presence: true
end
