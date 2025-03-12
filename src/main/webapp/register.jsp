<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background: #213555;
	color: #f5efe7;
}

.register-container {
	display: flex;
	background: white;
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	width: 80%;
	max-width: 1200px;
	overflow: hidden;
}

.register-form-container {
	background: #d8c4b6;
	padding: 2rem;
	width: 50%;
}

.register-header {
	text-align: center;
	margin-bottom: 2rem;
}

.register-header h2 {
	color: #3e5879;
	font-size: 2rem;
}

form {
	display: grid;
	gap: 1.5rem;
}

.form-row {
	display: flex;
	justify-content: space-between;
	gap: 1rem;
}

.form-group {
	flex: 1;
	display: flex;
	flex-direction: column;
}

label {
	margin-bottom: 0.5rem;
	font-weight: bold;
	color: #3e5879;
}

input, textarea {
	padding: 0.8rem;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 1rem;
}

textarea {
	resize: none;
}

.error-message {
	color: #e74c3c;
	font-size: 0.9rem;
	margin-top: 5px;
}

.btn-register {
	background: #213555;
	color: white;
	padding: 0.8rem;
	border: none;
	border-radius: 5px;
	font-size: 1rem;
	font-weight: 600;
	cursor: pointer;
	transition: background 0.3s ease;
	width: 100%;
}

.btn-register:hover {
	background: #3e5879;
}

.text-center {
	text-align: center;
}

.text-center p {
	color: #2c3e50;
}

.text-center a {
	text-decoration: none;
	color: #2980b9;
	font-weight: bold;
	transition: color 0.3s ease;
}

.text-center a:hover {
	color: #3498db;
}

.image-container {
	width: 45%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	background-color: #ffffff;
	text-align: center;
	padding: 1rem;
}

.image-container h1 {
	font-size: 2rem;
	color: #3e5879;
	margin-bottom: 1rem;
}

.image-container img {
	max-width: 90%;
	max-height: 90%;
	object-fit: contain;
}

