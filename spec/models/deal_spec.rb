require 'rails_helper'

RSpec.describe Deal, :type => :model do
  	it { should validate_presence_of(:business_id) }
    it { should validate_presence_of(:expires_at) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:name) }
end
