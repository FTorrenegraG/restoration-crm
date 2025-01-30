require 'rails/generators'

class AdminPolicyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def modify_active_admin_resource
    resource_path = File.join('app/admin', "#{file_name.pluralize}.rb")

    if File.exist?(resource_path)
      puts "⚠️ ActiveAdmin resource found: modifying #{resource_path}"
      update_existing_resource(resource_path)
    else
      puts '🆕 Creating new ActiveAdmin resource'
      generate 'active_admin:resource', class_name
      update_existing_resource(resource_path)
    end
  end

  def create_pundit_policy
    policy_path = File.join("app/policies", "#{file_name}_policy.rb")
    scope_path = File.join("app/policies/scopes", "#{file_name}_scope.rb")

    unless File.exist?(policy_path)
      template "policy.rb.erb", policy_path
      puts "✅ Policy created: #{policy_path}"
    else
      puts "⚠️ Policy already exists: #{policy_path}, skipping."
    end

    unless File.exist?(scope_path)
      template "scope.rb.erb", scope_path
      puts "✅ Scope created: #{scope_path}"
    else
      puts "⚠️ Scope already exists: #{scope_path}, skipping."
    end
  end

  private

  def update_existing_resource(resource_path)
    content = File.read(resource_path)
    modified = false

    # Ensure `controller do` block exists
    unless content.include?('controller do')
      puts '➕ Adding Pundit authorization inside ActiveAdmin.register'
      content.sub!(/ActiveAdmin\.register .* do/) do |match|
        modified = true
        <<~RUBY
          #{match}

          controller do
            before_action :authorize_admin

            private

            def authorize_admin
              authorize resource_class
            end
          end
        RUBY
      end
    else
      puts '✅ The resource already has a controller block, skipping modification.'
    end

    if modified
      File.write(resource_path, content)
      puts "✅ Resource updated successfully: #{resource_path}"
    else
      puts "✅ No changes needed in #{resource_path}"
    end
  end
end
