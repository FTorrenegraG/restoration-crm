ActiveAdmin.register Song do
  # Specify parameters which should be permitted for assignment
  permit_params :title, :performer, :key, :song_type, :reference_link, :lyrics, :sheet_music, :vocals

  # or consider:
  #
  # permit_params do
  #   permitted = [:title, :performer, :key, :song_type, :reference_link, :lyrics, :sheet_music, :vocals]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :title
  filter :performer
  filter :key
  filter :song_type

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    column :title
    column :performer
    column :key
    column :song_type
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table do
      row :title
      row :performer
      row :key
      row :song_type
      row :reference_link do |song|
        if song.reference_link.present?
          youtube_id = song.reference_link.split('v=').last
          if youtube_id.present?
            content_tag(:div, style: 'margin-top: 10px;') do
              content_tag(:iframe, '', width: '300', height: '200', src: "https://www.youtube.com/embed/#{youtube_id}",
                          frameborder: '0', allow: 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture', allowfullscreen: true)
            end
          else
            link_to song.reference_link, song.reference_link, target: '_blank'
          end
        else
          I18n.t('active_admin.songs.show.no_reference_link')
        end
      end
      row :lyrics do |song|
        if song.lyrics.present?
          file_id = song.lyrics.split('/d/').last.split('/').first
          content_tag(:div) do
            link_to(I18n.t('active_admin.songs.show.view_lyrics'),
                    "https://drive.google.com/uc?export=download&id=#{file_id}", target: '_blank') +
                    content_tag(:iframe, '', src: "https://drive.google.com/file/d/#{file_id}/preview", width: '100%',
                    height: '400', frameborder: '0', style: 'margin-top: 10px;')
          end
        else
          I18n.t('active_admin.songs.show.no_lyrics')
        end
      end
      row :sheet_music do |song|
        if song.sheet_music.present?
          file_id = song.sheet_music.split('/d/').last.split('/').first
          content_tag(:div) do
            link_to(I18n.t('active_admin.songs.show.view_sheet_music'),
                    "https://drive.google.com/uc?export=download&id=#{file_id}", target: '_blank') +
                    content_tag(:iframe, '', src: "https://drive.google.com/file/d/#{file_id}/preview", width: '100%',
                    height: '400', frameborder: '0', style: 'margin-top: 10px;')
          end
        else
          I18n.t('active_admin.songs.show.no_sheet_music')
        end
      end
      row :vocals do |song|
        if song.vocals.present?
          file_id = song.vocals.split('/d/').last.split('/').first
          content_tag(:div) do
            link_to(I18n.t('active_admin.songs.show.view_vocals'),
                    "https://drive.google.com/uc?export=download&id=#{file_id}", target: '_blank') +
                    content_tag(:iframe, '', src: "https://drive.google.com/file/d/#{file_id}/preview", width: '100%',
                    height: '400', frameborder: '0', style: 'margin-top: 10px;')
          end
        else
          I18n.t('active_admin.songs.show.no_vocals')
        end
      end
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :title
      f.input :performer
      f.input :key
      f.input :song_type
      f.input :reference_link
      f.input :lyrics
      f.input :sheet_music
      f.input :vocals
    end
    f.actions
  end
end
