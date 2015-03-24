class Avatar < ActiveRecord::Base
  belongs_to :avatarable, polymorphic: true

	BUCKET_NAME = ENV["AWS_BUCKET"]

  has_attached_file :image,
                    :styles => { :thumbnail => "150x150#", :med =>  "300x300#", :lrg => "450x450#" }

  do_not_validate_attachment_file_type :image
  validates :direct_upload_url, presence: true
   
  before_validation(on: :create) do 
    self.set_upload_attributes
  end

  after_create(on: :create) do 
    self.queue_finalize_and_cleanup
  end

  # Store an unescaped version of the escaped URL that Amazon returns from direct upload.
  def direct_upload_url=(escaped_url)
    write_attribute(:direct_upload_url, (CGI.unescape(escaped_url) rescue nil))
  end
  # Determines if file requires post-processing (image resizing, etc)
  
  def update_file(params)
    self.processed = false
    self.attributes = params
    set_upload_attributes
    save!
    Avatar.delay.finalize_and_cleanup(id)
  end

  # Final upload processing step
  def self.transfer_and_cleanup(id)
    avatar = Avatar.find(id)
    direct_upload_url_data = URI.parse(avatar.direct_upload_url).path[8..-1].to_s
    s3 = AWS::S3.new

    avatar.image = s3.buckets[BUCKET_NAME].objects[direct_upload_url_data].url_for(:read)
    avatar.image.reprocess!

    avatar.processed = true
    avatar.save!
    
    s3.buckets[BUCKET_NAME].objects[direct_upload_url_data].delete
  end
      
  protected
  
  # Set attachment attributes from the direct upload
  # @note Retry logic handles S3 "eventual consistency" lag.
  def set_upload_attributes
    tries ||= 5
    direct_upload_url_data = URI.parse(direct_upload_url).path[8..-1].to_s
    s3 = AWS::S3.new
    direct_upload_head = s3.buckets[BUCKET_NAME].objects[direct_upload_url_data].head
    self.image_file_name     = direct_upload_url_data[direct_upload_url_data]
    self.image_file_size     = direct_upload_head.content_length
    self.image_content_type  = direct_upload_head.content_type
    self.image_updated_at    = direct_upload_head.last_modified
    self.processed           = false    
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
    Avatar.delay.transfer_and_cleanup(id)
  end
 
end





