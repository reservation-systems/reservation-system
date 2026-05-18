<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Golden Reech</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">
</head>

<body>

<div class="auth-page">

    <div class="auth-container">

        <div class="auth-card">

            <div class="auth-header">

                <div style="
                    width:70px;
                    height:70px;
                    background:white;
                    border-radius:50%;
                    display:flex;
                    align-items:center;
                    justify-content:center;
                    margin:0 auto 1rem;
                    font-size:2rem;
                    color:#d4a574;
                ">
                    <i class="fas fa-utensils"></i>
                </div>

                <h1>Welcome Back</h1>
                <p>Sign in to your Golden Reech account</p>

            </div>

            <div class="auth-body">

                <form id="login-form" onsubmit="handleLogin(event)">

                    <div class="form-group">

                        <label class="form-label">Email Address</label>

                        <div style="position:relative;">

                            <i class="fas fa-envelope"
                               style="
                               position:absolute;
                               left:1rem;
                               top:50%;
                               transform:translateY(-50%);
                               color:gray;
                               ">
                            </i>

                            <input
                                    type="email"
                                    id="email"
                                    class="form-control"
                                    placeholder="Enter your email"
                                    required
                                    style="padding-left:2.5rem;"
                            >

                        </div>

                    </div>

                    <div class="form-group">

                        <label class="form-label">Password</label>

                        <div style="position:relative;">

                            <i class="fas fa-lock"
                               style="
                               position:absolute;
                               left:1rem;
                               top:50%;
                               transform:translateY(-50%);
                               color:gray;
                               ">
                            </i>

                            <input
                                    type="password"
                                    id="password"
                                    class="form-control"
                                    placeholder="Enter your password"
                                    required
                                    style="padding-left:2.5rem;"
                            >

                            <button
                                    type="button"
                                    onclick="togglePassword(this)"
                                    style="
                                    position:absolute;
                                    right:1rem;
                                    top:50%;
                                    transform:translateY(-50%);
                                    background:none;
                                    border:none;
                                    cursor:pointer;
                                    "
                            >
                                <i class="fas fa-eye"></i>
                            </button>

                        </div>

                    </div>

                    <button
                            type="submit"
                            class="btn btn-primary w-100"
                            style="margin-top:1rem;"
                    >
                        <i class="fas fa-sign-in-alt"></i>
                        Sign In
                    </button>

                    <p id="loginMessage"
                       style="text-align:center; margin-top:1rem;">
                    </p>

                </form>

                <div class="auth-footer">

                    <p>
                        Don't have an account?
                        <a href="register.jsp">Create one</a>
                    </p>

                </div>

            </div>

        </div>

        <div style="text-align:center; margin-top:1.5rem;">

            <a href="home.jsp" style="color:white; opacity:0.8;">
                <i class="fas fa-arrow-left"></i>
                Back to Home
            </a>

        </div>

    </div>

</div>

<script>

    const API_BASE = "http://localhost:8080/api";

    async function handleLogin(event) {

        event.preventDefault();

        const message = document.getElementById("loginMessage");

        const email = document.getElementById("email").value.trim();

        const password = document.getElementById("password").value.trim();

        if (!email || !password) {

            message.style.color = "red";
            message.textContent = "Please enter email and password.";

            return;
        }

        try {

            const response = await fetch(`${API_BASE}/auth/login`, {

                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify({
                    email,
                    password
                })

            });

            const data = await response.json();

            if (data.status === "success") {

                message.style.color = "green";
                message.textContent = "Login successful. Redirecting...";

                setTimeout(() => {

                    // ADMIN LOGIN
                    if (data.role === "ADMIN") {

                        localStorage.setItem(
                            "admin",
                            JSON.stringify(data.admin)
                        );

                        window.location.href = "admin-dashboard.jsp";

                    }

                    // CUSTOMER LOGIN
                    else {

                        localStorage.setItem(
                            "customer",
                            JSON.stringify(data.customer)
                        );

                        window.location.href = "home.jsp";

                    }

                }, 1000);

            } else {

                message.style.color = "red";
                message.textContent = data.message;

            }

        } catch (error) {

            message.style.color = "red";
            message.textContent = "Server error. Make sure Spring Boot is running.";

            console.log(error);

        }

    }

    function togglePassword(btn) {

        const input = btn.parentElement.querySelector("input");

        const icon = btn.querySelector("i");

        if (input.type === "password") {

            input.type = "text";

            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");

        } else {

            input.type = "password";

            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");

        }
    }

</script>

</body>
</html>