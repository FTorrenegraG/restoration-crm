ActiveAdmin.register Event do
  permit_params :name, :start_datetime, :end_datetime, :location, :description, :status, song_ids: []

  filter :name
  filter :location
  filter :status, as: :select, collection: [ 'Planned', 'Completed', 'Cancelled' ]
  filter :start_datetime, as: :date_range
  filter :end_datetime, as: :date_range
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  index do
    selectable_column
    column :name, sortable: true
    column :start_datetime, sortable: true do |event|
      event.start_datetime.strftime('%d-%m-%Y %H:%M')
    end
    column :end_datetime, sortable: true do |event|
      event.end_datetime.strftime('%d-%m-%Y %H:%M')
    end
    column :location, sortable: true
    column :status, sortable: true
    column :created_at, sortable: true do |event|
      event.created_at.strftime('%d-%m-%Y')
    end
    actions
  end

  show do
    panel I18n.t('active_admin.events.form.details') do
      attributes_table do
        row :name
        row :start_datetime
        row :end_datetime
        row :location
        row :description
        row :status
        row :created_at
        row :updated_at
      end
    end

    panel I18n.t('custom_panels.event_songs') do
      if resource.songs.any?
        table_for resource.songs do
          column :title do |song|
            link_to song.title, admin_song_path(song) if song.title.present?
          end
          column :performer
          column :song_type
          column :key
        end
      else
        div { 'No songs are associated with this event.' }
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names

    f.inputs I18n.t('active_admin.events.form.details') do
      f.input :name
      f.input :start_datetime, as: :string, input_html: { class: 'datepicker' }
      f.input :end_datetime, as: :string, input_html: { class: 'datepicker' }
      f.input :location
      f.input :description
      f.input :status, as: :select, collection: Event.statuses.keys.map { |s| [ s.humanize, s ] }, include_blank: false
    end

    f.inputs I18n.t('activerecord.models.song.other') || 'Songs' do
      f.input :song_search, as: :string, label: I18n.t('custom_panels.search_songs'),
input_html: { id: 'song-search', placeholder: I18n.t('custom_panels.input_search_songs') }

      panel I18n.t('custom_panels.search_result_songs') do
        div id: 'search-results-container' do
          table_for [] do
            column I18n.t('activerecord.attributes.song.title')
            column I18n.t('activerecord.attributes.song.performer')
            column I18n.t('activerecord.attributes.song.song_type')
            column I18n.t('activerecord.attributes.song.key')
            column I18n.t('active_admin.add_button')
          end
        end
      end

      panel I18n.t('custom_panels.selected_songs') do
        div id: 'selected-songs-container' do
          if f.object.songs.any?
            table_for f.object.songs do
              column :title do |song|
                link_to song.title, admin_song_path(song) if song.title.present?
              end
              column :performer
              column :song_type
              column :key
              column I18n.t('active_admin.remove_button') do |song|
                button_tag '-', type: 'button', class: 'remove-song',
                  data: { song_id: song.id }
              end
            end
          else
            div { I18n.t('custom_panels.no_songs_associated') || 'No songs are associated with this event.' }
          end
        end
      end

      div id: 'hidden-song-ids', style: 'display: none;' do
        f.object.songs.each do |song|
          concat tag.input(type: 'hidden', name: 'event[song_ids][]', value: song.id)
        end
      end
    end

    f.actions
  end
end
