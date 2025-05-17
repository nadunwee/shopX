package org.example.shopx;

import org.example.shopx.model.FeedbackModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import org.example.shopxVendor.controller.VendorProductController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;


public class FeedbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        // Read form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        String rating = request.getParameter("rating");

        System.out.println(rating);
        System.out.println(email);
        System.out.println(subject);
        System.out.println(message);




        boolean isInserted = FeedbackController.addFeedback(name,email,subject,message,rating);

        if(isInserted){
            response.sendRedirect("Feedback");
        }else {
            response.getWriter().println("Something went wrong");
        }
    }

//    /Add doGet method to load all feedbacks
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<FeedbackModel> feedbackList = FeedbackController.getAllFeedbacks();
        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("Feedback.jsp").forward(request, response);
    }
}
