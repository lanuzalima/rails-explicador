class Availability < ApplicationRecord
  validates :start_time, presence: true, uniqueness: true
  belongs_to :lecture
  has_one :booking
end
