class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :user_ministry_roles, dependent: :destroy
  has_many :ministry_roles, through: :user_ministry_roles

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  accepts_nested_attributes_for :user_profile

  delegate :first_name, :last_name, :birth_date, :casa_r, :other_details, to: :user_profile, allow_nil: true

  after_create :build_user_profile, unless: :user_profile

  def self.ransackable_attributes(auth_object = nil)
    # Return an array of attribute names that should be searchable
    # Example:
    [ 'email', 'phone_number', 'created_at' ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ 'alerts', 'assignments', 'availabilities', 'ministry_roles', 'user_ministry_roles', 'user_profile' ]
  end

  def build_user_profile
    UserProfile.create(user: self)
  end
end
