class MinistryRole < ApplicationRecord
  belongs_to :ministry
  has_many :ministry_sub_roles, dependent: :destroy
  has_many :user_ministry_roles, dependent: :restrict_with_error

  validates :name, presence: true
  validates :uni_key, presence: true, uniqueness: true # TODO: set this key automatically

  before_validation :generate_uni_key

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "ministry_id", "name", "uni_key", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["ministry", "ministry_sub_roles", "user_ministry_roles"]
  end

  private

  def generate_uni_key
    return if ministry.nil? || name.to_s.strip.empty? || uni_key.present?

    key = ministry.name.downcase
    key += '-' + name.downcase
    key.gsub!(' ', '-')
    self.uni_key = key
  end
end
