<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard - Golden Reech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
        :root {
            --gold:    #F4A623;
            --gold-dk: #C97D10;
            --brown:   #3B1F0A;
            --cream:   #FFF8EE;
            --white:   #FFFFFF;
            --shadow:  0 8px 40px rgba(59,31,10,.18);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; background: var(--cream); color: var(--brown); }

        /* ══ NAVBAR ══ */
        .customer-navbar {
            position: fixed;
            top: 0; left: 0; right: 0;
            z-index: 1000;
            background: rgba(255,255,255,0.92);
            backdrop-filter: blur(14px);
            border-bottom: 1px solid rgba(244,166,35,.15);
            box-shadow: 0 2px 24px rgba(59,31,10,.07);
        }
        .navbar-container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 2rem;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 2rem;
        }
        .logo {
            display: flex;
            align-items: center;
            gap: .55rem;
            text-decoration: none;
            font-family: 'Playfair Display', serif;
            font-weight: 900;
            font-size: 1.45rem;
            color: var(--brown);
            letter-spacing: -.01em;
        }
        .logo i { color: var(--gold); font-size: 1.3rem; }
        .nav-menu { display: flex; list-style: none; gap: .25rem; }
        .nav-link {
            text-decoration: none;
            color: var(--brown);
            font-size: .9rem;
            font-weight: 500;
            padding: .45rem .9rem;
            border-radius: 6px;
            transition: background .2s, color .2s;
            opacity: .8;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(244,166,35,.12);
            color: var(--gold-dk);
            opacity: 1;
        }
        .nav-actions { display: flex; gap: .6rem; }
        .btn {
            display: inline-flex;
            align-items: center;
            gap: .4rem;
            font-family: 'DM Sans', sans-serif;
            font-weight: 500;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            border: none;
            transition: all .22s ease;
        }
        .btn-sm { padding: .48rem 1.1rem; font-size: .85rem; }
        .btn-outline { border: 1.5px solid var(--gold); color: var(--gold-dk); background: transparent; }
        .btn-outline:hover { background: var(--gold); color: var(--white); }
        .btn-primary { background: var(--gold); color: var(--white); }
        .btn-primary:hover { background: var(--gold-dk); transform: translateY(-1px); box-shadow: 0 6px 20px rgba(244,166,35,.35); }

        /* ══ DASHBOARD HERO BANNER — matches offers.jsp page-banner treatment ══ */
        .dashboard-hero {
            margin-top: 70px;
            background: linear-gradient(135deg, var(--brown) 0%, #6B3A1F 100%);
            padding: 3.4rem 2rem;
            color: var(--white);
            position: relative;
            overflow: hidden;
        }
        .dashboard-hero::after {
            content: '';
            position: absolute;
            right: -60px; top: -80px;
            width: 260px; height: 260px;
            border-radius: 50%;
            background: rgba(244,166,35,.08);
        }
        .dashboard-hero::before {
            content: '';
            position: absolute;
            left: 10%; bottom: -90px;
            width: 180px; height: 180px;
            border-radius: 50%;
            background: rgba(255,255,255,.04);
        }
        .dashboard-hero-inner {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 2rem;
            flex-wrap: wrap;
            position: relative;
            z-index: 1;
        }
        .hero-left { display: flex; align-items: center; gap: 1.4rem; }
        .avatar-circle {
            width: 76px; height: 76px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--gold) 0%, #ff9a3c 100%);
            border: 3px solid rgba(255,255,255,.25);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 900;
            color: var(--white);
            flex-shrink: 0;
            box-shadow: 0 8px 24px rgba(244,166,35,.35);
        }
        .hero-text .eyebrow {
            display: inline-block;
            background: rgba(255,255,255,.12);
            color: var(--gold);
            font-size: .72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .08em;
            padding: 3px 12px;
            border-radius: 999px;
            margin-bottom: .5rem;
        }
        .hero-text h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(1.4rem, 3vw, 2rem);
            font-weight: 900;
            margin-bottom: .3rem;
        }
        .hero-text h1 span { color: var(--gold); }
        .hero-text p { font-size: .9rem; opacity: .7; }

        /* ══ PROFILE HIGHLIGHT BUTTON ══ */
        .profile-highlight-btn {
            display: inline-flex;
            align-items: center;
            gap: .6rem;
            background: linear-gradient(135deg, var(--gold), var(--gold-dk));
            color: var(--white);
            padding: .75rem 1.6rem;
            border-radius: 12px;
            text-decoration: none;
            font-family: 'DM Sans', sans-serif;
            font-weight: 700;
            font-size: .95rem;
            box-shadow: 0 6px 20px rgba(244,166,35,.4);
            transition: transform .2s, box-shadow .2s;
            white-space: nowrap;
            border: none;
            cursor: pointer;
        }
        .profile-highlight-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 28px rgba(244,166,35,.5);
        }
        .profile-highlight-btn i { font-size: 1.1rem; }

        /* ══ MAIN CONTENT ══ */
        .dashboard-page { padding: 2.5rem 0 4rem; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 2rem; }

        /* ══ STATS ROW ══ */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.2rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: var(--white);
            border-radius: 18px;
            padding: 1.5rem 1.6rem;
            box-shadow: 0 4px 20px rgba(59,31,10,.07);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform .25s, box-shadow .25s;
        }
        .stat-card:hover { transform: translateY(-4px); box-shadow: var(--shadow); }
        .stat-icon {
            width: 58px; height: 58px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            flex-shrink: 0;
        }
        .stat-icon.gold  { background: linear-gradient(135deg, var(--gold) 0%, #ff9a3c 100%); color: var(--white); }
        .stat-icon.blue    { background: linear-gradient(135deg, #2563eb, #4f8ff7); color: var(--white); }
        .stat-icon.green { background: linear-gradient(135deg, #2e7d32, #43a047); color: var(--white); }
        .stat-info h3 { font-family: 'Playfair Display', serif; font-size: 2rem; font-weight: 900; color: var(--brown); line-height: 1; }
        .stat-info p  { font-size: .82rem; color: #999; margin-top: 5px; }

        /* ══ DASHBOARD GRID ══ */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
        }

        /* ══ SECTION CARDS ══ */
        .section-card {
            background: var(--white);
            border-radius: 18px;
            box-shadow: 0 4px 20px rgba(59,31,10,.07);
            overflow: hidden;
            margin-bottom: 1.5rem;
        }
        .section-card:last-child { margin-bottom: 0; }
        .section-header {
            padding: 1.1rem 1.5rem;
            border-bottom: 1px solid rgba(59,31,10,.07);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .section-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--brown);
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0;
        }
        .section-header h3 i { color: var(--gold); }
        .section-body { padding: 1.4rem; }

        /* ══ QUICK LINKS ══ */
        .quick-links { display: grid; grid-template-columns: repeat(3, 1fr); gap: .8rem; }
        .quick-link {
            background: var(--cream);
            border: 1.5px solid rgba(244,166,35,.2);
            border-radius: 14px;
            padding: 1.1rem .8rem;
            text-decoration: none;
            color: var(--brown);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: .5rem;
            font-weight: 600;
            font-size: .82rem;
            text-align: center;
            transition: all .22s;
        }
        .quick-link i { font-size: 1.35rem; color: var(--gold); transition: color .2s; }
        .quick-link:hover {
            background: linear-gradient(135deg, var(--gold) 0%, #ff9a3c 100%);
            border-color: var(--gold);
            color: var(--white);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(244,166,35,.35);
        }
        .quick-link:hover i { color: var(--white); }

        /* ══ PROFILE QUICK LINK — SPECIAL ══ */
        .quick-link.profile-link {
            background: linear-gradient(135deg, var(--brown), #6B3A1F);
            border-color: var(--brown);
            color: var(--white);
        }
        .quick-link.profile-link i { color: var(--gold); }
        .quick-link.profile-link:hover {
            background: linear-gradient(135deg, var(--gold) 0%, #ff9a3c 100%);
            border-color: var(--gold);
            box-shadow: 0 8px 20px rgba(244,166,35,.4);
        }
        .quick-link.profile-link:hover i { color: var(--white); }

        /* ══ RESERVATION ITEMS — card style echoing promo-card ══ */
        .reservation-item {
            padding: 1rem 1.1rem;
            border: 1.5px solid rgba(59,31,10,.08);
            border-left: 4px solid var(--gold);
            border-radius: 12px;
            margin-bottom: .8rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: .8rem;
            transition: border-color .2s, box-shadow .2s, transform .2s;
            background: var(--cream);
        }
        .reservation-item:last-child { margin-bottom: 0; }
        .reservation-item:hover {
            border-color: var(--gold);
            box-shadow: 0 6px 18px rgba(244,166,35,.15);
            transform: translateY(-2px);
        }
        .reservation-item.status-confirmed { border-left-color: #2e7d32; }
        .reservation-item.status-cancelled { border-left-color: #c62828; }
        .reservation-info h4 { font-size: .92rem; font-weight: 700; color: var(--brown); margin-bottom: .35rem; }
        .reservation-info p  { font-size: .8rem; color: #888; }
        .reservation-info p i { color: var(--gold); margin-right: 3px; }

        /* ══ BADGES — pill style matching promo-badge ══ */
        .badge {
            padding: .38rem .9rem;
            border-radius: 999px;
            font-size: .7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .04em;
            white-space: nowrap;
        }
        .badge-confirmed { background: #e8f5e9; color: #2e7d32; }
        .badge-pending   { background: rgba(244,166,35,.14); color: var(--gold-dk); }
        .badge-cancelled { background: #ffebee; color: #c62828; }

        /* ══ MINI OFFER CARDS — styled like offers.jsp promo-card ══ */
        .mini-offer-card {
            border-radius: 16px;
            overflow: hidden;
            margin-bottom: 1rem;
            box-shadow: 0 3px 14px rgba(59,31,10,.08);
            transition: transform .22s, box-shadow .22s;
        }
        .mini-offer-card:last-child { margin-bottom: 0; }
        .mini-offer-card:hover { transform: translateY(-3px); box-shadow: 0 10px 24px rgba(244,166,35,.2); }
        .mini-offer-header {
            background: linear-gradient(135deg, var(--gold) 0%, #ff9a3c 100%);
            padding: 1rem 1.1rem;
            position: relative;
            overflow: hidden;
        }
        .mini-offer-header::after {
            content: '';
            position: absolute;
            right: -16px; top: -16px;
            width: 80px; height: 80px;
            border-radius: 50%;
            background: rgba(255,255,255,.12);
        }
        .mini-offer-pct {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 900;
            color: var(--white);
            line-height: 1;
            margin-bottom: .2rem;
            position: relative;
            z-index: 1;
        }
        .mini-offer-title {
            font-size: .85rem;
            font-weight: 600;
            color: rgba(255,255,255,.92);
            position: relative;
            z-index: 1;
        }
        .mini-offer-body { padding: .9rem 1.1rem; background: var(--white); }
        .mini-offer-desc { font-size: .8rem; color: #888; line-height: 1.5; }

        .view-all-link {
            display: block;
            text-align: center;
            margin-top: 1rem;
            color: var(--gold-dk);
            font-size: .88rem;
            font-weight: 600;
            text-decoration: none;
            transition: color .2s;
        }
        .view-all-link:hover { color: var(--brown); }

        /* ══ EMPTY STATE ══ */
        .empty-state { text-align: center; padding: 2rem 1rem; color: #ccc; }
        .empty-state i { font-size: 2rem; display: block; margin-bottom: .5rem; color: rgba(244,166,35,.4); }
        .empty-state p { font-size: .88rem; }
        .empty-state a { color: var(--gold-dk); font-weight: 600; text-decoration: none; }

        /* ══ FOOTER ══ */
        .customer-footer { background: var(--brown); color: rgba(255,255,255,.75); }
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 4rem 2rem 2.5rem;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 3rem;
        }
        .footer-section h3 { font-family: 'Playfair Display', serif; color: var(--gold); font-size: 1.05rem; margin-bottom: 1rem; }
        .footer-section p { font-size: .88rem; line-height: 1.7; }
        .footer-section ul { list-style: none; }
        .footer-section ul li { margin-bottom: .5rem; font-size: .88rem; }
        .footer-section ul li a { color: rgba(255,255,255,.7); text-decoration: none; transition: color .2s; }
        .footer-section ul li a:hover { color: var(--gold); }
        .footer-section ul li i { margin-right: .5rem; color: var(--gold); }
        .footer-bottom { text-align: center; border-top: 1px solid rgba(255,255,255,.1); padding: 1.2rem 2rem; font-size: .82rem; opacity: .55; }

        /* ══ RESPONSIVE ══ */
        @media (max-width: 900px) {
            .stats-row { grid-template-columns: 1fr 1fr; }
            .dashboard-grid { grid-template-columns: 1fr; }
            .quick-links { grid-template-columns: repeat(2, 1fr); }
            .footer-content { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 620px) {
            .nav-menu { display: none; }
            .stats-row { grid-template-columns: 1fr; }
            .quick-links { grid-template-columns: repeat(2, 1fr); }
            .footer-content { grid-template-columns: 1fr; gap: 2rem; }
            .dashboard-hero-inner { flex-direction: column; align-items: flex-start; }
        }
    </style>
</head>

<body>

<!-- ══ NAVBAR ══ -->
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
            <li><a href="reservation.jsp" class="nav-link">Book a Table</a></li>
            <li><a href="reviews.jsp"     class="nav-link">Reviews</a></li>
        </ul>
        <div class="nav-actions">
            <a href="customer-dashboard.jsp" class="btn btn-outline btn-sm active">
                <i class="fas fa-user"></i> My Account
            </a>
            <button class="btn btn-primary btn-sm" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>
</nav>

<!-- ══ DASHBOARD HERO ══ -->
<div class="dashboard-hero">
    <div class="dashboard-hero-inner">
        <div class="hero-left">
            <div class="avatar-circle" id="avatarInitials">GR</div>
            <div class="hero-text">
                <span class="eyebrow">My Dashboard</span>
                <h1>Welcome back, <span id="customerNameHero">Customer</span>!</h1>
                <p>Manage your reservations, browse offers, and enjoy Golden Reech.</p>
            </div>
        </div>
        <a href="profile.jsp" class="profile-highlight-btn">
            <i class="fas fa-user-cog"></i> My Profile
        </a>
    </div>
</div>

<!-- ══ DASHBOARD CONTENT ══ -->
<div class="dashboard-page">
    <div class="container">

        <!-- STATS -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon gold"><i class="fas fa-calendar-check"></i></div>
                <div class="stat-info">
                    <h3 id="reservationCount">0</h3>
                    <p>My Reservations</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-ticket-alt"></i></div>
                <div class="stat-info">
                    <h3 id="offerCount">0</h3>
                    <p>Active Offers</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-circle-check"></i></div>
                <div class="stat-info">
                    <h3 id="confirmedCount">0</h3>
                    <p>Confirmed</p>
                </div>
            </div>
        </div>

        <!-- MAIN GRID -->
        <div class="dashboard-grid">

            <!-- LEFT COLUMN -->
            <div>
                <!-- QUICK LINKS -->
                <div class="section-card">
                    <div class="section-header">
                        <h3><i class="fas fa-link"></i> Quick Links</h3>
                    </div>
                    <div class="section-body">
                        <div class="quick-links">
                            <a href="reservation.jsp" class="quick-link">
                                <i class="fas fa-calendar-plus"></i>
                                <span>New Reservation</span>
                            </a>
                            <a href="my-reservations.jsp" class="quick-link">
                                <i class="fas fa-list"></i>
                                <span>My Reservations</span>
                            </a>
                            <a href="menu.jsp" class="quick-link">
                                <i class="fas fa-utensils"></i>
                                <span>Browse Menu</span>
                            </a>
                            <a href="offers.jsp" class="quick-link">
                                <i class="fas fa-tag"></i>
                                <span>Offers</span>
                            </a>
                            <a href="reviews.jsp" class="quick-link">
                                <i class="fas fa-star"></i>
                                <span>Reviews</span>
                            </a>

                        </div>
                    </div>
                </div>

                <!-- RECENT RESERVATIONS -->
                <div class="section-card">
                    <div class="section-header">
                        <h3><i class="fas fa-clock"></i> Recent Reservations</h3>
                        <a href="my-reservations.jsp" class="btn btn-sm btn-outline">View All</a>
                    </div>
                    <div class="section-body">
                        <div id="reservationList">
                            <div class="empty-state">
                                <i class="fas fa-spinner fa-spin" style="color:var(--gold);"></i>
                                <p>Loading reservations...</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN -->
            <div>
                <div class="section-card">
                    <div class="section-header">
                        <h3><i class="fas fa-tag"></i> Active Offers</h3>
                    </div>
                    <div class="section-body">
                        <div id="offersList">
                            <div class="empty-state">
                                <i class="fas fa-spinner fa-spin" style="color:var(--gold);"></i>
                                <p>Loading offers...</p>
                            </div>
                        </div>
                        <a href="offers.jsp" class="view-all-link">
                            <i class="fas fa-arrow-right"></i> View All Offers
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- ══ FOOTER ══ -->
<footer class="customer-footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>About Us</h3>
            <p>Golden Reech is a modern restaurant offering delicious meals, excellent customer service, and a relaxing dining experience.</p>
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

    document.addEventListener("DOMContentLoaded", loadCustomerDashboard);

    async function loadCustomerDashboard() {
        const customer = JSON.parse(localStorage.getItem("customer") || "null");
        if (!customer || !customer.email) {
            alert("Please login first.");
            window.location.href = "login.jsp";
            return;
        }

        /* Set name + avatar initials */
        const name = customer.fullName || customer.name || customer.email;
        document.getElementById("customerNameHero").textContent = name.split(" ")[0];
        document.getElementById("avatarInitials").textContent   =
            name.split(" ").map(w => w[0]).join("").substring(0, 2).toUpperCase();

        await loadReservations(customer.email);
        await loadOffers();
    }

    async function loadReservations(email) {
        const list = document.getElementById("reservationList");
        try {
            const res  = await fetch(`${API_BASE}/reservations/customer?email=${encodeURIComponent(email)}`);
            const data = await res.json();

            document.getElementById("reservationCount").textContent = data.length;
            const confirmed = data.filter(r => r.status === "CONFIRMED").length;
            document.getElementById("confirmedCount").textContent = confirmed;

            if (data.length === 0) {
                list.innerHTML = '<div class="empty-state"><i class="fas fa-calendar-xmark"></i><p>No reservations yet. <a href="reservation.jsp">Book a table!</a></p></div>';
                return;
            }

            list.innerHTML = data.slice(-3).reverse().map(r => `
                <div class="reservation-item ${getStatusRowClass(r.status)}">
                    <div class="reservation-info">
                        <h4>Reservation #${r.id}</h4>
                        <p>
                            <i class="fas fa-calendar"></i> ${r.reservationDate || "-"}
                            &nbsp;|&nbsp;
                            <i class="fas fa-clock"></i> ${r.reservationTime || "-"}
                            &nbsp;|&nbsp;
                            <i class="fas fa-users"></i> ${r.numberOfGuests || 0} guests
                        </p>
                    </div>
                    <span class="badge ${getStatusClass(r.status)}">${r.status || "PENDING"}</span>
                </div>
            `).join("");

        } catch (e) {
            list.innerHTML = '<div class="empty-state"><i class="fas fa-triangle-exclamation"></i><p>Failed to load reservations.</p></div>';
        }
    }

    async function loadOffers() {
        const list = document.getElementById("offersList");
        try {
            const res  = await fetch(`${API_BASE}/offers/active`);
            const data = await res.json();

            document.getElementById("offerCount").textContent = data.length;

            if (data.length === 0) {
                list.innerHTML = '<div class="empty-state"><i class="fas fa-tag"></i><p>No active offers right now.</p></div>';
                return;
            }

            list.innerHTML = data.slice(0, 3).map(o => `
                <div class="mini-offer-card">
                    <div class="mini-offer-header">
                        <div class="mini-offer-pct">${o.discountPercentage || 0}% OFF</div>
                        <div class="mini-offer-title">${o.title || "Special Offer"}</div>
                    </div>
                    <div class="mini-offer-body">
                        <p class="mini-offer-desc">${o.description || ""}</p>
                    </div>
                </div>
            `).join("");

        } catch (e) {
            list.innerHTML = '<div class="empty-state"><i class="fas fa-triangle-exclamation"></i><p>Failed to load offers.</p></div>';
        }
    }

    function getStatusClass(status) {
        if (status === "CONFIRMED") return "badge-confirmed";
        if (status === "CANCELLED") return "badge-cancelled";
        return "badge-pending";
    }

    function getStatusRowClass(status) {
        if (status === "CONFIRMED") return "status-confirmed";
        if (status === "CANCELLED") return "status-cancelled";
        return "";
    }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>

</body>
</html>