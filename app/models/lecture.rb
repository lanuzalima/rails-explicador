class Lecture < ApplicationRecord
  has_many :availabilities, dependent: :destroy
  belongs_to :user
  has_many :bookings, through: :availabilities

  validates :title, :subject, :description, :duration, presence: true
  validates :title, uniqueness: { scope: :user_id,
                                  message: "Já existe uma aula com esse título" }
end
