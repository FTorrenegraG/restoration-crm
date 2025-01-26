class User < ApplicationRecord
  has_many :user_profiles, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :user_ministry_roles, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
