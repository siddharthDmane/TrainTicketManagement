<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    
    
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
            position: relative;
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
            width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            background: white;
        }

        .image-container img {
            width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
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
        
        .user-icon {
            position: absolute;
            margin-top: 3%;
            right: 10px;
            top: 50%;
            width:8%;
            transform: translateY(-50%);
            
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }

            .image-container {
                width: 100%;
                padding: 1rem;
                margin-bottom: 1rem;
            }

            .login-form-container {
                width: 100%;
            }
        }
    </style>
    <script>
    
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('adminPassword');
        const eyeIcon = document.getElementById('eyeIcon');
     
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            eyeIcon.src = "icons/openeye-icon-login.svg"; // Change to visible eye icon
        } else {
            passwordInput.type = "password";
            eyeIcon.src = "icons/eye-icon-login.svg"; // Change to hidden eye icon
        }
    }
        function validateAdminLoginForm() {
            let isValid = true;

            // Clear error messages
            document.querySelectorAll('.error-message').forEach(el => el.innerText = '');

            // Username Validation
            const username = document.getElementById("adminUsername").value.trim();
            if (username === "") {
                document.getElementById("adminUsernameError").innerText = "Username is required.";
                isValid = false;
            }

            // Password Validation
            const password = document.getElementById("adminPassword").value;
            if (password === "") {
                document.getElementById("adminPasswordError").innerText = "Password is required.";
                isValid = false;
            } else if (password.length < 6 || password.length > 12) {
                document.getElementById("adminPasswordError").innerText = "Password must be between 6 and 12 characters.";
                isValid = false;
            }

            return isValid;
        }
    </script>
</head>
<body>
    <div class="login-container">
        <div class="image-container">
            <img src="images/admin-login.jpg" alt="Admin Login">
        </div>
        <div class="login-form-container">
            <div class="login-header">
                <h1>Admin Login</h1>
<!--                 <p >Please enter your admin credentials to login</p>
 -->            </div>
            <form action="adminlogin" method="POST" onsubmit="return validateAdminLoginForm()" class="login-form">
                <input type="hidden" name="action" value="adminlogin">
                <div class="form-group">
                    <label for="adminUsername">Admin Username</label>
                                        <img src="icons/user-profile-login.svg" alt="User Icon" class="user-icon">
                    
                    <input type="text" id="adminUsername" name="username" maxlength="50">
                    <span id="adminUsernameError" class="error-message"></span>
                </div>
                <div class="form-group">
                    <label for="adminPassword">Password</label>
                                        <img src="icons/eye-icon-login.svg" alt="Eye Icon" class="eye-icon" id="eyeIcon" onclick="togglePasswordVisibility()">
                    <input type="password" id="adminPassword" name="password" minlength="6" maxlength="12">
                    <span id="adminPasswordError" class="error-message"></span>
                </div>
                <button type="submit" class="login-button">Login</button>
            </form>
            <div class="additional-options">
                <p> <a href="adminregister.jsp">Don't have an account? Register Admin here</a>.</p>
                <p> <a href="login.jsp">Are you a User? Login as User</a>.</p>
            </div>
        </div>
    </div>
</body>
</html>