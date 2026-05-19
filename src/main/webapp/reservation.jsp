<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Reservation - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>

        .reservation-layout {
            display: grid;
            grid-template-columns: 1fr 420px;
            gap: 28px;
            align-items: start;
        }

        @media (max-width: 1024px) {
            .reservation-layout {
                grid-template-columns: 1fr;
            }
        }

        .reservation-form-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 2rem;
            box-shadow: 0 2px 20px rgba(0,0,0,0.07);
        }

        .reservation-form-card h2 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #1A0A00;
            margin: 0 0 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .reservation-form-card h2 i { color: #F4A100; }

        .form-group { margin-bottom: 1.1rem; }

        .form-label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #555;
            margin-bottom: 6px;
        }

        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #e8e8e8;
            border-radius: 10px;
            font-size: 0.93rem;
            color: #1A0A00;
            background: #fafafa;
            transition: border-color 0.2s, box-shadow 0.2s;
            box-sizing: border-box;
            outline: none;
        }

        .form-control:focus {
            border-color: #F4A100;
            box-shadow: 0 0 0 3px rgba(244,161,0,0.12);
            background: #fff;
        }

        .form-control[readonly] {
            background: #FFF3DC;
            border-color: #FFD060;
            color: #F4A100;
            font-weight: 600;
            cursor: default;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 90px;
        }

        .btn-submit {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #F4A100, #C97D00);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            transition: transform 0.18s, box-shadow 0.18s;
            margin-top: 0.5rem;
            box-shadow: 0 4px 16px rgba(244,161,0,0.28);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 22px rgba(244,161,0,0.38);
        }

        .btn-submit:disabled {
            opacity: 0.55;
            cursor: not-allowed;
            transform: none;
        }

        .panels-column {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .side-panel {
            background: #ffffff;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 2px 16px rgba(0,0,0,0.08);
        }

        .panel-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 0.35rem;
        }

        .panel-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1A0A00;
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0;
        }

        .panel-title i { color: #F4A100; }

        .panel-sub {
            font-size: 0.82rem;
            color: #999;
            margin: 0 0 1rem;
        }

        .refresh-btn {
            background: none;
            border: 1.5px solid #F4A100;
            color: #F4A100;
            border-radius: 8px;
            padding: 4px 11px;
            font-size: 0.78rem;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .refresh-btn:hover {
            background: #F4A100;
            color: #fff;
        }

        .selected-hint {
            margin-top: 10px;
            background: #FFF3DC;
            border: 1.5px solid #ffb87a;
            border-radius: 10px;
            padding: 8px 12px;
            font-size: 0.82rem;
            color: #A06800;
            font-weight: 600;
            display: none;
            align-items: center;
            gap: 7px;
        }

        .selected-hint i { color: #F4A100; }

        .panel-legend {
            display: flex;
            gap: 14px;
            margin-top: 0.9rem;
            font-size: 0.78rem;
            color: #888;
            flex-wrap: wrap;
        }

        .legend-dot {
            width: 9px;
            height: 9px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 4px;
        }

        .legend-dot.avail  { background: #F4A100; }
        .legend-dot.occup  { background: #ccc; }
        .legend-dot.sel    { background: #1a1a1a; }

        .tables-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 9px;
        }

        .table-card {
            border: 2px solid #e8e8e8;
            border-radius: 12px;
            padding: 11px 8px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
            background: #fafafa;
            position: relative;
        }

        .table-card.available {
            border-color: #F4A100;
            background: #FFF3DC;
        }

        .table-card.available:hover {
            background: #F4A100;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 4px 14px rgba(244,161,0,0.28);
        }

        .table-card.available:hover .t-icon,
        .table-card.available:hover .t-num,
        .table-card.available:hover .t-cap,
        .table-card.available:hover .t-status { color: #fff; }

        .table-card.occupied {
            border-color: #e0e0e0;
            background: #f5f5f5;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .table-card.selected {
            background: #F4A100;
            border-color: #F4A100;
            box-shadow: 0 4px 14px rgba(244,161,0,0.35);
        }

        .table-card.selected .t-icon,
        .table-card.selected .t-num,
        .table-card.selected .t-cap,
        .table-card.selected .t-status { color: #fff; }

        .t-icon  { font-size: 1.4rem; color: #F4A100; margin-bottom: 3px; display: block; }
        .t-num   { font-weight: 700; font-size: 0.88rem; color: #1A0A00; display: block; }
        .t-cap   { font-size: 0.74rem; color: #888; display: block; margin-top: 2px; }
        .t-status { font-size: 0.7rem; font-weight: 600; margin-top: 4px; display: block; }

        .table-card.available .t-status { color: #F4A100; }
        .table-card.occupied  .t-status { color: #bbb; }
        .table-card.occupied  .t-icon   { color: #ccc; }

        .menu-panel-locked {
            text-align: center;
            padding: 1.6rem 1rem;
            color: #bbb;
        }

        .menu-panel-locked i {
            font-size: 2rem;
            display: block;
            margin-bottom: 8px;
            color: #ddd;
        }

        .menu-panel-locked p {
            font-size: 0.84rem;
            margin: 0;
            line-height: 1.5;
        }

        .menu-search {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #f5f5f5;
            border: 1.5px solid #e8e8e8;
            border-radius: 10px;
            padding: 7px 12px;
            margin-bottom: 10px;
        }

        .menu-search i { color: #bbb; font-size: 0.88rem; }

        .menu-search input {
            border: none;
            background: transparent;
            outline: none;
            font-size: 0.85rem;
            color: #1A0A00;
            width: 100%;
        }

        .menu-categories {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }

        .cat-btn {
            padding: 4px 12px;
            border-radius: 999px;
            border: 1.5px solid #e8e8e8;
            background: #fafafa;
            font-size: 0.76rem;
            font-weight: 600;
            color: #888;
            cursor: pointer;
            transition: 0.18s;
        }

        .cat-btn:hover, .cat-btn.active {
            background: #F4A100;
            border-color: #F4A100;
            color: #fff;
        }

        .menu-items-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
            max-height: 340px;
            overflow-y: auto;
            padding-right: 3px;
        }

        .menu-items-list::-webkit-scrollbar { width: 4px; }
        .menu-items-list::-webkit-scrollbar-track { background: #f5f5f5; border-radius: 4px; }
        .menu-items-list::-webkit-scrollbar-thumb { background: #FFD060; border-radius: 4px; }

        .menu-item-card {
            display: flex;
            align-items: center;
            gap: 10px;
            border: 1.5px solid #efefef;
            border-radius: 12px;
            padding: 9px 11px;
            cursor: pointer;
            transition: all 0.18s;
            background: #fafafa;
            position: relative;
        }

        .menu-item-card:hover {
            border-color: #F4A100;
            background: #FFF3DC;
            transform: translateX(2px);
        }

        .menu-item-card.selected-menu {
            border-color: #F4A100;
            background: linear-gradient(135deg, #fff5ec, #fff);
            box-shadow: 0 2px 10px rgba(244,161,0,0.15);
        }

        .menu-item-thumb {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            background: #f0f0f0;
            flex-shrink: 0;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }

        .menu-item-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .menu-item-info { flex: 1; min-width: 0; }

        .menu-item-name {
            font-weight: 700;
            font-size: 0.85rem;
            color: #1A0A00;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .menu-item-cat { font-size: 0.72rem; color: #aaa; margin-top: 1px; }

        .menu-item-price {
            font-size: 0.88rem;
            font-weight: 700;
            color: #F4A100;
            flex-shrink: 0;
        }

        .menu-item-check {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 2px solid #e0e0e0;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            color: transparent;
            transition: 0.18s;
            background: #fff;
        }

        .menu-item-card.selected-menu .menu-item-check {
            background: #F4A100;
            border-color: #F4A100;
            color: #fff;
        }

        .qty-stepper {
            display: none;
            align-items: center;
            gap: 4px;
            flex-shrink: 0;
        }

        .menu-item-card.selected-menu .qty-stepper { display: flex; }
        .menu-item-card.selected-menu .menu-item-check { display: none; }

        .qty-btn {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            border: none;
            background: #F4A100;
            color: #fff;
            font-size: 0.9rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            line-height: 1;
            transition: 0.15s;
        }

        .qty-btn:hover { background: #A06800; }

        .qty-num {
            font-size: 0.85rem;
            font-weight: 700;
            color: #1A0A00;
            min-width: 18px;
            text-align: center;
        }

        .order-summary {
            margin-top: 10px;
            background: #FFF3DC;
            border: 1.5px solid #FFD060;
            border-radius: 10px;
            padding: 10px 13px;
            display: none;
        }

        .order-summary-title {
            font-size: 0.8rem;
            font-weight: 700;
            color: #A06800;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .order-summary-list { font-size: 0.78rem; color: #555; line-height: 1.7; }

        .order-total {
            margin-top: 6px;
            padding-top: 6px;
            border-top: 1px dashed #FFD060;
            font-size: 0.85rem;
            font-weight: 700;
            color: #F4A100;
            display: flex;
            justify-content: space-between;
        }

        .panel-loading {
            text-align: center;
            padding: 1.8rem 0;
            color: #bbb;
            font-size: 0.88rem;
        }

        .panel-loading i {
            font-size: 1.6rem;
            display: block;
            margin-bottom: 8px;
            animation: spin 1s linear infinite;
            color: #F4A100;
        }

        .panel-empty {
            text-align: center;
            padding: 1.8rem 0;
            color: #ccc;
            font-size: 0.85rem;
        }

        .panel-empty i { font-size: 2rem; display: block; margin-bottom: 8px; }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to   { transform: rotate(360deg); }
        }

        .form-section-label {
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #bbb;
            margin: 1.2rem 0 0.7rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-section-label::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #f0f0f0;
        }

        .menu-summary-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #FFF3DC;
            border: 1.5px solid #FFD060;
            border-radius: 999px;
            padding: 4px 12px;
            font-size: 0.8rem;
            color: #F4A100;
            font-weight: 600;
            margin: 2px 2px 2px 0;
        }

        /* Payment notice banner */
        .payment-notice {
            display: none;
            margin-top: 12px;
            background: #fff8e1;
            border: 1.5px solid #ffe082;
            border-radius: 10px;
            padding: 10px 14px;
            font-size: 0.84rem;
            color: #7a5800;
        }

        .payment-notice i { color: #f59e0b; margin-right: 6px; }

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
            <li><a href="home.jsp"        class="nav-link">Home</a></li>
            <li><a href="menu.jsp"        class="nav-link">Menu</a></li>
            <li><a href="offers.jsp"      class="nav-link">Offers</a></li>
            <li><a href="reservation.jsp" class="nav-link active">Book a Table</a></li>
            <li><a href="reviews.jsp"     class="nav-link">Reviews</a></li>
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
        <h1>Book a Table</h1>
        <p>Reserve your table and pre-order your favourite dishes</p>
    </div>
</section>

<section class="section">
    <div class="container">

        <div class="reservation-layout">

            <!-- LEFT — RESERVATION FORM -->
            <div class="reservation-form-card">

                <h2><i class="fas fa-calendar-check"></i> Reservation Details</h2>

                <form id="reservationForm">

                    <p class="form-section-label">Your Info</p>

                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <input type="text" id="customerName" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <input type="email" id="customerEmail" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <input type="text" id="customerPhone" class="form-control" required>
                    </div>

                    <p class="form-section-label">Date &amp; Time</p>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Reservation Date</label>
                            <input type="date" id="reservationDate" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Reservation Time</label>
                            <input type="time" id="reservationTime" class="form-control" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Number of Guests</label>
                            <input type="number" id="numberOfGuests" class="form-control" min="1" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Selected Table</label>
                            <input type="number" id="tableNumber" class="form-control" min="1"
                                   placeholder="Select from panel &#8594;" readonly>
                        </div>
                    </div>

                    <p class="form-section-label">Pre-order Menu</p>

                    <div class="form-group">
                        <label class="form-label">Selected Items</label>
                        <div id="menuSummaryInForm" style="padding:4px 0;">
                            <span style="color:#bbb;font-size:0.85rem;">No items selected — pick from the panel &#8594;</span>
                        </div>
                    </div>

                    <!-- Payment notice shown when menu items selected -->
                    <div class="payment-notice" id="paymentNotice">
                        <i class="fas fa-info-circle"></i>
                        <strong>Pre-order detected!</strong> You will be taken to the payment page to pay
                        <strong>30% of your menu bill</strong> as a deposit. You can also apply an offer code there.
                    </div>

                    <div class="form-group" style="margin-top:1rem;">
                        <label class="form-label">Special Request</label>
                        <textarea id="specialRequest" class="form-control"
                                  rows="3" placeholder="Dietary requirements, allergies, preferences..."></textarea>
                    </div>

                    <button type="submit" class="btn-submit" id="submitBtn">
                        <i class="fas fa-calendar-check"></i>
                        Confirm Reservation
                    </button>

                </form>

            </div>

            <!-- RIGHT — PANELS COLUMN -->
            <div class="panels-column">

                <!-- TABLE SELECTION PANEL -->
                <div class="side-panel">

                    <div class="panel-header">
                        <h3 class="panel-title">
                            <i class="fas fa-chair"></i> Available Tables
                        </h3>
                        <button class="refresh-btn" onclick="loadTables()">
                            <i class="fas fa-rotate-right"></i> Refresh
                        </button>
                    </div>

                    <p class="panel-sub">Click a table to select it. Menu unlocks after selection.</p>

                    <div id="tablesContainer">
                        <div class="panel-loading">
                            <i class="fas fa-spinner"></i>
                            Loading tables...
                        </div>
                    </div>

                    <div class="panel-legend">
                        <span><span class="legend-dot avail"></span> Available</span>
                        <span><span class="legend-dot occup"></span> Occupied</span>
                        <span><span class="legend-dot sel"></span> Selected</span>
                    </div>

                    <div class="selected-hint" id="tableHint">
                        <i class="fas fa-circle-check"></i>
                        <span id="tableHintText">Table selected</span>
                    </div>

                </div>

                <!-- MENU SELECTION PANEL -->
                <div class="side-panel">

                    <div class="panel-header">
                        <h3 class="panel-title">
                            <i class="fas fa-bowl-food"></i> Pre-order Menu
                        </h3>
                        <button class="refresh-btn" onclick="loadMenuItems()" id="menuRefreshBtn" style="display:none;">
                            <i class="fas fa-rotate-right"></i> Refresh
                        </button>
                    </div>

                    <p class="panel-sub">Select items to add to your reservation order.</p>

                    <div id="menuPanelBody">
                        <div class="menu-panel-locked" id="menuLocked">
                            <i class="fas fa-lock"></i>
                            <p>Select a table first<br>to unlock menu pre-ordering</p>
                        </div>
                    </div>

                    <div class="order-summary" id="orderSummary">
                        <div class="order-summary-title">
                            <i class="fas fa-receipt"></i> Order Summary
                        </div>
                        <div class="order-summary-list" id="orderSummaryList"></div>
                        <div class="order-total">
                            <span>Total</span>
                            <span id="orderTotal">Rs. 0.00</span>
                        </div>
                        <div style="margin-top:6px;padding-top:6px;border-top:1px dashed #FFD060;font-size:0.8rem;color:#888;">
                            Deposit required (30%): <strong style="color:#F4A100;" id="depositAmount">Rs. 0.00</strong>
                        </div>
                    </div>

                </div>

            </div>

        </div>

    </div>
</section>

<footer class="customer-footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>About Us</h3>
            <p>Golden Reech is a modern restaurant offering delicious meals,
                excellent customer service, and a relaxing dining experience
                for families, couples, and friends.</p>
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

    var API_BASE = "http://localhost:8080/api";

    /* STATE */
    var selectedTableNumber   = null;
    var selectedTableCapacity = null;
    var allMenuItems          = [];
    var selectedMenuItems     = {};   /* { id: { item, qty } } */
    var activeCategory        = "All";
    var menuTotal             = 0;

    /* ON LOAD */
    document.addEventListener("DOMContentLoaded", function() {
        fillCustomerData();
        loadTables();
    });

    /* FILL CUSTOMER FROM localStorage */
    function fillCustomerData() {
        var customer = JSON.parse(localStorage.getItem("customer") || "null");
        if (customer) {
            document.getElementById("customerName").value  = customer.fullName || "";
            document.getElementById("customerEmail").value = customer.email    || "";
            document.getElementById("customerPhone").value = customer.phone    || "";
        }
    }

    /* LOAD TABLES */
    async function loadTables() {
        var container = document.getElementById("tablesContainer");
        container.innerHTML =
            '<div class="panel-loading">' +
            '<i class="fas fa-spinner"></i>Loading tables...</div>';

        try {
            var res    = await fetch(API_BASE + "/tables");
            if (!res.ok) { throw new Error("fail"); }
            var tables = await res.json();

            if (!tables || tables.length === 0) {
                container.innerHTML =
                    '<div class="panel-empty">' +
                    '<i class="fas fa-chair"></i>No tables found.</div>';
                return;
            }

            renderTables(tables);

        } catch (e) {
            container.innerHTML =
                '<div class="panel-empty">' +
                '<i class="fas fa-triangle-exclamation"></i>' +
                'Could not load tables.<br>' +
                '<button onclick="loadTables()" style="margin-top:10px;padding:5px 14px;border:1.5px solid #F4A100;background:none;color:#F4A100;border-radius:8px;cursor:pointer;font-size:0.8rem;">Try Again</button>' +
                '</div>';
        }
    }

    function renderTables(tables) {
        var container = document.getElementById("tablesContainer");
        var html = '<div class="tables-grid">';

        for (var i = 0; i < tables.length; i++) {
            var t         = tables[i];
            var isAvail   = t.status === "AVAILABLE" || t.available === true;
            var cardClass = isAvail ? "available" : "occupied";
            var statusTxt = isAvail ? "Available"  : "Occupied";
            var capacity  = t.capacity || t.seatingCapacity || "?";
            var tableNum  = t.tableNumber || t.id;
            var onclick   = isAvail
                ? 'onclick="selectTable(' + tableNum + ', ' + capacity + ')"'
                : "";

            html +=
                '<div class="table-card ' + cardClass + '" ' + onclick + ' id="tcard-' + tableNum + '">' +
                '<span class="t-icon"><i class="fas fa-utensils"></i></span>' +
                '<span class="t-num">Table ' + tableNum + '</span>' +
                '<span class="t-cap"><i class="fas fa-users"></i> ' + capacity + ' seats</span>' +
                '<span class="t-status">' + statusTxt + '</span>' +
                '</div>';
        }

        html += '</div>';
        container.innerHTML = html;

        if (selectedTableNumber !== null) {
            applyTableHighlight(selectedTableNumber);
        }
    }

    function selectTable(tableNum, capacity) {
        var wasAlreadySelected = (selectedTableNumber !== null);
        selectedTableNumber   = tableNum;
        selectedTableCapacity = capacity;

        document.getElementById("tableNumber").value = tableNum;
        applyTableHighlight(tableNum);

        document.getElementById("tableHintText").textContent =
            "Table " + tableNum + " selected  (" + capacity + " seats)";
        document.getElementById("tableHint").style.display = "flex";

        if (!wasAlreadySelected) {
            unlockMenuPanel();
        }
    }

    function applyTableHighlight(tableNum) {
        var cards = document.querySelectorAll(".table-card");
        for (var i = 0; i < cards.length; i++) {
            cards[i].classList.remove("selected");
        }
        var target = document.getElementById("tcard-" + tableNum);
        if (target) { target.classList.add("selected"); }
    }

    /* MENU PANEL — UNLOCK */
    function unlockMenuPanel() {
        document.getElementById("menuRefreshBtn").style.display = "flex";
        loadMenuItems();
    }

    /* LOAD MENU ITEMS */
    async function loadMenuItems() {
        var body = document.getElementById("menuPanelBody");

        body.innerHTML =
            '<div class="panel-loading">' +
            '<i class="fas fa-spinner"></i>Loading menu...</div>';

        try {
            var res  = await fetch(API_BASE + "/menu");
            if (!res.ok) { throw new Error("fail"); }
            allMenuItems = await res.json();

            if (!allMenuItems || allMenuItems.length === 0) {
                body.innerHTML =
                    '<div class="panel-empty">' +
                    '<i class="fas fa-bowl-food"></i>No menu items found.</div>';
                return;
            }

            activeCategory = "All";
            renderMenuPanel();

        } catch (e) {
            body.innerHTML =
                '<div class="panel-empty">' +
                '<i class="fas fa-triangle-exclamation"></i>' +
                'Could not load menu.<br>' +
                '<button onclick="loadMenuItems()" style="margin-top:10px;padding:5px 14px;border:1.5px solid #F4A100;background:none;color:#F4A100;border-radius:8px;cursor:pointer;font-size:0.8rem;">Try Again</button>' +
                '</div>';
        }
    }

    function renderMenuPanel() {
        var body = document.getElementById("menuPanelBody");

        var cats = ["All"];
        for (var i = 0; i < allMenuItems.length; i++) {
            var cat = allMenuItems[i].category || allMenuItems[i].categoryName || "Other";
            if (cats.indexOf(cat) === -1) { cats.push(cat); }
        }

        var catHtml = "";
        for (var c = 0; c < cats.length; c++) {
            var active = cats[c] === activeCategory ? " active" : "";
            catHtml +=
                '<button class="cat-btn' + active + '" onclick="filterCategory(\'' + escQ(cats[c]) + '\')">' +
                cats[c] + '</button>';
        }

        body.innerHTML =
            '<div class="menu-search">' +
            '<i class="fas fa-magnifying-glass"></i>' +
            '<input type="text" id="menuSearchInput" placeholder="Search dishes..." oninput="applyMenuFilter()">' +
            '</div>' +
            '<div class="menu-categories">' + catHtml + '</div>' +
            '<div class="menu-items-list" id="menuItemsList"></div>';

        applyMenuFilter();
    }

    function filterCategory(cat) {
        activeCategory = cat;
        renderMenuPanel();
    }

    function applyMenuFilter() {
        var searchEl = document.getElementById("menuSearchInput");
        var q        = searchEl ? searchEl.value.toLowerCase() : "";
        var list     = document.getElementById("menuItemsList");
        if (!list) { return; }

        var filtered = [];
        for (var i = 0; i < allMenuItems.length; i++) {
            var item    = allMenuItems[i];
            var cat     = item.category || item.categoryName || "Other";
            var name    = (item.name || item.itemName || "").toLowerCase();
            var matchC  = activeCategory === "All" || cat === activeCategory;
            var matchQ  = name.indexOf(q) !== -1;
            if (matchC && matchQ) { filtered.push(item); }
        }

        if (filtered.length === 0) {
            list.innerHTML =
                '<div class="panel-empty" style="padding:1rem 0;">' +
                '<i class="fas fa-bowl-food"></i>No items found.</div>';
            return;
        }

        var html = "";
        for (var j = 0; j < filtered.length; j++) {
            html += buildMenuCard(filtered[j]);
        }
        list.innerHTML = html;
    }

    function buildMenuCard(item) {
        var id         = item.id;
        var name       = item.name || item.itemName || "Item";
        var cat        = item.category || item.categoryName || "";
        var price      = item.price || 0;
        var imgSrc     = item.imageUrl || item.image || "";
        var isSel      = (selectedMenuItems[id] !== undefined);
        var qty        = isSel ? selectedMenuItems[id].qty : 1;
        var cardClass  = "menu-item-card" + (isSel ? " selected-menu" : "");

        var thumb = imgSrc
            ? '<img src="' + imgSrc + '" alt="" onerror="this.style.display=\'none\';">'
            : '<i class="fas fa-bowl-food" style="color:#ddd;"></i>';

        return (
            '<div class="' + cardClass + '" id="mcard-' + id + '">' +
            '<div class="menu-item-thumb">' + thumb + '</div>' +
            '<div class="menu-item-info" onclick="toggleMenuItem(' + id + ')" style="cursor:pointer;">' +
            '<div class="menu-item-name">' + name + '</div>' +
            '<div class="menu-item-cat">' + cat + '</div>' +
            '</div>' +
            '<div class="menu-item-price" onclick="toggleMenuItem(' + id + ')" style="cursor:pointer;">Rs. ' + Number(price).toFixed(2) + '</div>' +
            '<div class="qty-stepper">' +
            '<button class="qty-btn" onclick="changeQty(' + id + ', -1)">&#8722;</button>' +
            '<span class="qty-num" id="qty-' + id + '">' + qty + '</span>' +
            '<button class="qty-btn" onclick="changeQty(' + id + ', 1)">&#43;</button>' +
            '</div>' +
            '<div class="menu-item-check" onclick="toggleMenuItem(' + id + ')" style="cursor:pointer;">' +
            '<i class="fas fa-check"></i>' +
            '</div>' +
            '</div>'
        );
    }

    function toggleMenuItem(id) {
        var item = null;
        for (var i = 0; i < allMenuItems.length; i++) {
            if (String(allMenuItems[i].id) === String(id)) {
                item = allMenuItems[i];
                break;
            }
        }
        if (!item) { return; }

        if (selectedMenuItems[id] !== undefined) {
            delete selectedMenuItems[id];
        } else {
            selectedMenuItems[id] = { item: item, qty: 1 };
        }

        var card = document.getElementById("mcard-" + id);
        if (card) { card.outerHTML = buildMenuCard(item); }

        updateOrderSummary();
        updateFormMenuSummary();
        updatePaymentNotice();
    }

    function changeQty(id, delta) {
        if (!selectedMenuItems[id]) { return; }

        var newQty = selectedMenuItems[id].qty + delta;
        if (newQty < 1) {
            toggleMenuItem(id);
            return;
        }

        selectedMenuItems[id].qty = newQty;
        var qtyEl = document.getElementById("qty-" + id);
        if (qtyEl) { qtyEl.textContent = newQty; }

        updateOrderSummary();
        updateFormMenuSummary();
        updatePaymentNotice();
    }

    function calcMenuTotal() {
        var keys  = Object.keys(selectedMenuItems);
        var total = 0;
        for (var k = 0; k < keys.length; k++) {
            var entry = selectedMenuItems[keys[k]];
            total += (entry.item.price || 0) * entry.qty;
        }
        return total;
    }

    function updateOrderSummary() {
        var keys    = Object.keys(selectedMenuItems);
        var summary = document.getElementById("orderSummary");

        if (keys.length === 0) {
            summary.style.display = "none";
            menuTotal = 0;
            return;
        }

        summary.style.display = "block";

        var listHtml = "";
        var total    = 0;

        for (var k = 0; k < keys.length; k++) {
            var entry = selectedMenuItems[keys[k]];
            var name  = entry.item.name || entry.item.itemName || "Item";
            var price = entry.item.price || 0;
            var sub   = price * entry.qty;
            total    += sub;
            listHtml += name + " x" + entry.qty + "  &mdash;  Rs. " + sub.toFixed(2) + "<br>";
        }

        menuTotal = total;
        var deposit = total * 0.30;

        document.getElementById("orderSummaryList").innerHTML = listHtml;
        document.getElementById("orderTotal").textContent     = "Rs. " + total.toFixed(2);
        document.getElementById("depositAmount").textContent  = "Rs. " + deposit.toFixed(2);
    }

    function updateFormMenuSummary() {
        var el   = document.getElementById("menuSummaryInForm");
        var keys = Object.keys(selectedMenuItems);

        if (keys.length === 0) {
            el.innerHTML =
                '<span style="color:#bbb;font-size:0.85rem;">No items selected — pick from the panel &#8594;</span>';
            return;
        }

        var html = "";
        for (var k = 0; k < keys.length; k++) {
            var entry = selectedMenuItems[keys[k]];
            var name  = entry.item.name || entry.item.itemName || "Item";
            html +=
                '<span class="menu-summary-pill">' +
                '<i class="fas fa-bowl-food"></i>' +
                name + ' x' + entry.qty +
                '</span>';
        }
        el.innerHTML = html;
    }

    function updatePaymentNotice() {
        var keys   = Object.keys(selectedMenuItems);
        var notice = document.getElementById("paymentNotice");
        var btn    = document.getElementById("submitBtn");

        if (keys.length > 0) {
            notice.style.display = "block";
            btn.innerHTML = '<i class="fas fa-credit-card"></i> Proceed to Payment';
        } else {
            notice.style.display = "none";
            btn.innerHTML = '<i class="fas fa-calendar-check"></i> Confirm Reservation';
        }
    }

    /* SUBMIT RESERVATION */
    document.getElementById("reservationForm")
        .addEventListener("submit", submitReservation);

    async function submitReservation(event) {
        event.preventDefault();

        if (!selectedTableNumber) {
            alert("Please select a table from the Available Tables panel.");
            return;
        }

        var orderedItems = [];
        var keys = Object.keys(selectedMenuItems);
        for (var k = 0; k < keys.length; k++) {
            var entry = selectedMenuItems[keys[k]];
            orderedItems.push({
                menuItemId: entry.item.id,
                name:       entry.item.name || entry.item.itemName,
                quantity:   entry.qty,
                price:      entry.item.price || 0
            });
        }

        var reservationData = {
            customerName:    document.getElementById("customerName").value,
            customerEmail:   document.getElementById("customerEmail").value,
            customerPhone:   document.getElementById("customerPhone").value,
            reservationDate: document.getElementById("reservationDate").value,
            reservationTime: document.getElementById("reservationTime").value,
            numberOfGuests:  Number(document.getElementById("numberOfGuests").value),
            tableNumber:     Number(selectedTableNumber),
            specialRequest:  document.getElementById("specialRequest").value,
            status:          "PENDING",
            orderedItems:    orderedItems
        };

        var hasMenuItems = orderedItems.length > 0;

        var btn = document.getElementById("submitBtn");
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';

        try {
            /* Always create reservation first */
            var res = await fetch(API_BASE + "/reservations", {
                method:  "POST",
                headers: { "Content-Type": "application/json" },
                body:    JSON.stringify(reservationData)
            });

            if (!res.ok) { throw new Error("fail"); }

            var createdReservation = await res.json();

            if (hasMenuItems) {
                /* Save payment data to sessionStorage and redirect to payment page */
                var total   = calcMenuTotal();
                var deposit = total * 0.30;

                var paymentInfo = {
                    reservationId:   createdReservation.id,
                    customerName:    reservationData.customerName,
                    customerEmail:   reservationData.customerEmail,
                    fullMenuTotal:   total,
                    depositAmount:   deposit,
                    orderedItems:    orderedItems
                };

                sessionStorage.setItem("pendingPayment", JSON.stringify(paymentInfo));
                window.location.href = "payment.jsp";

            } else {
                /* No menu items — reservation is booked directly */
                alert("Reservation confirmed! We look forward to seeing you.");
                resetForm();
            }

        } catch (e) {
            alert("Failed to create reservation. Please try again.");
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-calendar-check"></i> Confirm Reservation';
        }
    }

    function resetForm() {
        document.getElementById("reservationForm").reset();
        selectedTableNumber   = null;
        selectedTableCapacity = null;
        selectedMenuItems     = {};
        menuTotal             = 0;

        document.getElementById("tableHint").style.display    = "none";
        document.getElementById("orderSummary").style.display = "none";
        document.getElementById("paymentNotice").style.display = "none";
        document.getElementById("menuSummaryInForm").innerHTML =
            '<span style="color:#bbb;font-size:0.85rem;">No items selected — pick from the panel &#8594;</span>';
        document.getElementById("menuPanelBody").innerHTML =
            '<div class="menu-panel-locked" id="menuLocked">' +
            '<i class="fas fa-lock"></i>' +
            '<p>Select a table first<br>to unlock menu pre-ordering</p></div>';
        document.getElementById("menuRefreshBtn").style.display = "none";
        document.getElementById("submitBtn").innerHTML = '<i class="fas fa-calendar-check"></i> Confirm Reservation';

        fillCustomerData();
        loadTables();
    }

    /* HELPERS */
    function escQ(str) {
        return String(str).replace(/'/g, "\\'");
    }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }

</script>

</body>
</html>
