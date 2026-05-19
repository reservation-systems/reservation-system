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

    <title>My Dashboard - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet"
          href="./css/style.css">

    <link rel="stylesheet"
          href="./css/customer.css">

    <link rel="stylesheet"
          href="./css/responsive.css">

    <style>

        body{
            background:#fff4dc;
        }

        .dashboard-page{
            padding:3rem 0;
            min-height:100vh;
        }

        .dashboard-content{
            max-width:1200px;
            margin:0 auto;
        }

        .welcome-section{
            background:#fff;
            padding:2rem;
            border-radius:20px;
            box-shadow:0 4px 20px rgba(0,0,0,0.08);
            margin-bottom:1.5rem;
        }

        .welcome-section h1{
            margin:0 0 0.5rem;
            font-size:2rem;
            color:#1A0A00;
        }

        .welcome-section span{
            color:#F4A100;
        }

        .welcome-section p{
            margin:0;
            color:#666;
        }

        .dashboard-grid{
            display:grid;
            grid-template-columns:repeat(2,1fr);
            gap:1.5rem;
            margin-bottom:1.5rem;
        }

        .dashboard-card{
            background:#fff;
            padding:1.5rem;
            border-radius:18px;
            box-shadow:0 4px 20px rgba(0,0,0,0.08);
            display:flex;
            align-items:center;
            gap:1rem;
        }

        .dashboard-card .icon{
            width:70px;
            height:70px;
            border-radius:16px;
            background:linear-gradient(135deg,#F4A100,#C97D00);
            display:flex;
            align-items:center;
            justify-content:center;
            color:#fff;
            font-size:1.8rem;
        }

        .dashboard-card .info h3{
            margin:0;
            font-size:2rem;
            color:#1A0A00;
        }

        .dashboard-card .info p{
            margin:0;
            color:#666;
        }

        .dashboard-sections{
            display:grid;
            grid-template-columns:2fr 1fr;
            gap:1.5rem;
        }

        .dashboard-section{
            background:#fff;
            border-radius:18px;
            overflow:hidden;
            box-shadow:0 4px 20px rgba(0,0,0,0.08);
        }

        .section-header{
            padding:1rem 1.5rem;
            border-bottom:1px solid #eee;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .section-header h3{
            margin:0;
            color:#1A0A00;
            display:flex;
            align-items:center;
            gap:8px;
        }

        .section-body{
            padding:1.5rem;
        }

        .quick-links{
            display:grid;
            grid-template-columns:repeat(2,1fr);
            gap:1rem;
        }

        .quick-link{
            background:#fff4dc;
            border-radius:14px;
            padding:1rem;
            text-decoration:none;
            color:#1A0A00;
            display:flex;
            align-items:center;
            gap:10px;
            font-weight:600;
            transition:0.2s;
        }

        .quick-link:hover{
            background:#F4A100;
            color:#fff;
            transform:translateY(-2px);
        }

        .quick-link i{
            color:#F4A100;
        }

        .quick-link:hover i{
            color:#fff;
        }

        .reservation-item{
            padding:1rem;
            border:1px solid #eee;
            border-radius:14px;
            margin-bottom:1rem;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .reservation-item:last-child{
            margin-bottom:0;
        }

        .reservation-info h4{
            margin:0 0 0.4rem;
            color:#1A0A00;
        }

        .reservation-info p{
            margin:0;
            color:#666;
            font-size:0.9rem;
        }

        .badge{
            padding:0.4rem 0.8rem;
            border-radius:999px;
            font-size:0.75rem;
            font-weight:700;
        }

        .badge-confirmed{
            background:#d4edda;
            color:#155724;
        }

        .badge-pending{
            background:#fff3cd;
            color:#856404;
        }

        .badge-cancelled{
            background:#f8d7da;
            color:#721c24;
        }

        .offer-card{
            background:#fff4dc;
            border-radius:14px;
            padding:1rem;
            margin-bottom:1rem;
        }

        .offer-card:last-child{
            margin-bottom:0;
        }

        .offer-card small{
            color:#666;
        }

        .offer-card h4{
            margin:0.3rem 0;
            color:#F4A100;
        }

        @media(max-width:900px){

            .dashboard-grid,
            .dashboard-sections{
                grid-template-columns:1fr;
            }

            .quick-links{
                grid-template-columns:1fr;
            }
        }

    </style>

</head>

<body>

<nav class="customer-navbar">

    <div class="navbar-container">

        <a href="home.jsp"
           class="logo">

            <i class="fas fa-utensils"></i>
            <span>Golden Reech</span>

        </a>

        <ul class="nav-menu">

            <li><a href="home.jsp" class="nav-link">Home</a></li>

            <li><a href="menu.jsp" class="nav-link">Menu</a></li>

            <li><a href="offers.jsp" class="nav-link">Offers</a></li>

            <li><a href="reservation.jsp" class="nav-link">Book a Table</a></li>

            <li><a href="reviews.jsp" class="nav-link active">Reviews</a></li>

        </ul>

        <div class="nav-actions">

            <a href="customer-dashboard.jsp"
               class="btn btn-outline btn-sm active">

                <i class="fas fa-user"></i>
                My Account

            </a>

            <a href="home.jsp"
               class="btn btn-primary btn-sm"
               onclick="logout()">

                <i class="fas fa-sign-out-alt"></i>
                Logout

            </a>

        </div>

    </div>

</nav>

<div class="dashboard-page">

    <div class="container">

        <div class="dashboard-content">

            <div class="welcome-section">

                <h1>
                    Welcome back,
                    <span id="customerName">Customer</span>!
                </h1>

                <p>
                    Your dashboard data is loaded from the database.
                </p>

            </div>

            <div class="dashboard-grid">

                <div class="dashboard-card">

                    <div class="icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>

                    <div class="info">
                        <h3 id="reservationCount">0</h3>
                        <p>My Reservations</p>
                    </div>

                </div>

                <div class="dashboard-card">

                    <div class="icon"
                         style="background:linear-gradient(135deg,#3498db,#2980b9);">

                        <i class="fas fa-ticket-alt"></i>

                    </div>

                    <div class="info">
                        <h3 id="offerCount">0</h3>
                        <p>Active Offers</p>
                    </div>

                </div>

            </div>

            <div class="dashboard-sections">

                <div class="left-column">

                    <div class="dashboard-section"
                         style="margin-bottom:1.5rem;">

                        <div class="section-header">

                            <h3>
                                <i class="fas fa-link"></i>
                                Quick Links
                            </h3>

                        </div>

                        <div class="section-body">

                            <div class="quick-links">

                                <a href="reservation.jsp"
                                   class="quick-link">

                                    <i class="fas fa-calendar-plus"></i>
                                    <span>New Reservation</span>

                                </a>

                                <a href="my-reservations.jsp"
                                   class="quick-link">

                                    <i class="fas fa-list"></i>
                                    <span>My Reservations</span>

                                </a>

                                <a href="menu.jsp"
                                   class="quick-link">

                                    <i class="fas fa-utensils"></i>
                                    <span>Browse Menu</span>

                                </a>

                                <a href="offers.jsp"
                                   class="quick-link">

                                    <i class="fas fa-tag"></i>
                                    <span>Offers</span>

                                </a>

                                <a href="profile.jsp"
                                   class="quick-link">

                                    <i class="fas fa-user-cog"></i>
                                    <span>Profile</span>

                                </a>

                            </div>

                        </div>

                    </div>

                    <div class="dashboard-section">

                        <div class="section-header">

                            <h3>
                                <i class="fas fa-clock"></i>
                                Recent Reservations
                            </h3>

                            <a href="my-reservations.jsp"
                               class="btn btn-sm btn-outline">

                                View All
                            </a>

                        </div>

                        <div class="section-body">

                            <div class="reservation-list"
                                 id="reservationList">

                                <p>Loading reservations...</p>

                            </div>

                        </div>

                    </div>

                </div>

                <div class="right-column">

                    <div class="dashboard-section">

                        <div class="section-header">

                            <h3>
                                <i class="fas fa-tag"></i>
                                Active Offers
                            </h3>

                        </div>

                        <div class="section-body">

                            <div id="offersList"
                                 style="display:flex;flex-direction:column;gap:1rem;">

                                <p>Loading offers...</p>

                            </div>

                            <a href="offers.jsp"
                               style="display:block;text-align:center;margin-top:1rem;color:#F4A100;font-size:0.9rem;">

                                View All Offers

                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

<footer class="customer-footer">

    <div class="footer-content">

        <div class="footer-section">

            <h3>About Us</h3>

            <p>
                Golden Reech is a modern restaurant offering delicious meals,
                excellent customer service, and a relaxing dining experience.
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

                <li><i class="fas fa-phone"></i> +94 77 568 4650</li>

                <li><i class="fas fa-phone"></i> +94 75 457 6071</li>

                <li><i class="fas fa-envelope"></i> info@goldenreech.com</li>

            </ul>

        </div>

    </div>

    <div class="footer-bottom">

        <p>&copy; 2024 Golden Reech. All rights reserved.</p>

    </div>

</footer>

<script>

    const API_BASE = "http://localhost:8080/api";

    document.addEventListener(
        "DOMContentLoaded",
        loadCustomerDashboard
    );

    async function loadCustomerDashboard() {

        const customer =
            JSON.parse(localStorage.getItem("customer"));

        if (!customer || !customer.email) {

            alert("Please login first.");

            window.location.href =
                "login.jsp";

            return;
        }

        document.getElementById("customerName").textContent =
            customer.name || customer.email;

        await loadReservations(customer.email);

        await loadOffers();
    }

    async function loadReservations(email) {

        const reservationList =
            document.getElementById("reservationList");

        try {

            const response = await fetch(
                `${API_BASE}/reservations/customer?email=${encodeURIComponent(email)}`
            );

            const reservations =
                await response.json();

            document.getElementById("reservationCount").textContent =
                reservations.length;

            if (reservations.length === 0) {

                reservationList.innerHTML =
                    "<p>No reservations found in database.</p>";

                return;
            }

            reservationList.innerHTML =
                reservations.slice(-3).reverse().map(r => `
                <div class="reservation-item">
                    <div class="reservation-info">
                        <h4>Reservation #${r.id}</h4>

                        <p>
                            <i class="fas fa-calendar"></i>
                            ${r.reservationDate || "-"}

                            |

                            <i class="fas fa-clock"></i>
                            ${r.reservationTime || "-"}

                            |

                            <i class="fas fa-users"></i>
                            ${r.numberOfGuests || 0} guests
                        </p>
                    </div>

                    <span class="badge ${getStatusClass(r.status)}">
                        ${r.status || "PENDING"}
                    </span>
                </div>
            `).join("");

        } catch (error) {

            reservationList.innerHTML =
                "<p>Failed to load reservations.</p>";
        }
    }

    async function loadOffers() {

        const offersList =
            document.getElementById("offersList");

        try {

            const response =
                await fetch(`${API_BASE}/offers/active`);

            const offers =
                await response.json();

            document.getElementById("offerCount").textContent =
                offers.length;

            if (offers.length === 0) {

                offersList.innerHTML =
                    "<p>No active offers found in database.</p>";

                return;
            }

            offersList.innerHTML = offers.map(o => `
            <div class="offer-card">

                <small>${o.title || "Offer"}</small>

                <h4>${o.discountPercentage || 0}% OFF</h4>

                <p style="margin:0.4rem 0;color:#555;">
                    ${o.description || ""}
                </p>

                <span class="badge badge-confirmed">
                    Active
                </span>

            </div>
        `).join("");

        } catch (error) {

            offersList.innerHTML =
                "<p>Failed to load offers.</p>";
        }
    }

    function getStatusClass(status) {

        if (status === "CONFIRMED")
            return "badge-confirmed";

        if (status === "CANCELLED")
            return "badge-cancelled";

        return "badge-pending";
    }

    function logout() {

        localStorage.removeItem("customer");

        window.location.href =
            "home.jsp";
    }

</script>

</body>
</html>