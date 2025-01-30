require 'rails/generators'

class AdminPolicyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_active_admin_resource
    resource_path = File.join("app/admin", "#{file_name.pluralize}.rb")

    if File.exist?(resource_path)
      puts "⚠️ ActiveAdmin resource already exists: #{resource_path}"
      add_pundit_to_existing_resource(resource_path)
    else
      generate "active_admin:resource", class_name
      add_pundit_to_existing_resource(resource_path)
    end
  end

  def create_pundit_policy
    policy_path = File.join("app/policies", "#{file_name}_policy.rb")
    
    if File.exist?(policy_path)
      puts "⚠️ Policy already exists: #{policy_path}"
    else
      template "policy.rb.erb", policy_path
      puts "✅ Policy created: #{policy_path}"
    end
  end

  private

  def add_pundit_to_existing_resource(resource_path)
    content = File.read(resource_path)

    # Check if the resource already has a `controller do` block
    unless content.match?(/controller\s+do/)
      puts "➕ Adding Pundit authorization to #{resource_path}"

      controller_block = <<~RUBY

        controller do
          before_action :authorize_admin

          private

          def authorize_admin
            authorize resource_class
          end
        end
      RUBY

      File.open(resource_path, "a") { |file| file.puts(controller_block) }
    else
      puts "✅ The resource already has a controller block, skipping modification."
    end

    # Add menu visibility condition if it's not already present
    unless content.match?(/menu\s+if:/)
      puts "➕ Adding menu visibility condition to #{resource_path}"

      menu_condition = <<~RUBY

        menu if: proc { authorized?(:index, resource_class) }
      RUBY

      File.open(resource_path, "a") { |file| file.puts(menu_condition) }
    else
      puts "✅ The resource already has a menu visibility condition, skipping modification."
    end
  end
end
