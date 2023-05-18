class Api::V1::Record < ApplicationRecord
  belongs_to :user

  validates :travelled_distance, presence: true, numericality: { greater_than: 0 }
  validates :user_id, presence: true
end
