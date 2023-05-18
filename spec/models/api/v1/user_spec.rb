# spec/models/api/v1/user_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::User, type: :model do

  # Test validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value('user@example.com').for(:email) }
  it { should_not allow_value('userexample.com').for(:email) }

  # Test associations
  it { should have_many(:records).dependent(:destroy) }
end
