<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Management - Golden Reech</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/admin.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
        .sidebar-nav-item.active {
            background: linear-gradient(135deg, #ff9800, #ff6f00);
            color: #fff !important;
            border-radius: 12px;
            margin: 6px 10px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(255,152,0,0.3);
        }

        .sidebar-nav-item.active i {
            color: #fff !important;
        }

        .sidebar-nav-item {
            transition: 0.25s;
            border-radius: 12px;
            margin: 4px 10px;
        }

        .sidebar-nav-item:hover {
            background: #fff3e0;
            transform: translateX(4px);
        }

        .sidebar-nav-title {
            padding-left: 18px;
            margin-top: 18px;
            font-size: 12px;
            font-weight: 700;
            color: #ff9800;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
    </style>
</head>

<body>

<div class="admin-layout">

    <aside class="admin-sidebar">

        <div class="sidebar-header">
            <div class="sidebar-logo">
                <i class="fas fa-utensils"></i>
            </div>
            <h2>Admin Portal</h2>
        </div>

        <div class="sidebar-user">
            <div class="avatar">AD</div>
            <div class="info">
                <p class="name">Admin User</p>
                <p class="role">Restaurant Manager</p>
            </div>
        </div>

        <nav class="sidebar-nav">

            <p class="sidebar-nav-title">Main</p>

            <a href="admin-dashboard.jsp" class="sidebar-nav-item">
                <i class="fas fa-gauge-high"></i>
                <span>Dashboard</span>
            </a>

            <a href="reservations-admin.jsp" class="sidebar-nav-item active">
                <i class="fas fa-calendar-check"></i>
                <span>Reservations</span>
            </a>

            <a href="customers.jsp" class="sidebar-nav-item">
                <i class="fas fa-users"></i>
                <span>Customers</span>
            </a>

            <a href="tables.jsp" class="sidebar-nav-item">
                <i class="fas fa-chair"></i>
                <span>Tables</span>
            </a>

            <p class="sidebar-nav-title">Management</p>

            <a href="menu-management.jsp" class="sidebar-nav-item">
                <i class="fas fa-utensils"></i>
                <span>Menu</span>
            </a>

            <a href="staff.jsp" class="sidebar-nav-item">
                <i class="fas fa-user-tie"></i>
                <span>Staff</span>
            </a>

            <a href="offers-management.jsp" class="sidebar-nav-item">
                <i class="fas fa-tag"></i>
                <span>Offers</span>
            </a>

            <p class="sidebar-nav-title">Finance</p>

            <a href="payments.jsp" class="sidebar-nav-item">
                <i class="fas fa-credit-card"></i>
                <span>Payments</span>
            </a>

            <p class="sidebar-nav-title">Other</p>

            <a href="reviews-management.jsp" class="sidebar-nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>

            <a href="home.jsp" class="sidebar-nav-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>

        </nav>

    </aside>

    <main class="admin-main">

        <nav class="admin-navbar">
            <div class="navbar-left">
                <button class="sidebar-toggle" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>

                <div class="breadcrumb">
                    <a href="admin-dashboard.jsp">Dashboard</a>
                    <i class="fas fa-chevron-right" style="font-size:0.75rem;"></i>
                    <span>Reservations</span>
                </div>
            </div>

            <div class="navbar-right">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text"
                           id="reservationSearch"
                           placeholder="Search reservations..."
                           onkeyup="filterReservations()">
                </div>
            </div>
        </nav>

        <div class="admin-content">

            <div class="page-header">
                <h1>Reservation Management</h1>

                <div class="page-actions">
                    <button class="btn btn-outline" onclick="window.print()">
                        <i class="fas fa-print"></i>
                        Print
                    </button>
                </div>
            </div>

            <div class="stats-grid">

                <div class="stat-card primary">
                    <h3 id="totalReservations">0</h3>
                    <p>Total Reservations</p>
                </div>

                <div class="stat-card success">
                    <h3 id="confirmedReservations">0</h3>
                    <p>Confirmed</p>
                </div>

                <div class="stat-card warning">
                    <h3 id="pendingReservations">0</h3>
                    <p>Pending</p>
                </div>

                <div class="stat-card danger">
                    <h3 id="cancelledReservations">0</h3>
                    <p>Cancelled</p>
                </div>

            </div>

            <div class="data-table-container">

                <div class="table-header">
                    <h3>Reservations From Database</h3>

                    <select class="form-control"
                            id="statusFilter"
                            onchange="filterReservations()">
                        <option value="">All Status</option>
                        <option value="PENDING">Pending</option>
                        <option value="CONFIRMED">Confirmed</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>

                <div class="table-responsive">

                    <table class="data-table">

                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Email</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Guests</th>
                            <th>Table</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>

                        <tbody id="reservationsTableBody">
                        <tr>
                            <td colspan="9">Loading reservations...</td>
                        </tr>
                        </tbody>

                    </table>

                </div>

                <div class="table-footer">
                    <p id="footerText">Showing 0 reservations</p>
                </div>

            </div>

        </div>

    </main>

</div>

<script src="./js/main.js"></script>
<script src="./js/admin.js"></script>

<script>
    const API_BASE = "http://localhost:8080/api";

    let allReservations = [];

    document.addEventListener("DOMContentLoaded", loadReservations);

    async function loadReservations() {
        try {
            const response = await fetch(`${API_BASE}/reservations`);

            if (!response.ok) {
                throw new Error("Failed");
            }

            allReservations = await response.json();

            renderReservations(allReservations);
            updateStats(allReservations);

        } catch (error) {
            document.getElementById("reservationsTableBody").innerHTML =
                `<tr>
                    <td colspan="9">
                        Failed to load reservations. Make sure Spring Boot is running.
                    </td>
                </tr>`;
        }
    }

    function renderReservations(reservations) {
        const tbody = document.getElementById("reservationsTableBody");

        document.getElementById("footerText").textContent =
            `Showing ${reservations.length} reservations`;

        if (reservations.length === 0) {
            tbody.innerHTML =
                `<tr>
                    <td colspan="9">No reservations found.</td>
                </tr>`;
            return;
        }

        tbody.innerHTML = reservations.map(r => `
            <tr>
                <td>#${r.id}</td>
                <td>${r.customerName || "-"}</td>
                <td>${r.customerEmail || "-"}</td>
                <td>${formatDate(r.reservationDate)}</td>
                <td>${r.reservationTime || "-"}</td>
                <td>${r.numberOfGuests || 0}</td>
                <td>${r.tableNumber || "-"}</td>
                <td>
                    <span class="badge ${getStatusClass(r.status)}">
                        ${r.status || "PENDING"}
                    </span>
                </td>
                <td>
                    <div class="actions">
                        <button class="action-btn view"
                                onclick="viewReservation(${r.id})"
                                title="View">
                            <i class="fas fa-eye"></i>
                        </button>

                        <button class="action-btn edit"
                                onclick="updateReservationStatus(${r.id}, 'CONFIRMED')"
                                title="Confirm">
                            <i class="fas fa-check"></i>
                        </button>

                        <button class="action-btn delete"
                                onclick="updateReservationStatus(${r.id}, 'CANCELLED')"
                                title="Cancel">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </td>
            </tr>
        `).join("");
    }

    function updateStats(reservations) {
        document.getElementById("totalReservations").textContent =
            reservations.length;

        document.getElementById("confirmedReservations").textContent =
            reservations.filter(r => r.status === "CONFIRMED").length;

        document.getElementById("pendingReservations").textContent =
            reservations.filter(r => r.status === "PENDING").length;

        document.getElementById("cancelledReservations").textContent =
            reservations.filter(r => r.status === "CANCELLED").length;
    }

    function filterReservations() {
        const keyword =
            document.getElementById("reservationSearch").value.toLowerCase();

        const status =
            document.getElementById("statusFilter").value;

        const filtered = allReservations.filter(r => {
            const matchesKeyword =
                String(r.id || "").includes(keyword) ||
                (r.customerName || "").toLowerCase().includes(keyword) ||
                (r.customerEmail || "").toLowerCase().includes(keyword);

            const matchesStatus =
                status === "" || r.status === status;

            return matchesKeyword && matchesStatus;
        });

        renderReservations(filtered);
        updateStats(filtered);
    }

    function viewReservation(id) {
        const r = allReservations.find(r => r.id === id);

        if (!r) {
            return;
        }

        alert(
            "Reservation Details\n\n" +
            "ID: " + r.id + "\n" +
            "Customer: " + (r.customerName || "-") + "\n" +
            "Email: " + (r.customerEmail || "-") + "\n" +
            "Phone: " + (r.customerPhone || "-") + "\n" +
            "Date: " + (r.reservationDate || "-") + "\n" +
            "Time: " + (r.reservationTime || "-") + "\n" +
            "Guests: " + (r.numberOfGuests || 0) + "\n" +
            "Table: " + (r.tableNumber || "-") + "\n" +
            "Status: " + (r.status || "PENDING") + "\n" +
            "Special Request: " + (r.specialRequest || "-")
        );
    }

    async function updateReservationStatus(id, status) {
        if (!confirm(`Change reservation #${id} to ${status}?`)) {
            return;
        }

        try {
            const response = await fetch(
                `${API_BASE}/reservations/${id}/status?status=${status}`,
                {
                    method: "PUT"
                }
            );

            if (!response.ok) {
                throw new Error("Failed");
            }

            loadReservations();

        } catch (error) {
            alert("Failed to update reservation.");
        }
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
</script>

</body>
</html>