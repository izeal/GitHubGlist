class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  before_validation { email.downcase! }

  has_many :gists, dependent: :destroy
  has_many :comments #todo null obj if user deleted
  has_many :stars, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

  mount_uploader :avatar, AvatarUploader
end
