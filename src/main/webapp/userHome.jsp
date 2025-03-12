<%@ page import="java.util.List"%>
<%@ page import="com.model.Ticket"%>
<%@ page import="com.model.Customer"%>
<%@ page import="com.dao.TicketDAO"%>

<%
Customer customer = (Customer) session.getAttribute("usercred");
if (customer == null) {
    response.sendRedirect("login.jsp");
    return;
}

TicketDAO ticketDAO = new TicketDAO();
List<Ticket> tickets = ticketDAO.getTicketsByUserId(customer.getUserId());

String success = request.getParameter("success");
String successPnr = request.getParameter("successPnr");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Dashboard</title>
<script>
    history.pushState(null, null, location.href);
    window.onpopstate = function() {
        history.go(1);
    };
</script>

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
<link rel="stylesheet" href="css/userHome.css">
<style>
body {
    font-family: 'Arial', sans-serif;
    background: linear-gradient(120deg, #d8c4b6, #f5efe7);
    color: #333;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.container {
    max-width: 1200px;
    margin: 0px auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
    padding: 40px;
}

.header {
    background: #213555;
    color: white;
    padding: 50px 20px;
    text-align: center;
}

.text-container p {
    margin: 0;
    font-size: 1.3em;
    color: white;
}

.text-container h1 {
    margin: 15px 0 0;
    font-size: 2.5em;
    letter-spacing: 1px;
}

.buttons-container {
    text-align: center;
    margin: 30px 0;
}

.back-button, .refresh-button, .logout-button {
    margin: 10px;
    padding: 15px 30px;
    font-size: 1em;
    font-weight: bold;
    text-transform: uppercase;
    border-radius: 30px;
    transition: background 0.3s ease, transform 0.2s ease;
    cursor: pointer;
    border: none;
    color: white;
    background: #213555;
}

.book-button {
    margin: 10px;
    padding: 15px 30px;
    font-size: 1em;
    font-weight: bold;
    text-transform: uppercase;
    border-radius: 30px;
    border: none;
    color: white;
    cursor: pointer;
    animation: colorChange 5s infinite alternate;
}

@keyframes colorChange {
    0% { background-color: #2b3b5f; } /* Teal */
    25% { background-color: #3a5080; } /* Darker Teal */
    50% { background-color: #4a65a2; } /* Lighter Teal */
    75% { background-color: #647eb8; } /* Teal */
    100% { background-color: #869ac8; } /* Darker Teal */
}

.back-button:hover, .refresh-button:hover, .logout-button:hover {
    background-color: #1565C0;
    transform: translateY(-3px);
}

/* Enhanced ticket card styles */
.ticket-card {
    background-color: #ffffff;
    border: 2px solid #00529B;
    border-radius: 10px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
    padding: 20px;
    margin-bottom: 20px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.ticket-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
}

.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 2px solid #00529B;
    padding-bottom: 10px;
    margin-bottom: 15px;
}

.card-body {
    padding: 10px 0;
}

.route {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 1.2em;
    font-weight: bold;
    color: #00529B;
}

.route-line {
    flex: 1;
    height: 2px;
    background-color: #ccc;
    margin: 0 10px;
}

.price-cancel {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}

.price {
    font-size: 1.5em;
    font-weight: bold;
    color: #333;
}

.cancel {
    padding: 10px 20px;
    background-color: #d9534f;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.cancel:hover {
    background-color: #c9302c;
}

.card-details {
    display: none;
    margin-top: 15px;
    border-top: 1px solid #ddd;
    padding-top: 10px;
    transition: max-height 0.3s ease, padding 0.3s ease;
    max-height: 0;
    overflow: hidden;
}

.card-details.show {
    display: block;
    max-height: 500px; /* Set an appropriate max-height */
}

.toggle-button {
    display: inline-block;
    margin-top: 10px;
    cursor: pointer;
    color: #007BFF;
    text-decoration: underline;
}
</style>

<script>
    function logout() {
        window.location.href = "login.jsp";
    };
</script>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="icons/booked-train.svg" alt="Train Icon" class="icon-left">
            <div class="text-container">
                <h1>TATA RAILWAYS</h1>
                <h3>Hello <%=customer.getUserName()%>!</h3>
            </div>
            <img src="icons/booked-island.svg" alt="Island Icon" class="icon-right">
        </div>

        <div class="buttons-container">
            <button class="refresh-button" onclick="refreshPage()">Refresh</button>
            <button class="book-button" onclick="window.location.href='searchTrain.jsp'">Book Ticket</button>
            <button class="logout-button" onclick="window.location.href='userlogout'">Logout</button>
        </div>

        <%
        if (successPnr != null) {
        %>
        <div id="successMessage" class="alert alert-success">
            Your ticket has been successfully booked. Your PNR is: <strong><%=successPnr%></strong>
        </div>
        <%
        }
        %>

        <%
        if (success != null) {
        %>
        <div id="deleteMessage" class="alert alert-success">
            Booking done successfully for <strong><%=success%></strong>
        </div>
        <%
        }
        %>

        <h3>Your Booked Tickets</h3>

        <%
        if (tickets.isEmpty()) {
        %>
        <img alt="" src="images/image.png" style="display:block; margin:0 auto; opacity: 0.2" width=70% height=25%>
        <%
        } else {
        %>
        <div class="card-container">
            <%
            for (Ticket ticket : tickets) {
            %>
            <div class="ticket-card">
                <div class="card-header">
                    <h4>Train Name: <%=ticket.getTrainName()%></h4>
                    <p>PNR: <%=ticket.getPnr()%></p>
                </div>
                <div class="card-body">
                    <div class="route">
                        <span><%=ticket.getFromStation()%></span>
                        <div class="route-line"></div>
                        <span><%=ticket.getToStation()%></span>
                    </div>
                    <div class="price-cancel">
                        <span class="price">Amount Paid: Rs. <%=ticket.getTotalFare()%></span>
                        <form action="cancelTicket" method="POST">
                            <input type="hidden" name="pnr" value="<%=ticket.getPnr()%>">
                            <button type="submit" class="cancel">Cancel</button>
                        </form>
                    </div>
                    <div class="card-details">
                        <p><strong>Seats:</strong> <%=ticket.getSeatCount()%></p>
                        <p><strong>Booked On:</strong> <%=ticket.getBookingDate()%></p>
                    </div>
                    <span class="toggle-button" onclick="toggleDetails(this)">Show Details</span>
<!--                     <button onclick="downloadTicket('12345')">Download Ticket</button>
 -->                </div>
            </div>
            <%
            }
            %>
        </div>
        <%
        }
        %>
    </div>
    <script>
        function downloadTicket(ticketId) {
            window.location.href = "downloadTicket?ticketId=" + ticketId; // Adjust the URL as needed
        }

        function toggleDetails(button) {
            const details = button.previousElementSibling;
            if (details.classList.contains('show')) {
                details.classList.remove('show');
                button.innerText = "Show Details";
            } else {
                details.classList.add('show');
                button.innerText = "Hide Details";
            }
        }

        function refreshPage() {
            location.reload();
        }
    </script>
</body>
</html>