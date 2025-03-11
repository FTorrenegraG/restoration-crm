ActiveAdmin.register Event do
  permit_params :name, :start_datetime, :end_datetime, :location, :description, :status, song_ids: []

  filter :name
  filter :location
  filter :status, as: :select, collection: ["Planned", "Completed", "Cancelled"]
  filter :start_datetime, as: :date_range
  filter :end_datetime, as: :date_range
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  index do
    selectable_column
    column :name, sortable: true
    column :start_datetime, sortable: true do |event|
      event.start_datetime.strftime("%d-%m-%Y %H:%M")
    end
    column :end_datetime, sortable: true do |event|
      event.end_datetime.strftime("%d-%m-%Y %H:%M")
    end
    column :location, sortable: true
    column :status, sortable: true
    column "Created At", :created_at, sortable: true do |event|
      event.created_at.strftime("%d-%m-%Y")
    end
    actions
  end
  
  show do
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
  
    panel 'Songs' do
      if resource.songs.any?
        table_for resource.songs do
          column 'Title' do |song|
            link_to song.title, admin_song_path(song) # Enlaza a la vista de la canción si está disponible
          end
          column :performer
          column :song_type
          column :key
          column 'Reference Link' do |song|
            link_to 'View', song.reference_link, target: '_blank' if song.reference_link.present?
          end
          column 'Sheet Music' do |song|
            link_to 'Download', song.sheet_music, target: '_blank' if song.sheet_music.present?
          end
        end
      else
        div { "No songs are associated with this event." }
      end
    end
  end
  
  form do |f|
    f.semantic_errors *f.object.errors.attribute_names

    f.inputs 'Event Details' do
      f.input :name
      f.input :start_datetime, input_html: { class: 'datepicker' }
      f.input :end_datetime, input_html: { class: 'datepicker' }
      f.input :location
      f.input :description
      f.input :status
    end

    f.inputs 'Songs' do
      # Campo de búsqueda
      f.input :song_search, as: :string,
              label: 'Search for Songs',
              input_html: { id: 'song-search', placeholder: 'Search for a song' }

      # Dropdown dinámico (resultados de la búsqueda)
      li class: 'string input optional' do
        label 'Search Results'
        div do
          "<select id='search-results' size='5' style='width: 100%;'></select>".html_safe
        end
      end

      # Lista de canciones seleccionadas
      li class: 'string input optional' do
        label 'Selected Songs'
        ul id: 'selected-songs' do
          # Renderizar las canciones seleccionadas desde el modelo para ediciones
          f.object.songs.each do |song|
            li data: { song_id: song.id } do
              text_node "#{song.title} "
              button 'Remove', type: 'button', class: 'remove-song'
            end
          end
        end
      end

      # Botón para agregar canciones desde la búsqueda
      li class: 'string input optional' do
        button 'Add Selected Song', type: 'button', id: 'add-song', style: 'margin-top: 10px;'
      end

      # Contenedor para los inputs ocultos
      li class: 'hidden-inputs' do
        div id: 'hidden-song-ids' do
          # Generar manualmente inputs ocultos para las canciones seleccionadas
          f.object.songs.map do |song|
            "<input type='hidden' name='event[song_ids][]' value='#{song.id}'>".html_safe
          end.join.html_safe
        end
      end
      
    end

    f.actions
  end
end
