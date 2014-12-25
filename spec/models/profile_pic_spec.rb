require 'rails_helper'

RSpec.describe ProfilePic, :type => :model do

  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:image).
                less_than(2.megabytes) }
end
