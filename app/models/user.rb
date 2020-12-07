class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :lectures, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :availabilities, through: :lectures
  has_many :bookings, through: :availabilities

  validates :name, :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
end
