require 'rails/generators'

class AdminPolicyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_active_admin_resource
    resource_path = File.join("app/admin", "#{file_name.pluralize}.rb")

    if File.exist?(resource_path)
      puts "⚠️ El recurso ActiveAdmin ya existe: #{resource_path}"
      add_pundit_to_existing_resource(resource_path)
    else
      generate "active_admin:resource", class_name
      add_pundit_to_existing_resource(resource_path)
    end
  end

  def create_pundit_policy
    policy_path = File.join("app/policies", "#{file_name}_policy.rb")
    
    if File.exist?(policy_path)
      puts "⚠️ La política ya existe: #{policy_path}"
    else
      template "policy.rb.erb", policy_path
      puts "✅ Política creada: #{policy_path}"
    end
  end

  private

  def add_pundit_to_existing_resource(resource_path)
    content = File.read(resource_path)

    # Verificar si ya tiene un `controller do`
    unless content.match?(/controller\s+do/)
      puts "➕ Agregando Pundit a #{resource_path}"

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
      puts "✅ El resource ya tiene un controller, no se modificará."
    end
  end
end
