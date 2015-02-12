class User < ActiveRecord::Base
	acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  validates :username,
  :uniqueness => {
  	:case_sensitive => false
  	}, 
  	:presence => true
  
  has_many :active_followships,  class_name:  "Followship",
                                   foreign_key: "user_id",
                                   dependent:   :destroy
  has_many :passive_followships, class_name:  "Followship",
                                   foreign_key: "user_followed_id",
                                   dependent:   :destroy
  has_many :user_following, through: :active_followships,  source: :user_followed
  has_many :business_following, through: :active_followships,  source: :business_followed
  has_many :followers, through: :passive_followships, source: :user

  def following
    (user_following.all + business_following.all)
  end

  has_and_belongs_to_many :deals
  has_one :profile_pic, :dependent => :destroy
  accepts_nested_attributes_for :profile_pic, :allow_destroy => true
end
