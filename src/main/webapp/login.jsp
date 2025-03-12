<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            if (message) {
                alert(message);
            }
        };
    </script>
    
    
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

        .login-container {
            display: flex;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 1200px;
            overflow: hidden;
        }

        .login-form-container {
            background: #d8c4b6;
            padding: 2rem;
            width: 50%;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h1 {
            color: #3e5879;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            position: relative; /* For positioning icons */
        }

        .form-group label {
            color: #3e5879;
            font-weight: 600;
        }

        .form-group input {
            padding: 0.8rem;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #213555;
        }

        .error-message {
            color: #e74c3c;
            font-size: 0.9rem;
            display: none;
        }

        .login-button {
            background: #213555;
            color: white;
            padding: 1rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .login-button:hover {
            background: #3e5879;
        }

        .additional-options {
            margin-top: 1.5rem;
            text-align: center;
        }

        .additional-options a {
            color: #213555;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .additional-options a:hover {
            text-decoration: underline;
        }

        .image-container {
            margin-top: 8%;
            width: 50%;
            background-image: url('path/to/your/railway-engine-image.jpg');
            background-size: cover;
            background-position: center;
        }

        
        
        .user-icon {
            position: absolute;
            margin-top: 3%;
            right: 10px;
            top: 50%;
            width:8%;
            transform: translateY(-50%);
            
        }

        .eye-icon {
            position: absolute;
            margin-top: 3%;
            right: 10px;
            top: 50%;
            width:8%;
            transform: translateY(-50%);
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            .image-container {
                width: 100%;
                height: 200px;
            }
            .login-form-container {
                width: 100%;
            }
        }
    </style>
    <script>
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const eyeIcon = document.getElementById('eyeIcon');
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            eyeIcon.src = "icons/openeye-icon-login.svg"; // Change to visible eye icon
        } else {
            passwordInput.type = "password";
            eyeIcon.src = "icons/eye-icon-login.svg"; // Change to hidden eye icon
        }
    }

        /* function validateLoginForm() {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const usernameError = document.getElementById('usernameError');
            const passwordError = document.getElementById('passwordError');

            // Clear previous error messages
            usernameError.style.display = 'none';
            passwordError.style.display = 'none';

            // Username validation: Only letters allowed
            const usernameRegex = /^[a-zA-Z]+$/;
            if (!usernameRegex.test(username)) {
                usernameError.innerText = 'Username must contain only letters.';
                usernameError.style.display = 'block';
                return false;
            }

            // Password validation
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;
            if (!passwordRegex.test(password)) {
                passwordError.innerText = 'Password must be at least 6 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character.';
                passwordError.style.display = 'block';
                return false;
            }

            // Simulate a successful login for demonstration
            /* alert('Login successful!'); */
            /* return true;  */// Proceed with form submission
        /*} */
    </script>
</head>
<body>
    <div class="login-container">
        <div class="login-form-container">
            <div class="login-header">
                <h1>TATA RAILWAYS</h1>
<!--                 <p>Please enter your credentials to login</p>
 -->            </div>
            <form action="userlogin" method="POST" onsubmit="return validateLoginForm()" class="login-form" id="loginForm">
                <div class="form-group">
                    <label for="username">Username</label>
                    <img src="icons/user-profile-login.svg" alt="User Icon" class="user-icon">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter your user name" maxlength="50">
                    <span id="usernameError" class="error-message"></span>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <img src="icons/eye-icon-login.svg" alt="Eye Icon" class="eye-icon" id="eyeIcon" onclick="togglePasswordVisibility()">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" minlength="6" maxlength="12">
                    <span id="passwordError" class="error-message"></span>
                </div>
                <button type="submit" class="login-button">Login</button>
            </form>
            <div class="additional-options">
                <!-- <a href="#" onclick="alert('Password reset functionality would go here')">Forgot Password?</a> <br> -->
                <br> <a href="register.jsp">Don't have an account?  Sign Up</a>
            </div>
        </div>
        <div class="image-container">
            <img alt="railicon" src="images/ticket-railway.png">
        </div>
    </div>
</body>
</html>