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
  
  has_many :followships
  has_many :user_follows, through: :followships
  has_many :business_follows, through: :followships

  has_and_belongs_to_many :deals
  has_one :profile_pic, :dependent => :destroy
  accepts_nested_attributes_for :profile_pic, :allow_destroy => true
end
