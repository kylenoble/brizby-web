require 'rails_helper'
require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_presence_of(:username) }
	it { should validate_uniqueness_of(:username) }
	it { should allow_value('example@domain.com').for(:email) }


  it { should be_valid }
end
