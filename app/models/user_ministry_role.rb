class UserMinistryRole < ApplicationRecord
  belongs_to :user
  belongs_to :ministry
  belongs_to :ministry_role
end
