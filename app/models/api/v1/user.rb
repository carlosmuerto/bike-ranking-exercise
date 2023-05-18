class Api::V1::User < ApplicationRecord
  has_many :records, dependent: :destroy

  before_create :maybe_assign_id

  has_secure_password

  validates :id, presence: true, on: :update
  validates :id, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def maybe_assign_id
    self.id = SecureRandom.uuid if id.blank?
  end
end
