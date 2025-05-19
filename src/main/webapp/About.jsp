<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="org.example.shopx.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>MyShop</title>
    <link rel="stylesheet" type="text/css" href="style.css">

    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body class="body1">

<%@ include file="/includes/navBar.jsp" %>

<div class="AboutUsContent">
    <h1>About ShopX</h1>

    <div class="section">
        <h2><i class='bx bx-globe'></i> Company Overview</h2>
        <p>
            <span class="highlight">ShopX</span> is an exciting e-shopping platform that brings buyers and sellers together in one convenient space.
            Imagine a virtual marketplace where you can discover unique finds, snag great deals, and enjoy seamless transactions — that's what we're all about!
            Our goal is to make online shopping a breeze, while providing a trusted and enjoyable experience for everyone.
        </p>
    </div>

    <div class="section">
        <h2><i class='bx bx-bullseye'></i> Mission</h2>
        <p>
            At ShopX, our mission is to <strong>empower individuals</strong> to buy and sell with confidence.
            We strive to create a vibrant community where people can connect, share, and exchange goods and ideas.
            With technology and innovation, we make shopping easier, more enjoyable, and accessible.
        </p>
    </div>

    <div class="section">
        <h2><i class='bx bx-target-lock'></i> Vision</h2>
        <p>
            We aim to become the <strong>go-to e-shopping destination</strong> where customers can find anything they want or need.
            Our platform is built not just to be functional, but fun, interactive, and inspiring.
            We envision a future where <span class="highlight">ShopX</span> is known for excellent service and great deals.
        </p>
    </div>

    <div class="section">
        <h2><i class='bx bx-diamond'></i> Core Values</h2>
        <ul>
            <li><strong>Customer Delight:</strong> We exceed expectations with exceptional experiences.</li>
            <li><strong>Trust and Transparency:</strong> Fair practices, open communication, honest policies.</li>
            <li><strong>Innovation:</strong> Technology drives our continuous improvement.</li>
            <li><strong>Community:</strong> We build connections through support and inclusivity.</li>
        </ul>
    </div>

    <div class="section team">
        <h2><i class='bx bx-group'></i> Meet the Team</h2>
        <p>
            Behind <span class="highlight">ShopX</span> is a passionate team of professionals — developers, designers, and support specialists —
            all united by one goal: to revolutionize e-commerce. We thrive on innovation, collaboration, and community spirit.
        </p>
    </div>


        <div style="text-align:center; margin: 3rem;">
            <button onclick="openFeedbackForm()" style="padding: 12px 24px; background-color: #4b1e83; color: white; border: none; border-radius: 8px; font-size: 16px; cursor: pointer;">
                Give Feedback
            </button>
        </div>


        <div id="feedbackModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background-color:rgba(0,0,0,0.6); z-index:9999; align-items:center; justify-content:center;">
            <div style="background:white; padding:30px; border-radius:12px; max-width:500px; width:90%; position:relative;">
                <h2 style="color:#4b1e83; margin-bottom:1rem;">We value your feedback</h2>
                <form id="feedbackForm" action="${pageContext.request.contextPath}/Feedback" method="post">
                    <div style="margin-bottom:1rem;">
                        <label>Name *</label><br>
                        <input type="text" id="name" name="name" style="width:100%; padding:8px;" />
                    </div>
                    <div style="margin-bottom:1rem;">
                        <label>Email *</label><br>
                        <input type="text" id="email" name="email" style="width:100%; padding:8px;" />
                    </div>
                    <div style="margin-bottom:1rem;">
                        <label>Subject *</label><br>
                        <input type="text" id="subject" name="subject" style="width:100%; padding:8px;" />
                    </div>
                    <div style="margin-bottom:1rem;">
                        <label>Rating (1-5) *</label><br>
                        <input type="number" id="rating" name="rating" min="1" max="5" style="width:100%; padding:8px;" />
                    </div>
                    <div style="margin-bottom:1rem;">
                        <label>Message *</label><br>
                        <textarea id="message" name="message" rows="4" style="width:100%; padding:8px;"></textarea>
                    </div>
                    <div style="margin-bottom:1rem;">
                        <input type="checkbox" id="agree" />
                        <label for="agree"> I agree to the terms and conditions *</label>
                    </div>
                    <div style="text-align:right;">
                        <button type="submit" style="padding:10px 18px; background-color:#4b1e83; color:white; border:none; border-radius:6px;">Submit</button>
                        <button type="button" onclick="closeFeedbackForm()" style="margin-left:10px; padding:10px 18px; background-color:#ccc; border:none; border-radius:6px;">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function openFeedbackForm() {
                document.getElementById("feedbackModal").style.display = "flex";
            }

            function closeFeedbackForm() {
                document.getElementById("feedbackModal").style.display = "none";
            }

            function validateFeedbackForm() {
                const name = document.getElementById("name").value.trim();
                const email = document.getElementById("email").value.trim();
                const subject = document.getElementById("subject").value.trim();
                const rating = document.getElementById("rating").value;
                const message = document.getElementById("message").value.trim();
                const agree = document.getElementById("agree").checked;

                if (!name || name.length < 2) {
                    alert("Name must be at least 2 characters.");
                    return false;
                }
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert("Please enter a valid email.");
                    return false;
                }
                if (!subject || subject.length < 5) {
                    alert("Subject must be at least 5 characters.");
                    return false;
                }
                if (!rating || rating < 1 || rating > 5) {
                    alert("Please provide a rating between 1 and 5.");
                    return false;
                }
                if (!message || message.length < 10) {
                    alert("Message must be at least 10 characters.");
                    return false;
                }
                if (!agree) {
                    alert("You must agree to the terms.");
                    return false;
                }
                alert("Thank you for your feedback!");
                closeFeedbackForm();
                return false;
            }
        </script>

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
