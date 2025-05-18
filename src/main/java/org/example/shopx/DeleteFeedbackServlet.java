package org.example.shopx;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteFeedbackServlet")
public class DeleteFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int feedbackID;

        try {
            feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
        } catch (NumberFormatException e) {
            response.getWriter().println("<script>alert('Invalid feedback ID'); window.location.href='feedbacks.jsp';</script>");
            return;
        }

        boolean isDeleted = FeedbackController.deleteFeedback(feedbackID);

        if (isDeleted) {
            response.getWriter().println("<script>alert('Feedback is successfully removed!'); window.location.href='Feedback';</script>");
        } else {
            response.getWriter().println("<script>alert('Feedback is not removed!'); window.location.href='Feedback';</script>");
        }
    }
}
