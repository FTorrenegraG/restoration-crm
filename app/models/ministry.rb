class Ministry < ApplicationRecord
  has_many :ministry_roles, dependent: :destroy
  has_many :user_ministry_roles, dependent: :restrict_with_error

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    # Return an array of attribute names that should be searchable
    # Example:
    ["created_at", "description", "id", "name", "super_ministry", "updated_at"]
  end
end
