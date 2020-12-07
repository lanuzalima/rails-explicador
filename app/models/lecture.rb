class Lecture < ApplicationRecord
  has_many :availabilities, dependent: :destroy
  belongs_to :user
  has_many :bookings, through: :availabilities

  validates :title, :subject, :description, :duration, presence: true
  validates :title, uniqueness: { scope: :user_id,
                                  message: "Já existe uma aula com esse título" }

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[title subject description duration],
                  associated_against: {
                    user: %i[name username]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
