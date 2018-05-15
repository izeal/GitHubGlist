class Gist < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  validates :body, presence: true
end
