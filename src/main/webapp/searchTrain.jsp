<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.model.Train"%>
<%@ page import="com.model.Customer"%>
<%@ page import="com.model.Station"%>
<%@ page import="java.util.List"%>
<%@ page import="com.dao.TrainDAO"%>
<%@ page import="com.dao.StationDAO"%>

<%
Customer customer = (Customer) session.getAttribute("usercred");
if (customer == null) {
	response.sendRedirect("login.jsp");
	return;
}

StationDAO stationDAO = new StationDAO();
List<Station> stationList = stationDAO.getAllStations();

// Fetching the search results if any
List<Train> trainList = (List<Train>) request.getAttribute("trainList");

// Fetch all trains for the "All Running Trains" table
TrainDAO trainDAO = new TrainDAO();
List<Train> allTrains = trainDAO.getAllTrains();
%>

<!-- Determine alert message based on trainList -->
<%
String alertMessage = "";
if (trainList == null || trainList.isEmpty()) {
	alertMessage = "No trains found from " + request.getParameter("fromStation") + " to "
	+ request.getParameter("toStation") + ".";
} else {
	alertMessage = trainList.size() + " train(s) found from " + request.getParameter("fromStation") + " to "
	+ request.getParameter("toStation") + ".";
}
%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Trains</title>
<link rel="stylesheet" href="css/searchTrain.css">
<style>
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
	background-color: #00529B;
	color: white;
	padding: 20px;
	text-align: center;
}

.header h1 {
	margin: 0;
	font-size: 2em;
}

.booking-form {
	padding: 20px;
	background: #f9f9f9;
	margin: 20px 0;
	border-radius: 10px;
	margin-top: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.booking-form-green {
    padding: 20px;
    background: #E5F6DF;
    margin: 20px 0;
    border-radius: 10px;
    margin-top: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-height: 400px; /* Set a maximum height for scrolling */
    overflow-y: auto; /* Enable vertical scrolling */
}

.booking-form-green table {
    width: 100%; /* Occupy full width of the container */
    border-collapse: collapse; /* Merge adjacent borders */
}

.booking-form-green th, .booking-form-green td {
    padding: 20px 40px 20px;
    text-align: left; /* Align text to the left */
    border: 0px solid #ddd; /* Add border to cells */
    border-bottom: 1px solid #ddd;
}

.booking-form-green th {
    background: #213555; /* Darker background for table header */
    color: white; /* White text for header */
}


.booking-form-red {
	padding: 20px;
	background: #FF8886;
	margin: 20px 0;
	border-radius: 10px;
	margin-top: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

label {
	display: block;
	margin: 10px 0 5px;
}

select {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

button {
	background: #213555;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background 0.3s ease;
}

button:hover {
	background-color: #003f7f;
}

/* table {
	width: 100%;
	border-collapse: collapse;
	align: center;
	margin-top: 20px;
	overflow: hidden;
	display: block; /* Enable block to allow scrolling */
	max-height: 300px; /* Set a maximum height for scrolling */
	overflow-y: auto; /* Enable vertical scrolling */
} */

/* th, td {
	padding: 20px 40px 20px;
	text-align: left;
	border-bottom: 1px solid #ddd;
} */

/* th {
	background: #213555;
	color: white;
} */

h3 {
            color: #004b87;
            font-size: 1.8rem;
            margin-bottom: 20px;
            text-align: center;
            padding-top: 20px;
        }

        .table-container {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd; /* Add borders for columns */
        }

        table th {
            background-color: #004b87; /* Header background color */
            color: white; /* Header text color */
            font-weight: bold;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #e1f5fe;
        }

        table td {
            color: #555;
        }

.info-boxes {
	display: flex;
	justify-content: space-around;
	margin-top: 20px;
}

.info-box {
	background: #00529B;
	color: white;
	padding: 20px;
	text-align: center;
	border-radius: 10px;
	flex: 1;
	margin: 10px;
	transition: transform 0.3s ease;
}

.info-box:hover {
	transform: scale(1.05);
}

.info-box img {
	width: 50px;
	height: auto;
}

.info-box p {
	margin: 10px 0 0;
}
</style>
</head>
<body>
	<div class="container">
		<jsp:include page="userNavigation.jsp" />

		<main>
			<section class="booking-form">
				<h2>Search Trains</h2>

				<!-- Search Form -->
				<form action="searchTrain" method="POST">
					<label for="from">From Station:</label> <select name="fromStation"
						id="fromStation" required>
						<option value="">Select Station</option>
						<%
						if (stationList != null) {
							for (Station station : stationList) {
						%>
						<option value="<%=station.getStationName()%>"><%=station.getStationName()%></option>
						<%
						}
						} else {
						%>
						<option value="">No Stations Available</option>
						<%
						}
						%>
					</select> <label for="toStation">To Station:</label> <select
						name="toStation" id="toStation" required>
						<option value="">Select Station</option>
						<%
						if (stationList != null) {
							for (Station station : stationList) {
						%>
						<option value="<%=station.getStationName()%>"><%=station.getStationName()%></option>
						<%
						}
						} else {
						%>
						<option value="">No Stations Available</option>
						<%
						}
						%>
					</select> <br>
					<br>
					<button type="submit">Search</button>
				</form>
			</section>

			<!-- Display Searched Trains -->

<%
				if (trainList != null && !trainList.isEmpty()) {
				%>
			<section class="booking-form-green">
				
				<h3>Search Results</h3>
				<p><strong><%= trainList.size() %></strong> train(s) found for your search criteria.</p>
				<table>
					<thead>
						<tr>
							<th>Train ID</th>
							<th>Train Name</th>
							<th>From</th>
							<th>To</th>
							<th>Available Seats</th>
							<th>Fare (per seat in Rs.)</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Train train : trainList) {
						%>
						<tr>
							<td><%=train.getTrainNo()%></td>
							<td><%=train.getTrainName()%></td>
							<td><%=train.getFromStation()%></td>
							<td><%=train.getToStation()%></td>
							<td><%=train.getAvailableSeats()%></td>
							<td><%=train.getFare()%></td>
							<td>
								<form action="bookTicket" method="GET" class="m-0">
									<input type="hidden" name="trainId"
										value="<%=train.getTrainNo()%>">
									<button type="submit">Book</button>
								</form>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<%
				} else {
				%>
				<section class="booking-form-red">No trains found for the selected route.</section>
				<%
				}
				%>
			</section>

			<!-- All Running Trains Section -->
			<section class="booking-form">
				<h3>All Running Trains</h3>
				<%
				if (allTrains != null && !allTrains.isEmpty()) {
				%>
				<table>
					<thead>
						<tr>
							<th>Train ID</th>
							<th>Train Name</th>
							<th>From</th>
							<th>To</th>
							<th>Available Seats</th>
							<th>Fare (per seat in Rs.)</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Train train : allTrains) {
						%>
						<tr>
							<td><%=train.getTrainNo()%></td>
							<td><%=train.getTrainName()%></td>
							<td><%=train.getFromStation()%></td>
							<td><%=train.getToStation()%></td>
							<td><%=train.getAvailableSeats()%></td>
							<td><%=train.getFare()%></td>
							<td>
								<form action="bookTicket" method="GET" class="m-0">
									<input type="hidden" name="trainId"
										value="<%=train.getTrainNo()%>">
									<button type="submit">Book</button>
								</form>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<%
				} else {
				%>
				<div class="alert alert-warning">No running trains available.</div>
				<%
				}
				%>
			</section>
		</main>
	</div>
</body>
</html>