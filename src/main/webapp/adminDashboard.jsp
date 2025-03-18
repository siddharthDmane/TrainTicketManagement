
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Admin"%>
<%@ page import="com.model.Train"%>
<%@ page import="java.util.*"%>

<%
    Admin admin = (Admin) session.getAttribute("admincred");
    if (admin == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }
    List<Train> trainList = (List<Train>) request.getAttribute("trainList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    
    
    
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
    
    <script>
        function confirmCancel(trainNo) {
            return confirm("Are you sure you want to cancel the train number " + trainNo + "?");
        }
    </script>
    
    
    <style>
        /* Global Styles */
        /* * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        } */

        body {
            background: linear-gradient(120deg, #d8c4b6, #f5efe7);
            color: #333;
            /* padding: 20px; */
            margin: 0;
            overflow-x: hidden;
        }

        .container {
            max-width: 1200px;
            margin: 0px auto 0 auto;
            
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #004b87;
            padding: 20px;
            border-radius: 8px;
            color: white;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2rem;
            margin: 0;
        }

        .header p {
            font-size: 1.2rem;
            margin: 0;
        }

        .header img {
            max-width: 80px;
            height: auto;
        }

        /* Train List Section */
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

        /* Button Styles */
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
            transform: translateY(-2px);
        }

        .btn-danger:active {
            transform: translateY(1px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .text-center {
            text-align: center;
            font-size: 1.2rem;
            color: #999;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header Section -->
        <div class="header">
            <img src="icons/booked-train.svg" alt="Train Icon" />
            <div>
                <p>Welcome to Admin Dashboard</p>
                <h1 align="center"><%= admin.getUname() %>!</h1>
            </div>
            <img src="icons/booked-island.svg" alt="Island Icon" />
        </div>

        <!-- Include Navigation -->
        <jsp:include page="adminNavigation.jsp" />

        <!-- Train List -->
        <h3>Running Train List</h3>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Train No</th>
                        <th>Train Name</th>
                        <th>From Station</th>
                        <th>To Station</th>
                        <th>Available Seats</th>
                        <th>Fare</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (trainList != null && !trainList.isEmpty()) {
                            for (Train train : trainList) {
                    %>
                    <tr>
                        <td><%= train.getTrainNo() %></td>
                        <td><%= train.getTrainName() %></td>
                        <td><%= train.getFromStation() %></td>
                        <td><%= train.getToStation() %></td>
                        <td><%= train.getAvailableSeats() %></td>
                        <td><%= train.getFare() %></td>
                        <td>
                            <form action="cancelTrain" method="POST" style="display:inline;" onsubmit="return confirmCancel('<%= train.getTrainNo() %>');">
                                <input type="hidden" name="trainNo" value="<%= train.getTrainNo() %>">
                                <button type="submit" class="btn-danger">Cancel</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center">No trains available</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
 