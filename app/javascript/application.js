document.addEventListener('DOMContentLoaded', function () {
  // Elementos clave del DOM
  const searchInput = document.getElementById('song-search');
  const searchResults = document.getElementById('search-results');
  const addButton = document.getElementById('add-song');
  const selectedSongsList = document.getElementById('selected-songs');
  const hiddenInputsContainer = document.getElementById('hidden-song-ids');

  if (!searchInput || !searchResults || !addButton || !selectedSongsList || !hiddenInputsContainer) {
    return; // Salir si falta algún elemento clave
  }

  // Función para mostrar errores
  const showError = (message) => {
    console.error(message);
    // Puedes implementar un mensaje visual si es necesario
  };

  // Función para actualizar los inputs ocultos
  function updateHiddenInputs() {
    // Limpiar los inputs existentes
    hiddenInputsContainer.innerHTML = '';

    // Crear nuevos inputs ocultos con los IDs de las canciones seleccionadas
    Array.from(selectedSongsList.children).forEach((li) => {
      const songId = li.dataset.song_id;

      if (songId) {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'event[song_ids][]'; // Nombre esperado por el servidor
        input.value = songId;
        hiddenInputsContainer.appendChild(input);
      }
    });
  }

  // Buscar canciones
  searchInput.addEventListener('input', function () {
    const searchTerm = searchInput.value.trim();

    if (searchTerm.length >= 3) {
      fetch(`/songs?q=${encodeURIComponent(searchTerm)}`)
        .then((response) => response.json())
        .then((data) => {
          searchResults.innerHTML = ''; // Limpiar resultados previos

          data.forEach((song) => {
            const option = document.createElement('option');
            option.value = song.id;
            option.text = song.title;
            searchResults.appendChild(option);
          });
        })
        .catch(() => showError('Error fetching songs.'));
    } else {
      searchResults.innerHTML = ''; // Limpiar la búsqueda si es corta
    }
  });

  // Añadir canción seleccionada
  addButton.addEventListener('click', function () {
    const selectedOption = searchResults.options[searchResults.selectedIndex];
    if (!selectedOption) {
      showError('Please select a song.');
      return;
    }

    const songId = selectedOption.value;
    const songTitle = selectedOption.text;

    // Verificar si ya está seleccionada
    const alreadySelected = Array.from(selectedSongsList.children).some(
      (li) => li.dataset.song_id === songId
    );
    if (alreadySelected) {
      showError('This song is already selected.');
      return;
    }

    // Crear un nuevo elemento en la lista de seleccionadas
    const li = document.createElement('li');
    li.dataset.song_id = songId;
    li.textContent = `${songTitle} `;

    const removeButton = document.createElement('button');
    removeButton.textContent = 'Remove';
    removeButton.type = 'button';
    removeButton.classList.add('remove-song');
    li.appendChild(removeButton);

    selectedSongsList.appendChild(li);

    // Manejar eliminación del botón "Remove"
    removeButton.addEventListener('click', function () {
      li.remove();
      updateHiddenInputs();
    });

    // Actualizar inputs ocultos
    updateHiddenInputs();
  });

  // Inicializar los botones "Remove" al cargar la página
  selectedSongsList.querySelectorAll('.remove-song').forEach((button) => {
    button.addEventListener('click', function () {
      button.parentElement.remove();
      updateHiddenInputs();
    });
  });

  // Actualizar inputs ocultos al cargar la página
  updateHiddenInputs();
});
document.addEventListener('DOMContentLoaded', function () {
  flatpickr(".datepicker", {
    enableTime: true,
    dateFormat: "d-m-Y H:i",
  });
});
