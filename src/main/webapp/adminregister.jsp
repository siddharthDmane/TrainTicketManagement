<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Register</title>
    <style>
        body {
            background: linear-gradient(120deg, #3498db, #8e44ad);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 100px auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            gap: 20px; /* Adds gap between columns */
        }

        .form-column {
            flex: 1;
            margin-right: 10px;
        }

        .form-column:last-child {
            margin-right: 0;
        }

        label {
            display: block;
            font-size: 1rem;
            color: #333;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 5px;
        }

        .error-message {
            color: red;
            font-size: 0.9em;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #3498db;
            color: white;
            font-size: 1.2rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
        }

        .text-center {
            text-align: center;
        }

        .text-center p {
            margin-top: 15px;
            font-size: 1rem;
        }

        .text-center a {
            color: #3498db;
            text-decoration: none;
        }

        .text-center a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function validateForm() {
            let isValid = true;

            const uname = document.getElementById("uname").value.trim();
            const name = document.getElementById("name").value.trim();
            const email = document.getElementById("email").value.trim();
            const password = document.getElementById("password").value.trim();
            const confirmPassword = document.getElementById("confirmPassword").value.trim();
            const phoneNo = document.getElementById("phoneNo").value.trim();

            // Clear previous error messages
            document.getElementById("unameError").textContent = "";
            document.getElementById("nameError").textContent = "";
            document.getElementById("emailError").textContent = "";
            document.getElementById("passwordError").textContent = "";
            document.getElementById("confirmPasswordError").textContent = "";
            document.getElementById("phoneNoError").textContent = "";

            if (!uname) {
                document.getElementById("unameError").textContent = "Username is required.";
                isValid = false;
            }
            if (!name) {
                document.getElementById("nameError").textContent = "Name is required.";
                isValid = false;
            }

            if (!email || !email.endsWith("@gmail.com")) {
                document.getElementById("emailError").textContent = "Email must be a valid Gmail address.";
                isValid = false;
            }

            if (password.length < 6 || password.length > 12) {
                document.getElementById("passwordError").textContent = "Password must be 6 to 12 characters long.";
                isValid = false;
            }

            if (password !== confirmPassword) {
                document.getElementById("confirmPasswordError").textContent = "Passwords do not match.";
                isValid = false;
            }

            if (phoneNo.length !== 10 || isNaN(phoneNo)) {
                document.getElementById("phoneNoError").textContent = "Phone number must be exactly 10 digits.";
                isValid = false;
            }

            return isValid;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Admin Register</h2>
        <form action="auth" method="POST" onsubmit="return validateForm();">
            <input type="hidden" name="action" value="registerAdmin">

            <!-- Row for Username and Name -->
            <div class="form-row">
                <div class="form-column">
                    <label for="uname">Username</label>
                    <input type="text" id="uname" name="uname" maxlength="40">
                    <div id="unameError" class="error-message"></div>
                </div>

                <div class="form-column">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" maxlength="40">
                    <div id="nameError" class="error-message"></div>
                </div>
            </div>

            <!-- Row for Email and Phone Number -->
            <div class="form-row">
                <div class="form-column">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" maxlength="60">
                    <div id="emailError" class="error-message"></div>
                </div>

                <div class="form-column">
                    <label for="phoneNo">Phone Number</label>
                    <input type="text" id="phoneNo" name="phoneNo" maxlength="10">
                    <div id="phoneNoError" class="error-message"></div>
                </div>
            </div>

            <!-- Row for Password and Confirm Password -->
            <div class="form-row">
                <div class="form-column">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" minlength="6" maxlength="12">
                    <div id="passwordError" class="error-message"></div>
                </div>

                <div class="form-column">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" minlength="6" maxlength="12">
                    <div id="confirmPasswordError" class="error-message"></div>
                </div>
            </div>

            <button type="submit">Register</button>
        </form>

        <div class="text-center">
            <p>Already have an account? <a href="adminlogin.jsp">Login as Admin here</a>.</p>
        </div>
    </div>
</body>
</html>
