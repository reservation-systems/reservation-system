<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="./css/style.css">

    <link rel="stylesheet"
          href="./css/admin.css">

    <link rel="stylesheet"
          href="./css/responsive.css">
</head>

<body>

<div class="admin-login-page">
    <div class="admin-login-card">
        <div class="admin-login-header">
            <div class="logo">
                <i class="fas fa-utensils"></i>
            </div>

            <h1>Admin Portal</h1>
            <p>Golden Reech Management System</p>
        </div>

        <div class="admin-login-body">
            <form id="admin-login-form"
                  onsubmit="handleAdminLogin(event)">

                <div class="form-group">
                    <label class="form-label">Admin Email</label>

                    <div style="position: relative;">
                        <i class="fas fa-envelope"
                           style="position:absolute; left:1rem; top:50%; transform:translateY(-50%); color:var(--dark-gray);"></i>

                        <input type="email"
                               id="email"
                               class="form-control"
                               placeholder="admin@goldenreech.com"
                               required
                               style="padding-left:2.5rem;">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>

                    <div style="position: relative;">
                        <i class="fas fa-lock"
                           style="position:absolute; left:1rem; top:50%; transform:translateY(-50%); color:var(--dark-gray);"></i>

                        <input type="password"
                               id="password"
                               class="form-control"
                               placeholder="Enter your password"
                               required
                               style="padding-left:2.5rem;">
                    </div>
                </div>

                <button type="submit"
                        class="btn btn-primary w-100"
                        style="margin-top:1rem;">

                    <i class="fas fa-sign-in-alt"></i>
                    Sign In to Dashboard
                </button>

                <p id="loginMessage"
                   style="margin-top:1rem; text-align:center;"></p>
            </form>
        </div>
    </div>

    <div style="text-align:center; margin-top:1.5rem;">
        <a href="home.jsp"
           style="color:white; opacity:0.8;">

            <i class="fas fa-arrow-left"></i>
            Back to Website
        </a>
    </div>
</div>

<script>
    const API_BASE = "http://localhost:8080/api";

    async function handleAdminLogin(event) {
        event.preventDefault();

        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;
        const message = document.getElementById("loginMessage");

        try {
            const response = await fetch(API_BASE + "/admin/login", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    email: email,
                    password: password
                })
            });

            if (!response.ok) {
                message.style.color = "red";
                message.textContent = "Invalid admin email or password";
                return;
            }

            const admin = await response.json();

            localStorage.setItem("admin", JSON.stringify(admin));

            message.style.color = "green";
            message.textContent = "Login successful. Redirecting...";

            setTimeout(function () {
                window.location.href = "admin-dashboard.jsp";
            }, 1000);

        } catch (error) {
            message.style.color = "red";
            message.textContent = "Server error. Make sure Spring Boot is running.";
        }
    }
</script>



</body>
</html>