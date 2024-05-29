function performRegister() {
    // Get registration details from input fields
    const nomeInput = document.getElementById('nome');
    const cognomeInput = document.getElementById('cognome');
    const data_nascitaInput = document.getElementById('data_nascita');
    const emailInput = document.getElementById('email');
    const telefono_cellulareInput = document.getElementById('telefono_cellulare');
    const usernameInput = document.getElementById('username');
    const passwordInput = document.getElementById('password');
    const conferma_passwordInput = document.getElementById('conferma_password');

    const nome = nomeInput.value.trim();
    const cognome = cognomeInput.value.trim();
    const data_nascita = data_nascitaInput.value.trim();
    const email = emailInput.value.trim();
    const telefono_cellulare = telefono_cellulareInput.value.trim();
    const username = usernameInput.value.trim();
    const password = passwordInput.value.trim();
    const conferma_password = conferma_passwordInput.value.trim();

    // Validate all fields are non-empty
    if (!nome || !cognome || !data_nascita || !email || !telefono_cellulare || !username || !password || !conferma_password) {
        alert('Compila tutti i campi obbligatori.');
        return false; // Stop if any field is empty
    }

    // Validate email format (optional)
    const emailRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
    if (!emailRegex.test(email)) {
        alert('Formato email non valido.');
        return false;
    }

    // Validate phone number format (optional)
    const phoneRegex = /^\d{10}$/; // Assuming Italian phone numbers (10 digits)
    if (!phoneRegex.test(telefono_cellulare)) {
        alert('Formato numero di telefono non valido (10 cifre).');
        return false ;
    }

    // Validate password match
    if (password !== conferma_password) {
        alert('Le password non corrispondono.');
        return false;
    }

    const dob = new Date(data_nascitaInput.value);
    const today = new Date();
    const age = today.getFullYear() - dob.getFullYear();
    const isAdult = age >= 18;

    if (!isAdult) {
        alert('Devi avere almeno 18 anni per registrarti.');
        return false; // Stop if user is not an adult
    }

    setTimeout(() => {
        alert('Registrazione avvenuta con successo!');
        // Redirect to login or other relevant page
        window.location.href = 'login.html'; // Replace with your target URL
    }, 1000); // Simulate a 1-second delay
}
