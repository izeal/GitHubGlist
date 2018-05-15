class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation { email.downcase! }

  has_many :gists, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

end
