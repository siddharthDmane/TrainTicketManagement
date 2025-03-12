<%-- <%@ page import="java.util.List"%>
<%@ page import="com.model.Station"%>
<%@ page import="com.model.Admin"%>
<%@ page import="java.util.*"%>

<%
Admin admin = (Admin) session.getAttribute("admincred");
if (admin == null) {
	response.sendRedirect("adminlogin.jsp");
	return;
}
List<Station> stationList = (List<Station>) request.getAttribute("stationList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Train</title>
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body, html {
            height: 100%;
            overflow: hidden; /* Prevent scrolling */
        }

        body {
            background: linear-gradient(120deg, #004b87, #00669D); /* Tata Blue gradient */
            font-family: Arial, sans-serif;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden; /* Ensure no overflow */
            max-height: 100%; /* Prevent scrolling */
            width: 100%; /* Ensure it takes the available width */
        }

        /* Header Section */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #004b87; /* Tata Blue */
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2.5rem;
            margin: 0;
        }

        .header img {
            max-width: 80px;
            height: auto;
        }

        /* Heading */
        h2, h3 {
            color: #333;
            font-size: 1.6rem;
            margin-bottom: 20px;
        }

        /* Form Styling */
        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #333;
        }

        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
            background-color: #f9f9f9;
        }

        input[type="text"]:focus, input[type="number"]:focus, select:focus {
            border-color: #3498db;
            outline: none;
        }

        select {
            background-color: #fff;
        }

        .btn-primary {
            background-color: #3498db; /* Tata Blue */
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 1.1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        .btn-primary:active {
            background-color: #1d6ea1;
            transform: translateY(1px);
        }

        /* Error Message Styling */
        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-top: 5px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .header h1 {
                font-size: 1.8rem;
            }

            .form-group {
                margin-bottom: 15px;
            }
        }
    </style>

   <script>
	function validateForm() {
		const trainName = document.getElementById("trainName").value.trim();
		const fromStation = document.getElementById("fromStation").value;
		const toStation = document.getElementById("toStation").value;
		const availableSeats = document.getElementById("availableSeats").value
				.trim();
		const fare = document.getElementById("fare").value.trim();

		if (trainName === "") {
			alert("Train Name cannot be empty.");
			return false;
		}
		if (fromStation === "") {
			alert("Please select a From Station.");
			return false;
		}
		if (toStation === "") {
			alert("Please select a To Station.");
			return false;
		}
		if (fromStation === toStation) {
			alert("From Station and To Station cannot be the same.");
			return false;
		}
		if (isNaN(availableSeats) || availableSeats <= 0) {
			alert("Available Seats must be a positive number.");
			return false;
		}
		if (isNaN(fare) || fare <= 0) {
			alert("Fare must be a positive number.");
			return false;
		}
		alert("Train added successfully!");
		return true;
	}
</script>
</head>

<body>

    <div class="container">
        <!-- Header Section -->
        <div class="header">
            <img src="icons/booked-train.svg" alt="Train Icon">
            <div class="text-container">
            				<p></p>
				<!-- <h1><%=admin.getUname()%>!
				</h1> -->
            
                <h1>Add Train</h1>
            </div>
            <img src="icons/booked-island.svg" alt="Island Icon">
        </div>
<!-- <h2>
			Welcome,
			<%=admin.getName()%>!
		</h2> -->
        <!-- Include Navigation -->
        <jsp:include page="adminNavigation.jsp" />

        <form action="addTrainPage" method="POST" onsubmit="return validateForm();">
            <!-- Train Name -->
            <div class="form-group">
                <label for="trainName">Train Name</label>
                <input type="text" id="trainName" name="trainName" required>
            </div>

            <!-- From and To Stations -->
<div class="form-group" style="display: flex; gap: 20px;">
    <div style="flex: 1;">
        <label for="fromStation">From Station</label>
        <select id="fromStation" name="fromStation" required>
            <option value="">Select a Station</option>
            <%
            for (Station station : stationList) {
            %>
            <option value="<%=station.getStationName()%>"><%=station.getStationName()%></option>
            <%
            }
            %>
        </select>
    </div>
    <div style="flex: 1;">
        <label for="toStation">To Station</label>
        <select id="toStation" name="toStation" required>
            <option value="">Select a Station</option>
            <%
            for (Station station : stationList) {
            %>
            <option value="<%=station.getStationName()%>"><%=station.getStationName()%></option>
            <%
            }
            %>
        </select>
    </div>
</div>


            <!-- Available Seats -->
            <div class="form-group">
                <label for="availableSeats">Available Seats</label>
                <input type="number" id="availableSeats" name="availableSeats" required>
            </div>

            <!-- Fare -->
            <div class="form-group">
                <label for="fare">Fare</label>
                <input type="number" id="fare" name="fare" required>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-primary">Add Train</button>
        </form>
    </div>

