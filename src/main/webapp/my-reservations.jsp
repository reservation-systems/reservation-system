<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>

<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reservations - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
        body {
            background: #fff4dc;
        }

        .section {
            padding: 4rem 0;
            min-height: 60vh;
        }

        .reservation-controls {
            margin-bottom: 2rem;
        }

        .reservation-controls .form-control {
            width: 100%;
            padding: 14px 18px;
            border: 1.5px solid #ddd;
            border-radius: 12px;
            font-size: 0.95rem;
            outline: none;
            background: #fff;
        }

        .reservation-controls .form-control:focus {
            border-color: #F4A100;
            box-shadow: 0 0 0 3px rgba(244, 161, 0, 0.12);
        }

        #reservationContainer {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        .reservation-card {
            background: #fff;
            border-radius: 18px;
            padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .reservation-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 1rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
            margin-bottom: 1rem;
        }

        .reservation-header h3 {
            margin: 0 0 0.4rem;
            color: #1A0A00;
            font-size: 1.2rem;
        }

        .reservation-header p {
            margin: 0;
            color: #777;
            font-size: 0.9rem;
        }

        .reservation-body {
            display: grid;
            gap: 0.7rem;
            margin-bottom: 1.2rem;
        }

        .reservation-detail {
            display: flex;
            align-items: center;
            gap: 0.7rem;
            color: #444;
            font-size: 0.95rem;
        }

        .reservation-detail i {
            color: #F4A100;
            width: 18px;
            text-align: center;
        }

        .reservation-actions {
            display: flex;
            gap: 0.7rem;
            flex-wrap: wrap;
            border-top: 1px solid #eee;
            padding-top: 1rem;
        }

        .badge {
            padding: 0.4rem 0.75rem;
            border-radius: 999px;
            font-size: 0.72rem;
            font-weight: 700;
            white-space: nowrap;
        }

        .badge-confirmed {
            background: #d4edda;
            color: #155724;
        }

        .badge-pending {
            background: #fff3cd;
            color: #856404;
        }

        .badge-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .empty-state {
            grid-column: 1 / -1;
            background: #fff;
            padding: 3rem 2rem;
            border-radius: 18px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .empty-state i {
            font-size: 3rem;
            color: #F4A100;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            margin: 0 0 0.5rem;
            color: #1A0A00;
        }

        .empty-state p {
            color: #666;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 700px) {
            #reservationContainer {
                grid-template-columns: 1fr;
            }

            .reservation-header {
                flex-direction: column;
            }
        }
    </style>
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
            <a href="customer-dashboard.jsp" class="btn btn-outline btn-sm">
                <i class="fas fa-user"></i> Dashboard
            </a>

            <button class="btn btn-primary btn-sm" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>

    </div>
</nav>

<section class="page-banner">
    <div class="container">
        <h1>My Reservations</h1>
        <p>View and manage your Golden Reech table reservations</p>
    </div>
</section>

<section class="section">
    <div class="container">

        <div class="reservation-controls">
            <input type="text"
                   id="searchReservation"
                   class="form-control"
                   placeholder="Search reservations..."
                   onkeyup="filterReservations()">
        </div>

        <div id="reservationContainer">
            <p>Loading reservations...</p>
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

<script src="./js/main.js"></script>

