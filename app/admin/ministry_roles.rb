ActiveAdmin.register MinistryRole do

controller do
  before_action :authorize_admin

  private

  def authorize_admin
    authorize resource_class
  end
end

  # Specify parameters which should be permitted for assignment
  permit_params :ministry_id, :name, :description, :uni_key

  # or consider:
  #
  # permit_params do
  #   permitted = [:ministry_id, :name, :description, :uni_key]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :ministry
  filter :name
  filter :uni_key

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :ministry
    column :name
    column :uni_key
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :ministry
      row :name
      row :description
      row :uni_key
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :ministry
      f.input :name
      f.input :description
      f.input :uni_key
    end
    f.actions
  end
end
