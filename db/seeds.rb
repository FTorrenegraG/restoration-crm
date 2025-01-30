# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
minitry = Ministry.create!(name: 'Restoration CRM', super_ministry: true, description: 'This minitry is for manage the CRM')
administrador_role = minitry.ministry_roles.create!(name: 'administrador', description: 'This role is going to administrate all CRM')
admin_user = User.find_or_create_by(email: 'admin@example.com') do |new_user|
  new_user.password = Rails.application.credentials.default_admin_password
  new_user.password_confirmation = Rails.application.credentials.default_admin_password
end
admin_user.user_ministry_roles.create!(ministry_id: minitry.id, ministry_role_id: administrador_role.id)
admin_user.user_profiles.create!(
  first_name: 'User',
  last_name: 'Admin',
  birth_date: '01/01/2025'
)