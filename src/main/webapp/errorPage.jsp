<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Something Went Wrong</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
    <script>
        window.onload = function() {
            const message = '<%= session.getAttribute("loginMessage") != null ? session.getAttribute("loginMessage") : "" %>';
            if (message) {
                alert(message);
                <%
                    // Clear the message after alerting
                    session.removeAttribute("loginMessage");
                %>
            }
        };
    </script>
    
    <style>
        .error-container {
            margin-top: 100px;
            text-align: center;
        }
        .error-message {
            font-size: 2rem;
            font-weight: bold;
            color: #e74a3b;
        }
        .error-details {
            margin-top: 20px;
            font-size: 1.1rem;
        }
        .retry-button {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container error-container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="alert alert-danger">
                    <h4 class="error-message">Oops! Something went wrong.</h4>
                    <p class="error-details">We encountered an error while processing your request. Please try again later .</p>
                    <p >Reasons might be:</br>
                    Session expired || Wrong credential || wrong inputs || server issue</p>
                    <a href="javascript:history.back()" class="btn btn-warning retry-button">Go Back</a>
                    <a href="login.jsp" class="btn btn-primary retry-button">Go to Login Page</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
    