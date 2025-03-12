import { admin_song_path } from "routes";
import "jquery";
import "select2";
import "flatpickr";

document.addEventListener('DOMContentLoaded', function () {
    $('.select2').select2({
        placeholder: "Seleccione una opción",
        allowClear: true
    });

    const searchInput = document.getElementById('song-search');
    const searchResultsContainer = document.getElementById('search-results-container');
    const selectedSongsContainer = document.getElementById('selected-songs-container');
    const hiddenInputsContainer = document.getElementById('hidden-song-ids');

    if (searchInput && searchResultsContainer && selectedSongsContainer && hiddenInputsContainer) {
        const showError = (message) => {
            console.error(message);
            alert(message);
        };

        function updateHiddenInputs() {
            hiddenInputsContainer.innerHTML = '';
            Array.from(selectedSongsContainer.querySelectorAll('tbody tr')).forEach((row) => {
                const songId = row.querySelector('.remove-song').dataset.songId;
                if (songId) {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'event[song_ids][]';
                    input.value = songId;
                    hiddenInputsContainer.appendChild(input);
                }
            });
        }

        searchInput.addEventListener('input', function () {
            const searchTerm = searchInput.value.trim();
            const table = searchResultsContainer.querySelector('table');
            const tbody = table.querySelector('tbody');
            if (searchTerm.length >= 3) {
                fetch(`/songs?q=${encodeURIComponent(searchTerm)}`)
                    .then((response) => response.json())
                    .then((data) => {
                      tbody.innerHTML = '';
                      data.forEach((song) => {
                          const row = document.createElement('tr');
                          row.innerHTML = `
                              <td><a href="${admin_song_path(song.id)}" target="_blank">${song.title}</a></td>
                              <td>${song.performer}</td>
                              <td>${song.song_type}</td>
                              <td>${song.key}</td>
                              <td><button class="add-song" data-song-id="${song.id}">+</button></td>
                          `;
                          tbody.appendChild(row);
                      });
                  })
                  .catch(() => showError('Error al buscar canciones.'));
            } else {
              tbody.innerHTML = '';
            }
        });

        searchResultsContainer.addEventListener('click', function (event) {
          if (event.target.classList.contains('add-song')) {
              event.preventDefault();
              const songId = event.target.dataset.songId;
              const songTitle = event.target.closest('tr').children[0].innerText;
              const songPerformer = event.target.closest('tr').children[1].innerText;
              const songType = event.target.closest('tr').children[2].innerText;
              const songKey = event.target.closest('tr').children[3].innerText;
      
              const alreadySelected = Array.from(selectedSongsContainer.querySelectorAll('tbody tr')).some(
                  (row) => row.querySelector('.remove-song').dataset.songId === songId
              );
      
              if (alreadySelected) {
                  showError('Esta canción ya está seleccionada.');
                  return;
              }
      
              const selectedTbody = selectedSongsContainer.querySelector('tbody');
              const row = document.createElement('tr');
              row.innerHTML = `
                  <td><a href="${admin_song_path(songId)}" target="_blank">${songTitle}</a></td>
                  <td>${songPerformer}</td>
                  <td>${songType}</td>
                  <td>${songKey}</td>
                  
                  <td><button class="remove-song" data-song-id="${songId}">-</button></td>
              `;
      
              selectedTbody.appendChild(row);
              updateHiddenInputs();
          }
        });
      

        selectedSongsContainer.addEventListener('click', function (event) {
            if (event.target.classList.contains('remove-song')) {
                event.preventDefault();
                event.target.closest('tr').remove();
                updateHiddenInputs();
            }
        });

        updateHiddenInputs();

        flatpickr(".datepicker", {
            enableTime: true,
            dateFormat: "d-m-Y H:i",
        });
    } else {
        console.warn('Algunos elementos del DOM no están presentes.');
    }
});
