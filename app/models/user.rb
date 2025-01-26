class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  has_many :user_profiles, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :user_ministry_roles, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.ransackable_attributes(auth_object = nil)
    # Return an array of attribute names that should be searchable
    # Example:
    [ 'first_name', 'last_name', 'email', 'created_at' ]
  end
end
