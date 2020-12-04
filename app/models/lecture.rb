class Lecture < ApplicationRecord
  has_many :availabilities, dependent: :destroy
  belongs_to :user
end
