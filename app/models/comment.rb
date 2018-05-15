class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :gist

  validates :user, presence: true
  validates :gist, presence: true
  validates :body, presence: true
end
