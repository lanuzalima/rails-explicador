class Lecture < ApplicationRecord
  has_many :availabilities, dependent: :destroy
  belongs_to :user
  has_many :bookings, through: :availabilities
end
