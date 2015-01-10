require 'rails_helper'

RSpec.describe ProfilePic, :type => :model do
	it { should callback(:set_upload_attributes).before(:create) }
	it { should callback(:queue_finalize_and_cleanup).after(:create) }
  it { should have_attached_file(:image) }
end
