class ProfilePic < ActiveRecord::Base
	belongs_to :user
	belongs_to :business 

	BUCKET_NAME = Rails.application.secrets.aws['s3_bucket_name']
	has_attached_file :image, :default_url => "/whatever-who-cares.png",
						:styles => { :medium => "600x600>" }, 
			      :storage => :s3,
			      :bucket  => ENV['AWS_BUCKET'],
			      :s3_permissions => :private,
    				:s3_credentials => { 
    					:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      				:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] 
      			},
    				:path => "api/v1/profile-pic/:attachment/:id/:style/:filename",
						:url => "s3-website-us-west-1.amazonaws.com/udealio/" 
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/  
  validates :direct_upload_url, presence: true
   
  before_validation :set_upload_attributes
  after_create :queue_finalize_and_cleanup

  # Store an unescaped version of the escaped URL that Amazon returns from direct upload.
  def direct_upload_url=(escaped_url)
    write_attribute(:direct_upload_url, (CGI.unescape(escaped_url) rescue nil))
  end
  # Determines if file requires post-processing (image resizing, etc)
  
  # Final upload processing step
  def self.transfer_and_cleanup(id)
  	puts "working transfer_and_cleanup"
    profile_pic = ProfilePic.find(id)
    direct_upload_url_data = URI.parse(profile_pic.direct_upload_url).path[9..-1].to_s
    s3 = AWS::S3.new
    
    profile_pic.image = URI.parse(URI.escape(profile_pic.direct_upload_url))

    profile_pic.processed = true
    profile_pic.save
    
    s3.buckets[BUCKET_NAME].objects[direct_upload_url_data].delete
  end
      
  protected
  
  # Set attachment attributes from the direct upload
  # @note Retry logic handles S3 "eventual consistency" lag.
  def set_upload_attributes
    puts URI.parse(URI.escape(direct_upload_url))
    tries ||= 5
    direct_upload_url_data = URI.parse(direct_upload_url).path[9..-1].to_s
    s3 = AWS::S3.new
    direct_upload_head = s3.buckets[BUCKET_NAME].objects[direct_upload_url_data].head
   	self.image_file_name     = direct_upload_url_data[direct_upload_url_data]
    self.image_file_size     = direct_upload_head.content_length
    self.image_content_type  = direct_upload_head.content_type
    self.image_updated_at    = direct_upload_head.last_modified
    self.processed 					 = false    
  rescue AWS::S3::Errors::NoSuchKey => e
    tries -= 1
    if tries > 0
      sleep(3)
      retry
    else
      raise e
    end
  end
  
  # Queue file processing
  def queue_finalize_and_cleanup
    ProfilePic.delay.transfer_and_cleanup(id)
    puts "queueing"
  end
 
end
