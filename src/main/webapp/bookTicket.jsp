

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.model.Train"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="com.model.Customer"%>

<%
Customer customer = (Customer) session.getAttribute("usercred");
if (customer == null) {
	response.sendRedirect("login.jsp");
	return;
}

Train train = (Train) request.getAttribute("train");
String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Ticket</title>
<style>
/* General Reset */
/* * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        } */
body {
	font-family: 'Arial', sans-serif;
	background: linear-gradient(120deg, #d8c4b6, #f5efe7);
	color: #333;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 1200px;
	margin: 0px auto;
	background: white;
	border-radius: 12px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	padding: 40px;
	box-sizing: border-box;
}

.header {
	text-align: center;
	background-color: #00529B;
	padding: 20px;
	border-radius: 8px;
	color: white;
	margin-bottom: 20px;
}

.header h1 {
	font-size: 2rem;
}

.form-group {
	width: 100%;
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
}

.form-control {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 1rem;
}

.btn {
	width: 100%;
	padding: 12px;
	font-size: 1rem;
	font-weight: bold;
	color: white;
	background: #213555;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease;
}

.btn-back {
	width: 100%;
	padding: 12px;
	font-size: 1rem;
	font-weight: bold;
	color: white;
	background: #ff4122;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease;
}

.btn-back {
	width: 100%;
	padding: 12px;
	font-size: 1rem;
	font-weight: bold;
	color: white;
	background: #ff4122;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease;
}

.btn-back:hover {
	background-color: #ff8164;
}

.btn-book {
	width: 100%;
	padding: 12px;
	font-size: 1rem;
	font-weight: bold;
	color: white;
	background: #6fc276;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease;
}

.btn-book:hover {
	background-color: #419a49;
}

.btn:hover {
	background-color: #00529B;
}

.form-row {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	align-items: center;
}

.form-group.half-width {
	width: 48%;
}

.alert {
	padding: 15px;
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
	border-radius: 6px;
	text-align: center;
}
</style>
</head>
<body>

	<%-- Navigation Bar --%>
	<!-- <div class="navbar">
    <div>
        <a href="home.jsp">Home</a>
        <a href="profile.jsp">Profile</a>
        <a href="trains.jsp">Trains</a>
    </div>
    <div>
        <a href="logout.jsp">Logout</a>
    </div>
</div> -->
	<main>


		<div class="container">
			<jsp:include page="userNavigation.jsp" />
			<!-- div class="header">
            <h1>Book Your Ticket</h1>
            <p>Find Your Journey with Us</p>
        </div> -->

			<%
			if (error != null) {
			%>
			<div class="alert"><%=error%></div>
			<%
			}
			%>

			<%
			if (train != null) {
			%>
			<h1>Book Your Ticket</h1>
			<form action="bookTicket" method="post">
				<div class="form-row">

					<div class="form-group half-width">
						<label for="trainIdBooking">Train ID:</label> <input type="number"
							class="form-control" name="trainIdBooking" id="trainIdBooking"
							value="<%=train.getTrainNo()%>" readonly>

					</div>
					<div class="form-group half-width">
						<label for="trainName">Train Name:</label> <input type="text"
							class="form-control" name="trainName" id="trainName"
							value="<%=train.getTrainName()%>" readonly>
					</div>
				</div>

				<div class="form-row">
					<div class="form-group half-width">
						<label for="fromStation">From Station:</label> <input type="text"
							class="form-control" name="fromStation" id="fromStation"
							value="<%=train.getFromStation()%>" readonly>
						<div id="fromStationError" class="error-message"></div>

					</div>
					<div class="form-group half-width">
						<label for="toStation">To Station:</label> <input type="text"
							class="form-control" name="toStation" id="toStation"
							value="<%=train.getToStation()%>" readonly>
						<div id="toStationError" class="error-message"></div>

					</div>
				</div>

				<div class="form-row">
					<div class="form-group half-width">
						<label for="fare">Fare (per seat):</label> <input type="text"
							class="form-control" name="fare" id="fare"
							value="<%=train.getFare()%>" readonly>
					</div>
					<div class="form-group half-width">
						<label for="availableSeats">Available Seats:</label> <input
							type="number" class="form-control" name="availableSeats"
							id="availableSeats" value="<%=train.getAvailableSeats()%>"
							readonly>
					</div>
				</div>

				<div class="form-group">
					<label for="seatCount">Number of Seats:</label> <input
						type="number" class="form-control" name="seatCount" id="seatCount"
						min="1" max="6" required>
				</div>

				<div class="form-group">
					<label for="bookingDate">Booking Date:</label> <input type="date"
						class="form-control" name="bookingDate" id="bookingDate" required
						min="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>">
				</div>

				<script>
    // Calculate the date 3 months from the current date
    const today = new Date();
    const maxDate = new Date(today.setMonth(today.getMonth() + 3)); // 3 months ahead

    // Format the date to yyyy-MM-dd
    const formattedMaxDate = maxDate.toISOString().split('T')[0]; // ISO format: yyyy-MM-dd

    // Set the max date for the bookingDate input
    document.getElementById('bookingDate').setAttribute('max', formattedMaxDate);
</script>



				<div class="form-group">
					<label for="totalFare">Total Fare (₹):</label> <input type="text"
						class="form-control" name="totalFare" id="totalFare" readonly>
				</div>

				<div class="form-row">
					<div class="form-group" style="flex: 0 0 30%; padding-right: 10px;">
						<button type="button" class="btn-back"
							onclick="window.history.back()">Back</button>
					</div>
					<div class="form-group" style="flex: 0 0 30%; padding-left: 10px;">
						<button type="button" class="btn-book" onclick="confirmBooking()">Book
							Ticket</button>
					</div>
				</div>

				<script>
    function confirmBooking() {
        const confirmation = confirm("Are you sure you want to book this ticket?");
        if (confirmation) {
            // If confirmed, submit the form
            document.querySelector('form').submit();
        }
    }
</script>

			</form>
			<%
			}
			%>
		</div>
	</main>
	<script>
        document.getElementById('seatCount')?.addEventListener('input', function () {
            const seatCount = parseInt(this.value) || 0;
            const fare = parseFloat(document.getElementById('fare')?.value) || 0;
            document.getElementById('totalFare').value = (seatCount * fare).toFixed(2);
        });
        


    function validateStations() {
        const fromStation = document.getElementById("fromStation").value.trim();
        const toStation = document.getElementById("toStation").value.trim();
        const fromStationError = document.getElementById("fromStationError");
        const toStationError = document.getElementById("toStationError");

        // Clear previous error messages
        fromStationError.textContent = "";
        toStationError.textContent = "";

        // Check if the source and destination are the same
        if (fromStation.toLowerCase() === toStation.toLowerCase() && fromStation !== "" && toStation !== "") {
            fromStationError.textContent = "Change source or destination.";
            toStationError.textContent = "Change source or destination.";
            return false;
        }
        return true;
    }

    // Attach event listeners to input fields for dynamic validation
    document.getElementById("fromStation").addEventListener("input", validateStations);
    document.getElementById("toStation").addEventListener("input", validateStations);


    </script>
</body>
</html>

