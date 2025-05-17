<%@ page import="java.util.List" %>
<%@ page import="org.example.shopx.model.FeedbackModel" %>

<div class="feedback-list" style="margin: 2rem auto; max-width: 900px;">
    <h2>All Feedbacks</h2>
    <%
        List<FeedbackModel> feedbackList = (List<FeedbackModel>) request.getAttribute("feedbackList");

        if (feedbackList == null || feedbackList.isEmpty()) {
    %>
    <p>No feedbacks found.</p>
    <%
    } else {
    %>
    <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; border-collapse: collapse;">
        <thead style="background-color: #4b1e83; color: white;">
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
            <td><%= fb.getName() %></td>
            <td><%= fb.getEmail() %></td>
            <td><%= fb.getSubject() %></td>
            <td><%= fb.getMessage() %></td>
            <td><%= fb.getRating() %></td>
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
