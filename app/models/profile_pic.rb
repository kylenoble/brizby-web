class ProfilePic < ActiveRecord::Base
	belongs_to :user
	belongs_to :business 

	validates :image, :presence => true
	do_not_validate_attachment_file_type :image
	has_attached_file :image, :default_url => "/whatever-who-cares.png",
						:styles => { :med => "600x600>" }, 
						:whiny => false,
			      :storage => :s3,
			      :bucket  => ENV['AWS_BUCKET'],
			      :s3_permissions => :private,
    				:s3_credentials => { 
    					:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      				:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] 
      			},
    				:path => "api/v1/profile_pic/:attachment/:id/:style/:filename",
						:url => "udealio.profile-pictures.s3-website-us-west-1.amazonaws.com" 
	validates_attachment_size :image, :less_than => 2.megabytes
end
