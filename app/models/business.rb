class Business < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:email]

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.full_address_changed? }
  
  has_many :passive_followships, class_name:  "Followship",
                                   foreign_key: "business_followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_followships, source: :user                                

  has_many :deals
  has_one :profile_pic, :dependent => :destroy
	accepts_nested_attributes_for :profile_pic, :allow_destroy => true
end