@media ( max-width : 768px) {
	.register-container {
		flex-direction: column;
	}
	.image-container {
		width: 100%;
		height: auto;
	}
	.register-form-container {
		width: 100%;
	}
	
}
</style>
</head>
<body>
	<div class="register-container">
		<div class="register-form-container">
			<div class="register-header">
				<h2>CUSTOMER REGISTRATION</h2>
			</div>
			<form action="auth" method="POST" onsubmit="return validateForm()" novalidate>
				<input type="hidden" name="action" value="register">
				<div class="form-row">
					<div class="form-group">
						<label for="userName">User Name</label> 
						<input type="text" id="userName" name="userName" maxlength="50" required>
						<div id="userNameError" class="error-message"></div>
					</div>
					<div class="form-group">
						<label for="email">Emails</label> 
						<input type="email" id="email" name="email" maxlength="100" required>
						<div id="emailError" class="error-message"></div>
					</div>
				</div>
				<div class="form-row">
					<div class="form-group">
						<label for="password">Password</label> 
						<input type="password" id="password" name="password" minlength="6" maxlength="12" required>
						<div id="passwordError" class="error-message"></div>
					</div>
					<div class="form-group">
						<label for="confirmPassword">Confirm Password</label> 
						<input type="password" id="confirmPassword" name="confirmPassword" minlength="6" maxlength="12" required>
						<div id="confirmPasswordError" class="error-message"></div>
					</div>
				</div>
				<div class="form-row">
					<div class="form-group">
						<label for="contactNumber">Contact Number</label> 
						<input type="text" id="contactNumber" name="contactNumber" maxlength="10" required>
						<div id="contactNumberError" class="error-message"></div>
					</div>
					<div class="form-group">
						<label for="aadharNumber">Aadhar Number</label> 
						<input type="text" id="aadharNumber" name="aadharNumber" maxlength="12" required>
						<div id="aadharNumberError" class="error-message"></div>
					</div>
				</div>
				<div class="form-group">
					<label for="address">Address</label>
					<textarea id="address" name="address" maxlength="100" required></textarea>
					<div id="addressError" class="error-message"></div>
				</div>
				<button type="submit" class="btn-register">Register</button>
			</form>
			<div class="text-center mt-3">
				<p>
					Already have an account? <a href="login.jsp">Login as User here</a>.
				</p>
				<p>
					Are you an Admin? <a href="adminlogin.jsp">Login as Admin</a>.
				</p>
			</div>
		</div>
		<div class="image-container">
			<h1>TATA RAILWAYS</h1>
			<img alt="ticket" src="images/ticket-login.png">
		</div>
	</div>
	
	<script>
    function validateForm() {
        let isValid = true;

        const uname = document.getElementById("userName").value.trim();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();
        const confirmPassword = document.getElementById("confirmPassword").value.trim();
        const phoneNo = document.getElementById("contactNumber").value.trim();
        const aadharNo = document.getElementById("aadharNumber").value.trim();
        const address = document.getElementById("address").value.trim();

        // Clear previous error messages
        document.getElementById("userNameError").textContent = "";
        document.getElementById("emailError").textContent = "";
        document.getElementById("passwordError").textContent = "";
        document.getElementById("confirmPasswordError").textContent = "";
        document.getElementById("contactNumberError").textContent = "";
        document.getElementById("aadharNumberError").textContent = "";
        document.getElementById("addressError").textContent = "";

        // Username validation
        const usernameRegex = /^[a-zA-Z]+$/; 
        if (uname.length < 5) {
            document.getElementById("userNameError").textContent = "Username must contain at least 5 letters.";
            isValid = false;
        } else if (!usernameRegex.test(uname)) {
            document.getElementById("userNameError").textContent = "Username must contain only letters.";
            isValid = false;
        }

        // Email validation
        const emailRegex = /^[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com)$/;
        if (!emailRegex.test(email)) {
            document.getElementById("emailError").textContent = "Email must end with 'gmail.com' or 'hotmail.com'.";
            isValid = false;
        }

        // Password validation
        const minlen = /.{8,}/;
        const specialchar = /[!@#$%^&*(),.?":{}|<>]/;
        const num = /\d/;
        const uppercase = /[A-Z]/;
        const lowercase = /[a-z]/;
        if (!minlen.test(password)) {
            document.getElementById("passwordError").textContent = "Password must be at least 8 characters.";
            isValid = false;
        } 
        else if (!specialchar.test(password)) {
            document.getElementById("passwordError").textContent = "Password must include at least 1 special character.";
            isValid = false;
        } else if (!num.test(password)) {
            document.getElementById("passwordError").textContent = "Password must include at least 1 number.";
            isValid = false;
        } else if (!uppercase.test(password)) {
            document.getElementById("passwordError").textContent = "Password must include at least 1 uppercase letter.";
            isValid = false;
        }
        else if (!lowercase.test(password)) {
            document.getElementById("passwordError").textContent = "Password must include at least 1 lowercase letter.";
            isValid = false;
        }

        // Confirm password validation
        if (password !== confirmPassword) {
            document.getElementById("confirmPasswordError").textContent = "Passwords do not match.";
            isValid = false;
        }

        // Phone number validation
        const phoneRegex = /^[6-9]\d{9}$/;
        const consecutiveRegex = /(\d)\1{4,}/;
        if (!phoneRegex.test(phoneNo)) {
            document.getElementById("contactNumberError").textContent = "Phone number must be 10 digits and start with digits 6 to 9.";
            isValid = false;
        } else if (consecutiveRegex.test(phoneNo)) {
            document.getElementById("contactNumberError").textContent = "Phone number cannot contain more than 4 consecutive identical digits.";
            isValid = false;
        }

        // Aadhar number validation
        const aadharRegex = /^\d{12}$/;
        if (!aadharRegex.test(aadharNo)) {
            document.getElementById("aadharNumberError").textContent = "Aadhar number must be exactly 12 digits.";
            isValid = false;
        }

        // Address validation
        const addressRegex = /^[a-zA-Z0-9\s,.\-]+$/;
        if (address.length < 10 || address.length > 100) {
            document.getElementById("addressError").textContent = "Address must be between 10 and 100 characters.";
            isValid = false;
        } else if (!addressRegex.test(address)) {
            document.getElementById("addressError").textContent = "Address can only contain letters, numbers, commas, periods, spaces, and hyphens.";
            isValid = false;
        }

        if (isValid) {
            alert("Registration Successful!");
        }

        return isValid;
    }
    
	</script>
</body>

</html>