<script>
    const API_BASE = "http://localhost:8080/api";

    let allReservations = [];

    document.addEventListener("DOMContentLoaded", function () {
        const customer = JSON.parse(localStorage.getItem("customer"));

        if (!customer) {
            alert("Please login first.");
            window.location.href = "login.jsp";
            return;
        }

        loadReservations(customer.email);
    });

    async function loadReservations(email) {
        const container = document.getElementById("reservationContainer");

        try {
            const response = await fetch(
                `${API_BASE}/reservations/customer?email=${encodeURIComponent(email)}`
            );

            if (!response.ok) {
                throw new Error("Failed to load reservations");
            }

            allReservations = await response.json();
            renderReservations(allReservations);

        } catch (error) {
            container.innerHTML =
                "<p>Failed to load reservations. Make sure Spring Boot is running.</p>";
        }
    }

    function renderReservations(reservations) {
        const container = document.getElementById("reservationContainer");

        if (!reservations || reservations.length === 0) {
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-calendar-times"></i>
                    <h3>No Reservations Found</h3>
                    <p>You have not made any reservations yet.</p>
                    <a href="reservation.jsp" class="btn btn-primary">
                        Book a Table
                    </a>
                </div>
            `;
            return;
        }

        container.innerHTML = reservations.map(function (r) {
            return `
                <div class="reservation-card">

                    <div class="reservation-header">
                        <div>
                            <h3>Reservation #${r.id}</h3>
                            <p>${formatDate(r.reservationDate)}</p>
                        </div>

                        <span class="badge ${getStatusClass(r.status)}">
                            ${r.status || "PENDING"}
                        </span>
                    </div>

                    <div class="reservation-body">

                        <div class="reservation-detail">
                            <i class="fas fa-calendar"></i>
                            <span>${r.reservationDate || "-"}</span>
                        </div>

                        <div class="reservation-detail">
                            <i class="fas fa-clock"></i>
                            <span>${r.reservationTime || "-"}</span>
                        </div>

                        <div class="reservation-detail">
                            <i class="fas fa-users"></i>
                            <span>${r.numberOfGuests || 0} Guests</span>
                        </div>

                        <div class="reservation-detail">
                            <i class="fas fa-chair"></i>
                            <span>Table ${getTableNumber(r)}</span>
                        </div>

                        <div class="reservation-detail">
                            <i class="fas fa-sticky-note"></i>
                            <span>${r.specialRequest || "No special requests"}</span>
                        </div>

                    </div>

                    <div class="reservation-actions">

                        <button class="btn btn-outline btn-sm"
                                onclick="viewReservation(${r.id})">
                            <i class="fas fa-eye"></i>
                            View
                        </button>

                        <button class="btn btn-primary btn-sm"
                                onclick="editReservation(${r.id})">
                            <i class="fas fa-edit"></i>
                            Edit
                        </button>

                        <button class="btn btn-outline btn-sm"
                                onclick="deleteReservation(${r.id})">
                            <i class="fas fa-trash"></i>
                            Delete
                        </button>

                    </div>

                </div>
            `;
        }).join("");
    }

    function filterReservations() {
        const keyword = document
            .getElementById("searchReservation")
            .value
            .toLowerCase();

        const filtered = allReservations.filter(function (r) {
            return String(r.id).includes(keyword) ||
                (r.status || "").toLowerCase().includes(keyword) ||
                (r.reservationDate || "").toLowerCase().includes(keyword) ||
                String(getTableNumber(r)).toLowerCase().includes(keyword);
        });

        renderReservations(filtered);
    }

    function viewReservation(id) {
        const reservation = allReservations.find(function (r) {
            return r.id === id;
        });

        if (!reservation) {
            return;
        }

        alert(
            "Golden Reech Reservation Details\n\n" +
            "ID: " + reservation.id + "\n" +
            "Date: " + (reservation.reservationDate || "-") + "\n" +
            "Time: " + (reservation.reservationTime || "-") + "\n" +
            "Guests: " + (reservation.numberOfGuests || 0) + "\n" +
            "Status: " + (reservation.status || "PENDING") + "\n" +
            "Table: " + getTableNumber(reservation)
        );
    }

    function editReservation(id) {
        window.location.href = "reservation.jsp?editId=" + id;
    }

    async function deleteReservation(id) {
        if (!confirm("Delete this reservation?")) {
            return;
        }

        try {
            const response = await fetch(
                `${API_BASE}/reservations/${id}`,
                {
                    method: "DELETE"
                }
            );

            if (!response.ok) {
                throw new Error("Failed to delete reservation");
            }

            const customer = JSON.parse(localStorage.getItem("customer"));
            loadReservations(customer.email);

        } catch (error) {
            alert("Failed to delete reservation.");
        }
    }

    function getTableNumber(r) {
        if (r.tableNumber) {
            return r.tableNumber;
        }

        if (r.table && r.table.tableNumber) {
            return r.table.tableNumber;
        }

        if (r.restaurantTable && r.restaurantTable.tableNumber) {
            return r.restaurantTable.tableNumber;
        }

        if (r.table && r.table.number) {
            return r.table.number;
        }

        if (r.tableId) {
            return r.tableId;
        }

        return "-";
    }

    function getStatusClass(status) {
        if (status === "CONFIRMED") {
            return "badge-confirmed";
        }

        if (status === "CANCELLED") {
            return "badge-cancelled";
        }

        return "badge-pending";
    }

    function formatDate(date) {
        if (!date) {
            return "-";
        }

        return new Date(date).toLocaleDateString();
    }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>

</body>
</html>