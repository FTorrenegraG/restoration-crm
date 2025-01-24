class MinistryRole < ApplicationRecord
  belongs_to :ministry
  has_many :ministry_sub_roles, dependent: :destroy
  has_many :user_ministry_roles, dependent: :restrict_with_error

  validates :name, presence: true
  validates :uni_key, presence: true, uniqueness: true # TODO: set this key automatically

  before_validation :generate_uni_key

  private

  def generate_uni_key
    return if ministry.nil? || name.to_s.strip.empty? || uni_key.present?

    key = ministry.name.downcase
    key += '-' + name.downcase
    key.gsub!(' ', '-')
    self.uni_key = key
  end
end
