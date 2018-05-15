class Gist < ApplicationRecord
  validates :description, presence: true, length: { maximum: 255 }
  validates :body, presence: true
end
