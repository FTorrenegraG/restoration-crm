class MinistryRole < ApplicationRecord
  belongs_to :ministry
  has_many :ministry_sub_roles, dependent: :destroy
  has_many :user_ministry_roles, dependent: :restrict_with_error

  validates :name, presence: true
  validates :description, presence: true
  validates :uni_key, presence: true, uniqueness: true # TODO: set this key automatically
end
