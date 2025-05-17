<%@ page import="java.util.List" %>
<%@ page import="org.example.shopx.model.FeedbackModel" %>

<!DOCTYPE html>
<html>
<head>

    <title>MyShop</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <!-- Boxicons CDN -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <meta charset="UTF-8">
    <title>Feedbacks</title>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 2rem;
        }

        .feedback-container {
            background-color: #fff;
            padding: 2rem;
            max-width: 1000px;
            margin: auto;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .feedback-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #4b1e83;
            font-size: 2rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: #4b1e83;
            color: white;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }



        .no-feedback {
            text-align: center;
            font-size: 1.2rem;
            color: #666;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead {
                display: none;
            }

            tr {
                margin-bottom: 1rem;
                background-color: #fafafa;
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 1rem;
            }

            td {
                text-align: right;
                position: relative;
                padding-left: 50%;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 1rem;
                font-weight: bold;
                color: #333;
                text-align: left;
            }
        }
    </style>
</head>
<body>
<%@ include file="/includes/navBar.jsp" %>
<div class="feedback-container">
    <h2>All Feedbacks</h2>
    <%
        List<FeedbackModel> feedbackList = (List<FeedbackModel>) request.getAttribute("feedbackList");

        if (feedbackList == null || feedbackList.isEmpty()) {
    %>
    <div class="no-feedback">No feedbacks found.</div>
    <%
    } else {
    %>
    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Subject</th>
            <th>Message</th>
            <th>Rating</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (FeedbackModel fb : feedbackList) {
        %>
        <tr>
            <td data-label="Name"><%= fb.getName() %></td>
            <td data-label="Email"><%= fb.getEmail() %></td>
            <td data-label="Subject"><%= fb.getSubject() %></td>
            <td data-label="Message"><%= fb.getMessage() %></td>
            <td data-label="Rating"><%= fb.getRating() %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
        }
    %>
</div>

<footer class="landing-footer">
    <div class="landing-footer-content">
        <div class="landing-footer-logo">ShopX</div>
        <div class="landing-footer-links">
            <a href="About.jsp">About</a>
            <a href="#">Contact</a>
            <a href="#">Privacy</a>
            <a href="#">Terms</a>
        </div>
        <p class="landing-footer-copy">&copy; 2025 ShopX. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
