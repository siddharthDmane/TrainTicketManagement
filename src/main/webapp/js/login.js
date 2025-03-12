
function validateLoginForm() {
	let isValid = true;

	// Clear error messages
	document.querySelectorAll('.error-message').forEach(el => el.innerText = '');

	// Username Validation
	const username = document.getElementById("username").value.trim();
	if (username === "") {
		document.getElementById("usernameError").innerText = "Username is required.";
		isValid = false;
	}

	// Password Validation
	const password = document.getElementById("password").value;
	if (password === "") {
		document.getElementById("passwordError").innerText = "Password is required.";
		isValid = false;
	} else if (password.length < 6) {
		document.getElementById("passwordError").innerText = "Password must be greater than 6 characters.";
		isValid = false;
	}
	
	
	

	return isValid;
}