</body>
</html>
 --%>
 
 <%@ page import="java.util.List" %>
<%@ page import="com.model.Station" %>
<%@ page import="com.model.Admin" %>
<%@ page import="java.util.*" %>

<%
Admin admin = (Admin) session.getAttribute("admincred");
if (admin == null) {
    response.sendRedirect("adminlogin.jsp");
    return;
}
List<Station> stationList = (List<Station>) request.getAttribute("stationList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Train</title>
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body, html {
            height: 100%;
            overflow: hidden;
        }

        body {
            background: linear-gradient(120deg, #d8c4b6, #f5efe7);
            font-family: Arial, sans-serif;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #004b87;
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2.5rem;
            margin: 0;
        }

        .header img {
            max-width: 80px;
            height: auto;
        }

        h2, h3 {
            color: #333;
            font-size: 1.6rem;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            margin-top: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #333;
        }

        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
            background-color: #f9f9f9;
        }

        input[type="text"]:focus, input[type="number"]:focus, select:focus {
            border-color: #3498db;
            outline: none;
        }

        select {
            background-color: #fff;
        }

        .btn-primary {
            background-color: #004b87;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 1.1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        .btn-primary:active {
            background-color: #1d6ea1;
            transform: translateY(1px);
        }

        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .header h1 {
                font-size: 1.8rem;
            }

            .form-group {
                margin-bottom: 15px;
            }
        }
    </style>
    <script>
        function validateForm() {
            const trainName = document.getElementById("trainName").value.trim();
            const fromStation = document.getElementById("fromStation").value;
            const toStation = document.getElementById("toStation").value;
            const availableSeats = document.getElementById("availableSeats").value.trim();
            const fare = document.getElementById("fare").value.trim();

            if (trainName === "") {
                alert("Train Name cannot be empty.");
                return false;
            }
            if (fromStation === "") {
                alert("Please select a From Station.");
                return false;
            }
            if (toStation === "") {
                alert("Please select a To Station.");
                return false;
            }
            if (fromStation === toStation) {
                alert("From Station and To Station cannot be the same.");
                return false;
            }
            if (isNaN(availableSeats) || availableSeats <= 0) {
                alert("Available Seats must be a positive number.");
                return false;
            }
            if (isNaN(fare) || fare <= 0) {
                alert("Fare must be a positive number.");
                return false;
            }
            alert("Train added successfully!");
            return true;
        }

        function autofillExample() {
            document.getElementById("trainName").value = "Express Train";
            document.getElementById("fromStation").value = "Mumbai";
            document.getElementById("toStation").value = "Delhi";
            document.getElementById("availableSeats").value = 150;
            document.getElementById("fare").value = 1000;
        }

        window.onload = () => {
            document.getElementById("autofillButton").addEventListener("click", autofillExample);
        };
    </script>
</head>

<body>
    <div class="container">
        <div class="header">
            <img src="icons/booked-train.svg" alt="Train Icon">
            <div class="text-container">
                <h1>Add Train</h1>
            </div>
            <img src="icons/booked-island.svg" alt="Island Icon">
        </div>
        <jsp:include page="adminNavigation.jsp" />

        <form action="addTrainPage" method="POST" onsubmit="return validateForm();">
            <div class="form-group">
                <label for="trainName">Train Name</label>
                <input type="text" id="trainName" name="trainName" required>
            </div>

            <div class="form-group" style="display: flex; gap: 20px;">
                <div style="flex: 1;">
                    <label for="fromStation">From Station</label>
                    <select id="fromStation" name="fromStation" required>
                        <option value="">Select a Station</option>
                        <% for (Station station : stationList) { %>
                        <option value="<%=station.getStationName()%>"><%=station.getStationName()%></option>
                        <% } %>
                    </select>
                </div>
                <div style="flex: 1;">
                    <label for="toStation">To Station</label>
                    <select id="toStation" name="toStation" required>
                        <option value="">Select a Station</option>
                        <% for (Station station : stationList) { %>
                        <option value="<%=station.getStationName()%>"><%=station.getStationName()%></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="availableSeats">Available Seats</label>
                <input type="number" id="availableSeats" name="availableSeats" required>
            </div>

            <div class="form-group">
                <label for="fare">Fare</label>
                <input type="number" id="fare" name="fare" required>
            </div>

            <button type="submit" class="btn-primary">Add Train</button>
            <button type="button" id="autofillButton" class="btn-primary" style="background-color: #004b87; margin-left: 15px;">Autofill Example</button>
        </form>
    </div>
</body>
</html>
 