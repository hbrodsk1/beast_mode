class User < ApplicationRecord
	has_many :outlets
	
	validates :username, :email, :encrypted_password, presence: true
	validates :username, :email, uniqueness: true
	validates :password, length: { in: 5..30 }
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
end
