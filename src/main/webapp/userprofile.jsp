<%@ page import="com.model.Customer"%>
<%
Customer customer = (Customer) request.getAttribute("customer");
if (customer == null) {
	response.sendRedirect("login.jsp");
	return;
}
String error = (String) request.getAttribute("error");
String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile</title>
<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background-color: #e0f1f8; /* Lighter soothing background */
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh; /* Full height */
	background: linear-gradient(120deg, #d8c4b6, #f5efe7);
	/* Softer gradient */
	animation: fadeIn 0.5s; /* Page load animation */
}

/* @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        } */
.navbar {
	background-color: #004b87; /* Tata Blue */
	color: green;
	padding: 0px;
	text-align: center;
	width: 100%;
	position: fixed;
	left: 0;
	top: 0;
}

.header {
	background-color: #004b87; /* Tata Blue */
	color: white;
	text-align: center;
	padding: 20px;
	margin-top: 0px; /* Space for navbar */
}

.form-container {
	max-width: 1200px;
	margin: 0px auto;
	/* max-width: 900px; */ /* Wider form container */
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	padding: 40px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
}

form {
	width: 100%;
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 25px;
	margin-top: 20px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

label {
	margin-bottom: 8px;
	font-size: 1.1em;
	font-weight: bold;
	color: #333;
}

input {
	padding: 12px;
	font-size: 1em;
	border: 1px solid #ccc;
	border-radius: 6px;
	box-sizing: border-box;
	margin-top: 6px;
	transition: all 0.3s ease;
}

input:focus {
	border-color: #004b87; /* Focus effect with Tata Blue */
	box-shadow: 0 0 8px rgba(0, 75, 135, 0.2);
}

.error-message {
	color: red;
	font-size: 0.9em;
	margin-top: 5px;
}

.button-container {
	display: flex;
	justify-content: space-between;
	grid-column: span 2;
	margin-top: 25px;
}

button {
	padding: 12px 25px;
	font-size: 1em;
	border-radius: 6px;
	cursor: pointer;
	width: 48%;
	transition: all 0.3s ease;
}

.submit-button {
	background: #213555; /* Tata Blue */
	color: white;
	border: none;
}

.submit-button:hover {
	background-color: #003c72;
}

.back-button {
	background-color: #d9534f; /* Red button */
	color: white;
	border: none;
}

.back-button:hover {
	background-color: #c9302c;
}

.alert {
	margin: 10px 0;
	padding: 15px;
	border-radius: 6px;
	width: 100%;
	max-width: 900px;
	opacity: 0;
	transition: opacity 0.5s ease;
	transform: translateY(-10px);
}

.alert-danger {
	background-color: #f8d7da;
	color: #721c24;
}

.alert-success {
	background-color: #d4edda;
	color: #155724;
}

.loading {
	display: none;
	text-align: center;
	margin: 20px 0;
	font-size: 1.2em;
	color: #004b87;
	animation: loadingAnimation 1s infinite;
}

/* @keyframes loadingAnimation {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        } */
.fade-in {
	opacity: 1;
	transform: translateY(0);
}
</style>
<%-- <script>
        // JavaScript for client-side validation
        function validateForm() {
            let isValid = true;

            // Username Validation
            const username = document.getElementById("username");
            const usernameError = document.getElementById("usernameError");
            if (username.value.trim() === "") {
                usernameError.textContent = "Username is required.";
                isValid = false;
            } else {
                usernameError.textContent = "";
            }

            // Email Validation
            const email = document.getElementById("email");
            const emailError = document.getElementById("emailError");
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email.value)) {
                emailError.textContent = "Please enter a valid email address.";
                isValid = false;
            } else {
                emailError.textContent = "";
            }

            // Phone Validation
            const phone = document.getElementById("phone");
            const phoneError = document.getElementById("phoneError");
            const phonePattern = /^[0-9]{10}$/;
            if (!phonePattern.test(phone.value)) {
                phoneError.textContent = "Phone number must be 10 digits.";
                isValid = false;
            } else {
                phoneError.textContent = "";
            }

            // Address Validation
            const address = document.getElementById("address");
            const addressError = document.getElementById("addressError");
            if (address.value.trim() === "") {
                addressError.textContent = "Address is required.";
                isValid = false;
            } else {
                addressError.textContent = "";
            }

            // Aadhar Validation
            const aadhar = document.getElementById("aadhar");
            const aadharError = document.getElementById("aadharError");
            const aadharPattern = /^[0-9]{12}$/;
            if (!aadharPattern.test(aadhar.value)) {
                aadharError.textContent = "Aadhar number must be 12 digits.";
                isValid = false;
            } else {
                aadharError.textContent = "";
            }

            // Password Validation
            const oldPassword = document.getElementById("oldPassword");
            const passwordError = document.getElementById("passwordError");
            if (oldPassword.value.trim() === "") {
                passwordError.textContent = "Password is required.";
                isValid = false;
            } else {
                passwordError.textContent = "";
            }

            if (isValid) {
                // Show loading animation
                document.getElementById("loading").style.display = "block";
            }

            return isValid;
        }

        // Show success message with fade-in effect
        function showSuccessMessage() {
            const successMessage = document.getElementById("successMessage");
            successMessage.classList.add("fade-in");
        }

        window.onload = function() {
            const successMessage = "<%=success != null ? success : ""%>
	";
		if (successMessage.trim() !== "") {
			const msgElement = document.getElementById("successMessage");
			if (msgElement) {
				msgElement.classList.add("fade-in");
				msgElement.style.opacity = 1; // Show success message
			}
		}
	};
