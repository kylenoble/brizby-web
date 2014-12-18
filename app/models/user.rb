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

  has_and_belongs_to_many :deals
end
