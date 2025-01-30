require 'rails/generators'

class AdminPolicyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def modify_active_admin_resource
    resource_path = File.join('app/admin', "#{file_name.pluralize}.rb")

    unless File.exist?(resource_path)
      puts '🆕 Creating new ActiveAdmin resource'
      generate 'active_admin:resource', class_name
    else
      
      puts "⚠️ ActiveAdmin resource already exists: #{resource_path}, skipping."
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
end
