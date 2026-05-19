<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Profile - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- KEEP ORIGINAL PATHS -->
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">

</head>

<body>

<nav class="customer-navbar">

    <div class="navbar-container">

        <a href="home.jsp" class="logo">

            <i class="fas fa-utensils"></i>

            <span>Golden Reech</span>

        </a>

        <ul class="nav-menu">

            <li><a href="home.jsp" class="nav-link">Home</a></li>

            <li><a href="menu.jsp" class="nav-link">Menu</a></li>

            <li><a href="offers.jsp" class="nav-link">Offers</a></li>

            <li><a href="reservation.jsp" class="nav-link">Book a Table</a></li>

            <li><a href="reviews.jsp" class="nav-link">Reviews</a></li>

        </ul>

        <div class="nav-actions">

            <a href="customer-dashboard.jsp"
               class="btn btn-outline btn-sm">

                <i class="fas fa-user"></i>
                Dashboard

            </a>

            <button class="btn btn-primary btn-sm"
                    onclick="logout()">

                <i class="fas fa-sign-out-alt"></i>
                Logout

            </button>

        </div>

    </div>

</nav>

<section class="page-banner">

    <div class="container">

        <h1>My Profile</h1>

        <p>
            Manage your account information
        </p>

    </div>

</section>

<section class="section">

    <div class="container">

        <div class="profile-layout">

            <div class="profile-card">

                <div class="profile-avatar">

                    <i class="fas fa-user-circle"></i>

                </div>

                <h2 id="profileName">
                    Loading...
                </h2>

                <p id="profileEmail">
                    Loading...
                </p>

            </div>

            <div class="profile-form-card">

                <h2>
                    Update Profile
                </h2>

                <form id="profileForm">

                    <input type="hidden"
                           id="userId">

                    <div class="form-group">

                        <label class="form-label">
                            Full Name
                        </label>

                        <input type="text"
                               id="fullName"
                               class="form-control">

                    </div>

                    <div class="form-group">

                        <label class="form-label">
                            Email Address
                        </label>

                        <input type="email"
                               id="email"
                               class="form-control">

                    </div>

                    <div class="form-group">

                        <label class="form-label">
                            Phone Number
                        </label>

                        <input type="text"
                               id="phone"
                               class="form-control">

                    </div>

                    <div class="form-group">

                        <label class="form-label">
                            Address
                        </label>

                        <textarea id="address"
                                  class="form-control"
                                  rows="3"></textarea>

                    </div>

                    <div class="form-group">

                        <label class="form-label">
                            New Password
                        </label>

                        <input type="password"
                               id="password"
                               class="form-control"
                               placeholder="Leave blank to keep current password">

                    </div>

                    <button type="submit"
                            class="btn btn-primary">

                        <i class="fas fa-save"></i>
                        Update Profile

                    </button>

                </form>

            </div>

        </div>

    </div>

</section>

<footer class="customer-footer">

    <div class="footer-content">

        <div class="footer-section">

            <h3>About Us</h3>

            <p>
                Golden Reech is a modern restaurant offering delicious meals,
                excellent customer service, and a relaxing dining experience
                for families, couples, and friends.
            </p>

        </div>

        <div class="footer-section">

            <h3>Quick Links</h3>

            <ul>

                <li><a href="home.jsp">Home</a></li>
                <li><a href="menu.jsp">Menu</a></li>
                <li><a href="reservation.jsp">Reservations</a></li>
                <li><a href="offers.jsp">Offers</a></li>
                <li><a href="reviews.jsp">Reviews</a></li>

            </ul>

        </div>

        <div class="footer-section">

            <h3>Contact</h3>

            <ul>

                <li>
                    <i class="fas fa-phone"></i>
                    +94 77 568 4650
                </li>

                <li>
                    <i class="fas fa-phone"></i>
                    +94 75 457 6071
                </li>

                <li>
                    <i class="fas fa-envelope"></i>
                    info@goldenreech.com
                </li>

            </ul>

        </div>

    </div>

    <div class="footer-bottom">
        <p>&copy; 2024 Golden Reech. All rights reserved.</p>
    </div>

</footer>

<!-- KEEP ORIGINAL PATH -->
<script src="./js/main.js"></script>

<script>

    const API_BASE =
        "http://localhost:8080/api/customers";

    let currentUser = null;

    document.addEventListener(
        "DOMContentLoaded",
        () => {

            const customer =
                JSON.parse(localStorage.getItem("customer"));

            if(!customer){

                alert("Please login first.");

                window.location.href =
                    "login.jsp";

                return;
            }

            loadProfile(customer.email);

            document.getElementById("profileForm")
                .addEventListener(
                    "submit",
                    updateProfile
                );
        }
    );

    async function loadProfile(email){

        try{

            const response =
                await fetch(
                    `${API_BASE}/email/${encodeURIComponent(email)}`
                );

            if(!response.ok){
                throw new Error("Failed");
            }

            currentUser =
                await response.json();

            fillProfileData(currentUser);

        }catch(error){

            console.error(error);

            alert(
                "Failed to load profile."
            );
        }
    }

    function fillProfileData(user){

        document.getElementById("userId").value =
            user.id || "";

        document.getElementById("fullName").value =
            user.name || "";

        document.getElementById("email").value =
            user.email || "";

        document.getElementById("phone").value =
            user.phone || "";

        document.getElementById("address").value =
            user.address || "";

        document.getElementById("profileName").textContent =
            user.name || "Customer";

        document.getElementById("profileEmail").textContent =
            user.email || "";
    }

    async function updateProfile(event){

        event.preventDefault();

        const updatedUser = {

            id:
            document.getElementById("userId").value,

            name:
            document.getElementById("fullName").value,

            email:
            document.getElementById("email").value,

            phone:
            document.getElementById("phone").value,

            address:
            document.getElementById("address").value,

            password:
                document.getElementById("password").value
                || currentUser.password
        };

        try{

            const response =
                await fetch(
                    `${API_BASE}/${updatedUser.id}`,
                    {

                        method:"PUT",

                        headers:{
                            "Content-Type":"application/json"
                        },

                        body: JSON.stringify(updatedUser)
                    }
                );

            if(!response.ok){
                throw new Error("Failed");
            }

            localStorage.setItem(
                "customer",
                JSON.stringify(updatedUser)
            );

            alert(
                "Profile updated successfully!"
            );

            loadProfile(updatedUser.email);

            document.getElementById("password").value = "";

        }catch(error){

            console.error(error);

            alert(
                "Failed to update profile."
            );
        }
    }

    function logout(){

        localStorage.removeItem("customer");

        window.location.href =
            "home.jsp";
    }

</script>

</body>
</html>