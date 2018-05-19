class Gist < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :stars, dependent: :destroy

  validates :user, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  validates :body, presence: true

  scope :created_at_asc, -> {
    order(created_at: :asc)
  }

  scope :created_at_desc, -> {
    order(created_at: :desc)
  }

  scope :updated_at_asc, -> {
    order(updated_at: :asc)
  }

  scope :updated_at_desc, -> {
    order(updated_at: :desc)
  }
end
