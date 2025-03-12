<%@ page import="com.model.Customer"%>
<%
// Check session for admin credentials
Customer customer = (Customer) session.getAttribute("usercred");
if (customer == null) {
	response.sendRedirect("login.jsp"); // Redirect to login if admin session is not active
	return;
}
%>

<header>
	<nav>
		<ul class="nav-left">
			<li><a href=""> <img src="icons/tata-while-logo.png"
					alt="tcs-logo" class="logo">
			</a></li>
		</ul>
		<h1>
			<b>TATA RAILWAYS</b>
		</h1>
		<ul class="nav-right">
			<li><a href="userHome.jsp"><img alt=""
					src="icons/ticket-nav.svg" class="ticket-nav">Bookings</a></li>
			<li><a href="userprofile"><img alt=""
					src="icons/profile-nav.svg" class="profile-nav">Profile</a></li>
			<li><a href="userlogout"><img alt=""
					src="icons/logout-icon.svg" class="logout-icon">Logout</a></li>
		</ul>
	</nav>
</header>

<head>
<style>
/* General Header Styles */
header {
	background: #213555;
	color: white;
	padding: 10px 20px;
}

nav {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

/* Left Navigation: Logo */
.nav-left {
	list-style-type: none;
	display: flex;
	align-items: center;
}

.nav-left .logo {
	height: auto;
	width: 50px; /* Adjusted for better scaling */
}

/* Right Navigation: Profile and Logout */
.nav-right {
	display: flex;
	align-items: center;
	list-style: none;
	margin: 0;
	padding: 0;
	gap: 15px; /* Space between buttons */
}

.nav-right li {
	margin: 0;
}

.nav-right a {
    color: white;
    text-decoration: none;
    padding: 8px 15px;
    border-radius: 5px;
    transition: background 0.3s, color 0.3s;
    display: flex;
    align-items: center;
}

.logout-icon, .profile-nav, .ticket-nav {
	width: 20px; /* Adjust the size of the logout icon */
	height: auto;
	margin-right: 8px; /* Space between the icon and text */
	filter: invert(1) brightness(2);
}

.nav-right a:hover {
	background: #4CAF50;
	color: white;
	text-shadow: 0 0 8px #4CAF50;
}
</style>
</head>
