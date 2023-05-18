require 'rails_helper'

RSpec.describe Api::V1::Record, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:travelled_distance) }
    it { should validate_numericality_of(:travelled_distance).is_greater_than(0) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user).class_name('Api::V1::User') }
  end
end