</script> --%>

<script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            if (message) {
                alert(message);
            }
        };
    </script>
</head>
<body>
	<div class="form-container">
		<jsp:include page="userNavigation.jsp" />
		<h2>User Profile</h2>
		<div id="loading" class="loading">Updating...</div>
		<form action="userprofile" method="POST"
			onsubmit="return validateForm()">
			
			
			<div class="form-group">
				<label for="username">Username</label> <input type="text"
					id="username" name="username" value="<%=customer.getUserName()%>"
					maxlength="50" required>
				<div id="usernameError" class="error-message"></div>
			</div>

			<div class="form-group">
				<label for="email">Email</label> <input type="email" id="email"
					name="email" value="<%=customer.getEmail()%>" maxlength="100"
					required>
				<div id="emailError" class="error-message"></div>
			</div>

			<div class="form-group">
				<label for="phone">Phone</label> <input type="text" id="phone"
					name="phone" value="<%=customer.getContactNumber()%>"
					maxlength="10" required>
				<div id="phoneError" class="error-message"></div>
			</div>

			<div class="form-group">
				<label for="address">Address</label> <input type="text" id="address"
					name="address" value="<%=customer.getAddress()%>" maxlength="255"
					required>
				<div id="addressError" class="error-message"></div>
			</div>

			<div class="form-group">
				<label for="aadhar">Aadhar</label> <input type="text" id="aadhar"
					name="aadhar" value="<%=customer.getAadharNumber()%>"
					maxlength="12" required>
				<div id="aadharError" class="error-message"></div>
			</div>

			<div class="form-group">
				<label for="oldPassword">Current Password</label> <input
					type="password" id="oldPassword" name="oldPassword" required>
				<div id="passwordError" class="error-message"></div>
			</div>

			<div class="button-container">
				<button type="button" class="back-button" onclick="goBack()">Back</button>
				<button type="submit" class="submit-button">Update Profile</button>


			</div>
		</form>
		<form action="DeactivateUserServlet" method="post"
			onsubmit="return confirmDeactivation();">
			<button type="submit" class="deactivate-button">Deactivate
				Account</button>
		</form>
	</div>
	<script>
		function confirmDeactivation() {
			return confirm("Are you sure you want to deactivate your account? After deactivation, all your bookings will be lost.");
		}
	</script>
	<script>
		function goBack() {
			window.history.back(); // Go to the previous page
		}
	</script>
	
	<script>
	
	function validateForm() {
	    let isValid = true;

	    // Clear previous error messages
	    const errorFields = ["usernameError", "emailError", "phoneError", "addressError", "aadharError", "passwordError"];
	    errorFields.forEach(field => {
	        document.getElementById(field).textContent = "";
	    });

	    // Username validation
	    const username = document.getElementById("username");
	    const usernameError = document.getElementById("usernameError");
	    if (username.value.trim().length < 5) {
	        usernameError.textContent = "Username must contain at least 5 characters.";
	        isValid = false;
	    } else if (!/^[a-zA-Z]+$/.test(username.value.trim())) {
	        usernameError.textContent = "Username must contain only letters.";
	        isValid = false;
	    }

	    // Email validation
	    const email = document.getElementById("email");
	    const emailError = document.getElementById("emailError");
	    const emailPattern = /^[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com)$/;
	    if (!emailPattern.test(email.value.trim())) {
	        emailError.textContent = "Email must end with 'gmail.com' or 'hotmail.com'.";
	        isValid = false;
	    }

	    // Phone number validation
	    const phone = document.getElementById("phone");
	    const phoneError = document.getElementById("phoneError");
	    const phonePattern = /^[6-9]\d{9}$/;
	    const consecutiveRegex = /(\d)\1{4,}/;
	    if (!phonePattern.test(phone.value.trim())) {
	        phoneError.textContent = "Phone number must be 10 digits and start with digits 6 to 9.";
	        isValid = false;
	    }
	    else if (consecutiveRegex.test(phone)) {
	    	phoneError.textContent = "Phone number cannot contain more than 4 consecutive identical digits.";
            isValid = false;
        }

	    // Aadhar number validation
	    const aadhar = document.getElementById("aadhar");
	    const aadharError = document.getElementById("aadharError");
	    const aadharPattern = /^\d{12}$/;
	    if (!aadharPattern.test(aadhar.value.trim())) {
	        aadharError.textContent = "Aadhar number must be exactly 12 digits.";
	        isValid = false;
	    }

	    // Address validation
	    const address = document.getElementById("address");
	    const addressError = document.getElementById("addressError");
	    if (address.value.trim().length < 10 || address.value.trim().length > 100) {
	        addressError.textContent = "Address must be between 10 and 100 characters.";
	        isValid = false;
	    }

	    // Password validation (if required)
	    const oldPassword = document.getElementById("oldPassword");
	    const passwordError = document.getElementById("passwordError");
	    if (oldPassword.value.trim() === "") {
	        passwordError.textContent = "Password is required.";
	        isValid = false;
	    }

	    if (isValid) {
	        alert("Form submitted successfully!");
	    } else {
	        alert("Please correct the highlighted errors and try again.");
	    }

	    return isValid;
	}

	
	</script>

</body>
</html>
