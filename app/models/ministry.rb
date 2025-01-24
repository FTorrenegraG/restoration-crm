class Ministry < ApplicationRecord
  has_many :ministry_roles, dependent: :destroy
  has_many :user_ministry_roles, dependent: :restrict_with_error

  validates :name, presence: true
end
