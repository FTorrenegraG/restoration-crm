class User < ApplicationRecord
  has_secure_password

  has_many :user_profiles, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :user_ministry_roles, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true
end
