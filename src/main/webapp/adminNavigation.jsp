

<%@ page import="com.model.Admin"%>
<%
// Check session for admin credentials
Admin admin = (Admin) session.getAttribute("admincred");
if (admin == null) {
	response.sendRedirect("adminlogin.jsp"); // Redirect to login if admin session is not active
	return;
}
%>


<script>
	function confirmLogout(event) {
		event.preventDefault(); // Prevent the default form submission
		const confirmation = confirm("Are you sure you want to log out?");
		if (confirmation) {
			document.getElementById('logoutForm').submit(); // Submit the form if confirmed
		}
	}
</script>

<style>
/* General Reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Arial', sans-serif;
}

/* Navigation Bar Styles */
.admin-nav {
	background-color: #004b87;
	color: white;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.admin-nav .logo {
	font-size: 1.5rem;
	font-weight: bold;
	letter-spacing: 1px;
}

.admin-nav .nav-links {
	display: flex;
	list-style: none;
}

.admin-nav .nav-links li {
	margin: 0 15px;
}

.admin-nav .nav-links li a {
	color: white;
	text-decoration: none;
	font-size: 1rem;
	position: relative;
	transition: color 0.3s ease;
}

.admin-nav .nav-links li a::after {
	content: "";
	display: block;
	height: 2px;
	background: white;
	width: 0;
	transition: width 0.3s ease;
	position: absolute;
	bottom: -3px;
	left: 0;
}

.admin-nav .nav-links li a:hover::after {
	width: 100%;
}

.admin-nav .nav-links li a:hover {
	color: #f1c40f;
}

.admin-nav .logout-btn {
	background-color: #e74c3c;
	color: white;
	border: none;
	padding: 8px 15px;
	border-radius: 4px;
	font-size: 1rem;
	cursor: pointer;
	transition: background 0.3s ease, transform 0.2s ease;
}

.admin-nav .logout-btn:hover {
	background-color: #c0392b;
	transform: scale(1.05);
}

/* Responsive Design */
@media ( max-width : 768px) {
	.admin-nav .nav-links {
		flex-direction: column;
		align-items: center;
	}
	.admin-nav .nav-links li {
		margin: 10px 0;
	}
}
</style>

<!-- 
<nav class="navbar navbar-expand-lg navbar-light bg-dark">
  <a class="navbar-brand text-light" href="adminDashboard">Admin Dashboard</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav ml-auto">
      <li class="nav-item">
        <a class="nav-link" href="adminDashboard" style="background-color: #d3d3d3; color: #000;">Dashboard</a>
      </li>
      <li class="nav-item border border-dark">
        <a class="nav-link " href="addTrainPage" style="background-color: #d3d3d3; color: #000;">Add Train</a>
      </li>
      <li class="nav-item border border-dark">
        <a class="nav-link" href="addStation" style="background-color: #d3d3d3; color: #000;">Add / Remove Station</a>
      </li>
      <li class="nav-item border border-dark">
        <a class="nav-link" href="adminprofile.jsp" style="background-color: #d3d3d3; color: #000;">Profile</a>
      </li> -->
<!-- Logout with a red background -->
<!--  <li class="nav-item border border-dark">
        <a class="nav-link text-white" href="adminlogout" style="background-color: #dc3545;">Logout</a>
      </li>
    </ul>
  </div>
</nav>
-->
<div class="admin-nav">
	<div class="logo">Admin Panel</div>
	<ul class="nav-links">
		<li><a href="adminDashboard">Dashboard</a></li>
		<li><a href="addTrainPage">Add Train</a></li>
		<li><a href="addStation">Add / Remove Station</a></li>
		<li><a href="adminprofile.jsp">Profile</a></li>
		<!-- <li><a href="viewBookings">View Bookings</a></li> -->
	</ul>
	<form id="logoutForm" action="adminlogout" method="GET"
		style="margin: 0;">
		<button type="button" class="logout-btn"
			onclick="confirmLogout(event)">Logout</button>
	</form>
</div>