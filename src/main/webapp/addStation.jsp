

<%@ page import="java.util.List"%>
<%@ page import="com.model.Station"%>
<%@ page import="com.model.Admin"%>

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
<title>Add / Remove Station</title>

<script>
    function confirmDelete(stationName) {
        return confirm("Are you sure you want to delete the station \"" + stationName + "\"?");
    }
</script>

<style>
/* Global Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}

body {
    background: linear-gradient(120deg, #d8c4b6, #f5efe7);
    color: #333;
    /* padding: 20px; */
    margin: 0;
}

.container {
    max-width: 1200px;
    padding: 40px;
    background-color: white;
    border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
    margin: 40px auto;
    margin-top: 0;
}

/* Header */
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
    font-size: 2rem;
    margin: 0;
}

.header img {
    max-width: 80px;
    height: auto;
}

/* Section Headings */
h2, h3 {
    color: #004b87;
    font-size: 1.6rem;
    margin-bottom: 20px;
}

/* Form Styling */
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

input[type="text"] {
    width: 100%;
    padding: 12px;
    font-size: 1.1rem;
    border: 1px solid #ddd;
    border-radius: 6px;
    background-color: #f9f9f9;
}

input[type="text"]:focus {
    border-color: #3498db;
    outline: none;
}

button {
    background-color: #3498db;
    color: white;
    border: none;
    padding: 12px 20px;
    font-size: 1.1rem;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    width: 100%;
}

button:hover {
    background-color: #2980b9;
    transform: translateY(-2px);
}

button:active {
    background-color: #1d6ea1;
    transform: translateY(1px);
}

/* Table Styling */
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
    border: 1px solid #ddd; /* Add border for columns */
}

table th {
    background-color: #004b87; /* Header background color matches navbar */
    color: white; /* Header text color */
    font-weight: bold;
    text-align: center;
}

table tr:nth-child(even) {
    background-color: #f9f9f9;
}

table tr:hover {
    background-color: #e1f5fe; /* Add hover animation for rows */
    transition: background-color 0.3s ease; /* Smooth transition */
}

.btn-danger {
    background-color: #d9534f;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s ease, transform 0.2s ease;
}

.btn-danger:hover {
    background-color: #c9302c;
    transform: translateY(-2px); /* Add hover effect for delete button */
}

.btn-danger:active {
    transform: translateY(1px);
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

</style>

<script>
    function validateForm() {
        const stationName = document.getElementById("stationName").value.trim();
        if (stationName === "") {
            alert("Station Name cannot be empty.");
            return false;
        }
        alert("Station added successfully!");
        return true;
    }
</script>
</head>
<body>
    <div class="container">
        <!-- Header Section -->
        <div class="header">
            <img src="icons/booked-train.svg" alt="Train Icon">
            <div>
                <h1>Add / Remove Stations</h1>
            </div>
            <img src="icons/booked-island.svg" alt="Island Icon">
        </div>

        <!-- Navigation Bar Inclusion -->
        <jsp:include page="adminNavigation.jsp" />
        <br>

        <!-- Add Station Form -->
        <h3>Add Station</h3>
        <form action="addStation" method="POST" onsubmit="return validateForm();">
            <div class="form-group">
                <label for="stationName">Station Name</label>
                <input type="text" id="stationName" name="stationName" required>
            </div>
            <button type="submit">Add Station</button>
        </form>

        <!-- Station List -->
        <br>
        <h3>Station List</h3>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Station Code</th>
                        <th>Station Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (stationList != null) {
                        int count = 1;
                        for (Station station : stationList) {
                    %>
                    <tr>
                        <td><%=count++%></td>
                        <td><%=station.getStationId()%></td>
                        <td><%=station.getStationName()%></td>
                        <td>
                            <form action="deleteStation" method="POST" style="display: inline;" onsubmit="return confirmDelete('<%= station.getStationName() %>');">
                                <input type="hidden" name="stationId" value="<%=station.getStationId()%>">
                                <button type="submit" class="btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
