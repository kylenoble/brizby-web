class ProfilePic < ActiveRecord::Base
	belongs_to :user
	belongs_to :business 

	validates :image, :presence => true

	has_attached_file :image, 
						:styles => { :lrg => "720x720>", :med => "480x480>", :sml => "240x240>" }, 
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
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_size :image, :less_than => 2.megabytes

  before_save :decode_image_data

  def decode_image_data

    if self.image_data.present?
        # If image_data is present, it means that we were sent an image over
        # JSON and it needs to be decoded.  After decoding, the image is processed
        # normally via Paperclip.
        if self.image_data.present?
            data = StringIO.new(Base64.decode64(self.image_data))
            data.class.class_eval {attr_accessor :original_filename, :content_type}
            data.original_filename = self.id.to_s + ".png"
            data.content_type = "image/png"

            self.profile_pic_attributes[:image] = data
        end
    end
  end
end
