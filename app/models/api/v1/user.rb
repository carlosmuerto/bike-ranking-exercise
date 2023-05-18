class Api::V1::User < ApplicationRecord
  has_many :records, class_name: 'Api::V1::Record', dependent: :destroy

  has_secure_password
  has_secure_token

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :with_most_traveled_distance, lambda { |start_date = Time.at(0).to_datetime, end_date = DateTime.now|
    joins(:records)
      .where(records: { created_at: start_date..end_date })
      .group(:id)
      .order('SUM("records"."travelled_distance") DESC')
  }

  def travelled_distance(start_date = Time.at(0).to_datetime, end_date = Date.today)
    records.where(created_at: start_date..end_date).sum(:travelled_distance)
  end

  def self.find_by_auth_token(token)
    find_by(auth_token: token)
  end
end
