<%@ page import="com.model.Admin"%>
<%@ page import="java.util.*"%>

<%
// Check if the admin is logged in, otherwise redirect to the login page
Admin admin = (Admin) session.getAttribute("admincred");
if (admin == null) {
	response.sendRedirect("adminlogin.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Profile</title>
<style>
body {
	background: linear-gradient(120deg, #d8c4b6, #f5efe7);
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

.header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	background: #004b87;
	color: white;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 20px;
	transition: background 0.3s ease;
}

.header img {
	max-width: 100px;
	height: auto;
}

.container {
	max-width: 1200px;
	margin: 30px auto;
	padding: 20px;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

h2, h3 {
	color: #333;
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table th, table td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: left;
}

table th {
	background-color: #f2f2f2;
	font-weight: bold;
}

table tr:hover {
	background-color: #f9f9f9;
}

a.btn-danger {
	display: inline-block;
	background-color: #d9534f;
	color: white;
	padding: 10px 20px;
	font-size: 1rem;
	border-radius: 5px;
	text-decoration: none;
	text-align: center;
	transition: background-color 0.3s ease;
}

a.btn-danger:hover {
	background-color: #c9302c;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<img src="icons/booked-train.svg" alt="Train Icon">
			<div class="text-container">
				<p></p>
				<!-- <h1><%=admin.getUname()%>!
				</h1> -->
				<h1>Your Admin Credentials</h1>
			</div>
			<img src="icons/booked-island.svg" alt="Island Icon">
		</div>

		<h2>
			Welcome,
			<%=admin.getName()%>!
		</h2>

		<!-- Include the navigation bar -->
		<jsp:include page="adminNavigation.jsp" />
<br>
		<h3>Admin Profile</h3>
		<table>
			<thead>
				<tr>
					<th>Field</th>
					<th>Details</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><strong>Admin ID</strong></td>
					<td><%=admin.getAdminId()%></td>
				</tr>
				<tr>
					<td><strong>Admin Name</strong></td>
					<td><%=admin.getName()%></td>
				</tr>
				<tr>
					<td><strong>Username</strong></td>
					<td><%=admin.getUname()%></td>
				</tr>
				<tr>
					<td><strong>Email</strong></td>
					<td><%=admin.getEmail()%></td>
				</tr>
				<tr>
					<td><strong>Contact No:</strong></td>
					<td><%=admin.getPhoneNo()%></td>
				</tr>
			</tbody>
		</table>

		<!-- Logout button -->
		<br>
		<!-- <a href="adminlogout" class="btn-danger">Logout</a> -->
	</div>
</body>
</html>
