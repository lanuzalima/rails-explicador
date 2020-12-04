class Booking < ApplicationRecord
  belongs_to :availability
  belongs_to :user

  has_one :lecture, through: :availability
end
