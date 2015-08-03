class Album < ActiveRecord::Base
  # Validations -------------
  validates :title, presence: true,
                    length: { minimum: 1 }
  validates :rank,  presence: true,
                    numericality: { only_integer: true }

  # Scopes -------------
  scope :top, -> { order(rank: :desc).limit(5) }
  scope :rank_order, -> { order(rank: :desc) }
end
