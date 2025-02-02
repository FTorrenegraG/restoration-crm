ActiveAdmin.register User do
  permit_params :email, :phone_number, :password, :password_confirmation,
                user_profile_attributes: [ :id, :first_name, :last_name, :birth_date, :casa_r ]

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end
  end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :phone_number
    column :casa_r
    actions
  end

  filter :email
  filter :phone_number
  filter :user_profile_casa_r, as: :string, label: 'Casa R'


  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :phone_number
      f.input :password
      f.input :password_confirmation
    end

    f.inputs 'User Profile', for: [ :user_profile, f.object.user_profile || UserProfile.new ] do |profile|
      profile.input :first_name
      profile.input :last_name
      profile.input :birth_date
      profile.input :casa_r
    end

    f.actions
  end

  show do
    attributes_table do
      row :email
      row :phone_number
      row :created_at
      row :updated_at
    end

    panel 'User Profile' do
      if user.user_profile
        attributes_table_for user.user_profile do
          row :first_name
          row :last_name
          row :birth_date do |profile|
            profile.birth_date.strftime('%d/%m/%Y') if profile.birth_date
          end
          row :casa_r
        end
      else
        para 'No user profile available.'
      end
    end
  end
end
