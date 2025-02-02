class UserProfile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ 'birth_date', 'casa_r', 'created_at', 'first_name', 'id', 'id_value', 'last_name', 'other_details', 'updated_at',
'user_id' ]
  end
end
