require 'rails_helper'

describe Business do
  before { @business = FactoryGirl.build(:business) }

  subject { @business }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should allow_value('example@domain.com').for(:email) }

  it { should be_valid }
end