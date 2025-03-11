class Assignment < ApplicationRecord
  belongs_to :event
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "event_id", "id", "role", "status", "updated_at", "user_id"]
  end
end
