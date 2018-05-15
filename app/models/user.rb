class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_validation { email.downcase! }

  has_many :gists, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }
  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: true,
            format: { with: VALID_EMAIL_REGEX }

end
