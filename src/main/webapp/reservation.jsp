<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Reservation - Golden Reech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
        /* ── CSS Variables ── */
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

        /* ══ BUTTONS ══ */
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
        .btn-outline {
            border: 1.5px solid var(--gold);
            color: var(--gold-dk);
            background: transparent;
        }
        .btn-outline:hover { background: var(--gold); color: var(--white); }
        .btn-primary { background: var(--gold); color: var(--white); }
        .btn-primary:hover {
            background: var(--gold-dk);
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(244,166,35,.35);
        }

        /* ══ PAGE BANNER ══ */
        .page-banner {
            margin-top: 70px;
            background: linear-gradient(135deg, var(--brown) 0%, #6B3A1F 100%);
            padding: 4rem 2rem;
            text-align: center;
            color: var(--white);
        }
        .page-banner h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2rem, 4vw, 3rem);
            font-weight: 900;
            margin-bottom: .5rem;
        }
        .page-banner h1 span { color: var(--gold); }
        .page-banner p { font-size: 1rem; opacity: .75; }

        /* ══ CONTAINER / SECTION ══ */
        .container { max-width: 1200px; margin: 0 auto; padding: 0 2rem; }
        .section { padding: 60px 0; }

        /* ══ LAYOUT ══ */
        .reservation-layout {
            display: grid;
            grid-template-columns: 1fr 420px;
            gap: 28px;
            align-items: start;
        }
        @media (max-width: 1024px) { .reservation-layout { grid-template-columns: 1fr; } }

        /* ══ FORM CARD ══ */
        .reservation-form-card {
            background: var(--white);
            border-radius: 18px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
        }
        .reservation-form-card h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--brown);
            margin: 0 0 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .reservation-form-card h2 i { color: var(--gold); }

        .form-group { margin-bottom: 1.1rem; }
        .form-label {
            display: block;
            font-size: .85rem;
            font-weight: 600;
            color: #666;
            margin-bottom: 6px;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid rgba(59,31,10,.12);
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: .93rem;
            color: var(--brown);
            background: #fafafa;
            transition: border-color .2s, box-shadow .2s;
            outline: none;
        }
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(244,166,35,.12);
            background: var(--white);
        }
        .form-control[readonly] {
            background: rgba(244,166,35,.08);
            border-color: rgba(244,166,35,.4);
            color: var(--gold-dk);
            font-weight: 600;
            cursor: default;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }
        textarea.form-control { resize: vertical; min-height: 90px; }

        .btn-submit {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, var(--gold), var(--gold-dk));
            color: var(--white);
            border: none;
            border-radius: 12px;
            font-family: 'DM Sans', sans-serif;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            transition: transform .18s, box-shadow .18s;
            margin-top: .5rem;
            box-shadow: 0 4px 16px rgba(244,166,35,.28);
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 22px rgba(244,166,35,.38); }
        .btn-submit:disabled { opacity: .55; cursor: not-allowed; transform: none; }

        .form-section-label {
            font-size: .78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .06em;
            color: #bbb;
            margin: 1.2rem 0 .7rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-section-label::after {
            content: '';
            flex: 1;
            height: 1px;
            background: rgba(59,31,10,.08);
        }

        .menu-summary-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(244,166,35,.1);
            border: 1.5px solid rgba(244,166,35,.35);
            border-radius: 999px;
            padding: 4px 12px;
            font-size: .8rem;
            color: var(--gold-dk);
            font-weight: 600;
            margin: 2px;
        }

        .payment-notice {
            display: none;
            margin-top: 12px;
            background: rgba(244,166,35,.08);
            border: 1.5px solid rgba(244,166,35,.35);
            border-radius: 10px;
            padding: 10px 14px;
            font-size: .84rem;
            color: var(--gold-dk);
        }
        .payment-notice i { margin-right: 6px; }

        /* ══ PANELS ══ */
        .panels-column { display: flex; flex-direction: column; gap: 22px; }

        .side-panel {
            background: var(--white);
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
        }
        .panel-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: .35rem;
        }
        .panel-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--brown);
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0;
        }
        .panel-title i { color: var(--gold); }
        .panel-sub { font-size: .82rem; color: #999; margin: 0 0 1rem; }

        .refresh-btn {
            background: none;
            border: 1.5px solid var(--gold);
            color: var(--gold-dk);
            border-radius: 8px;
            padding: 4px 11px;
            font-family: 'DM Sans', sans-serif;
            font-size: .78rem;
            font-weight: 600;
            cursor: pointer;
            transition: .2s;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .refresh-btn:hover { background: var(--gold); color: var(--white); }

        .selected-hint {
            margin-top: 10px;
            background: rgba(244,166,35,.1);
            border: 1.5px solid rgba(244,166,35,.4);
            border-radius: 10px;
            padding: 8px 12px;
            font-size: .82rem;
            color: var(--gold-dk);
            font-weight: 600;
            display: none;
            align-items: center;
            gap: 7px;
        }
        .selected-hint i { color: var(--gold); }

        .panel-legend {
            display: flex;
            gap: 14px;
            margin-top: .9rem;
            font-size: .78rem;
            color: #888;
            flex-wrap: wrap;
        }
        .legend-dot {
            width: 9px; height: 9px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 4px;
        }
        .legend-dot.avail { background: var(--gold); }
        .legend-dot.occup { background: #ccc; }
        .legend-dot.sel   { background: var(--brown); }

        /* ══ TABLES GRID ══ */
        .tables-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 9px;
        }
        .table-card {
            border: 2px solid rgba(59,31,10,.1);
            border-radius: 12px;
            padding: 11px 8px;
            text-align: center;
            cursor: pointer;
            transition: all .2s;
            background: #fafafa;
        }
        .table-card.available {
            border-color: var(--gold);
            background: rgba(244,166,35,.07);
        }
        .table-card.available:hover {
            background: var(--gold);
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: 0 4px 14px rgba(244,166,35,.28);
        }
        .table-card.available:hover .t-icon,
        .table-card.available:hover .t-num,
        .table-card.available:hover .t-cap,
        .table-card.available:hover .t-status { color: var(--white); }
        .table-card.occupied {
            border-color: #e0e0e0;
            background: #f5f5f5;
            cursor: not-allowed;
            opacity: .6;
        }
        .table-card.selected {
            background: var(--gold);
            border-color: var(--gold);
            box-shadow: 0 4px 14px rgba(244,166,35,.35);
        }
        .table-card.selected .t-icon,
        .table-card.selected .t-num,
        .table-card.selected .t-cap,
        .table-card.selected .t-status { color: var(--white); }
        .t-icon   { font-size: 1.4rem; color: var(--gold); margin-bottom: 3px; display: block; }
        .t-num    { font-weight: 700; font-size: .88rem; color: var(--brown); display: block; }
        .t-cap    { font-size: .74rem; color: #888; display: block; margin-top: 2px; }
        .t-status { font-size: .7rem; font-weight: 600; margin-top: 4px; display: block; }
        .table-card.available .t-status { color: var(--gold-dk); }
        .table-card.occupied  .t-status { color: #bbb; }
        .table-card.occupied  .t-icon   { color: #ccc; }

        /* ══ MENU PANEL ══ */
        .menu-panel-locked {
            text-align: center;
            padding: 1.6rem 1rem;
            color: #bbb;
        }
        .menu-panel-locked i { font-size: 2rem; display: block; margin-bottom: 8px; color: #ddd; }
        .menu-panel-locked p { font-size: .84rem; margin: 0; line-height: 1.5; }

        .menu-search {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #f5f5f5;
            border: 1.5px solid rgba(59,31,10,.1);
            border-radius: 10px;
            padding: 7px 12px;
            margin-bottom: 10px;
            transition: border-color .2s;
        }
        .menu-search:focus-within { border-color: var(--gold); }
        .menu-search i { color: #bbb; font-size: .88rem; }
        .menu-search input {
            border: none;
            background: transparent;
            outline: none;
            font-family: 'DM Sans', sans-serif;
            font-size: .85rem;
            color: var(--brown);
            width: 100%;
        }

        .menu-categories { display: flex; gap: 6px; flex-wrap: wrap; margin-bottom: 10px; }
        .cat-btn {
            padding: 4px 12px;
            border-radius: 999px;
            border: 1.5px solid rgba(59,31,10,.12);
            background: #fafafa;
            font-family: 'DM Sans', sans-serif;
            font-size: .76rem;
            font-weight: 600;
            color: #888;
            cursor: pointer;
            transition: .18s;
        }
        .cat-btn:hover, .cat-btn.active {
            background: var(--gold);
            border-color: var(--gold);
            color: var(--white);
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
        .menu-items-list::-webkit-scrollbar-thumb { background: var(--gold); border-radius: 4px; }

        .menu-item-card {
            display: flex;
            align-items: center;
            gap: 10px;
            border: 1.5px solid rgba(59,31,10,.08);
            border-radius: 12px;
            padding: 9px 11px;
            cursor: pointer;
            transition: all .18s;
            background: #fafafa;
        }
        .menu-item-card:hover {
            border-color: var(--gold);
            background: rgba(244,166,35,.06);
            transform: translateX(2px);
        }
        .menu-item-card.selected-menu {
            border-color: var(--gold);
            background: linear-gradient(135deg, rgba(244,166,35,.08), var(--white));
            box-shadow: 0 2px 10px rgba(244,166,35,.15);
        }
        .menu-item-thumb {
            width: 44px; height: 44px;
            border-radius: 10px;
            background: #f0f0f0;
            flex-shrink: 0;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }
        .menu-item-thumb img { width: 100%; height: 100%; object-fit: cover; }
        .menu-item-info { flex: 1; min-width: 0; }
        .menu-item-name {
            font-weight: 700;
            font-size: .85rem;
            color: var(--brown);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .menu-item-cat { font-size: .72rem; color: #aaa; margin-top: 1px; }
        .menu-item-price { font-size: .88rem; font-weight: 700; color: var(--gold-dk); flex-shrink: 0; }

        .menu-item-check {
            width: 20px; height: 20px;
            border-radius: 50%;
            border: 2px solid #e0e0e0;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: .7rem;
            color: transparent;
            transition: .18s;
            background: var(--white);
        }
        .menu-item-card.selected-menu .menu-item-check {
            background: var(--gold);
            border-color: var(--gold);
            color: var(--white);
        }

        .qty-stepper { display: none; align-items: center; gap: 4px; flex-shrink: 0; }
        .menu-item-card.selected-menu .qty-stepper { display: flex; }
        .menu-item-card.selected-menu .menu-item-check { display: none; }

        .qty-btn {
            width: 22px; height: 22px;
            border-radius: 50%;
            border: none;
            background: var(--gold);
            color: var(--white);
            font-size: .9rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: .15s;
        }
        .qty-btn:hover { background: var(--gold-dk); }
        .qty-num { font-size: .85rem; font-weight: 700; color: var(--brown); min-width: 18px; text-align: center; }

        /* ══ ORDER SUMMARY ══ */
        .order-summary {
            margin-top: 10px;
            background: rgba(244,166,35,.08);
            border: 1.5px solid rgba(244,166,35,.35);
            border-radius: 10px;
            padding: 10px 13px;
            display: none;
        }
        .order-summary-title {
            font-size: .8rem;
            font-weight: 700;
            color: var(--gold-dk);
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .order-summary-list { font-size: .78rem; color: #555; line-height: 1.7; }
        .order-total {
            margin-top: 6px;
            padding-top: 6px;
            border-top: 1px dashed rgba(244,166,35,.4);
            font-size: .85rem;
            font-weight: 700;
            color: var(--gold-dk);
            display: flex;
            justify-content: space-between;
        }

        /* ══ LOADING / EMPTY ══ */
        .panel-loading {
            text-align: center;
            padding: 1.8rem 0;
            color: #bbb;
            font-size: .88rem;
        }
        .panel-loading i {
            font-size: 1.6rem;
            display: block;
            margin-bottom: 8px;
            animation: spin 1s linear infinite;
            color: var(--gold);
        }
        .panel-empty { text-align: center; padding: 1.8rem 0; color: #ccc; font-size: .85rem; }
        .panel-empty i { font-size: 2rem; display: block; margin-bottom: 8px; }

        @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }

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
        .footer-section h3 {
            font-family: 'Playfair Display', serif;
            color: var(--gold);
            font-size: 1.05rem;
            margin-bottom: 1rem;
        }
        .footer-section p { font-size: .88rem; line-height: 1.7; }
        .footer-section ul { list-style: none; }
        .footer-section ul li { margin-bottom: .5rem; font-size: .88rem; }
        .footer-section ul li a { color: rgba(255,255,255,.7); text-decoration: none; transition: color .2s; }
        .footer-section ul li a:hover { color: var(--gold); }
        .footer-section ul li i { margin-right: .5rem; color: var(--gold); }
        .footer-bottom {
            text-align: center;
            border-top: 1px solid rgba(255,255,255,.1);
            padding: 1.2rem 2rem;
            font-size: .82rem;
            opacity: .55;
        }

        /* ══ RESPONSIVE ══ */
        @media (max-width: 900px) { .footer-content { grid-template-columns: 1fr 1fr; } }
        @media (max-width: 620px) {
            .nav-menu { display: none; }
            .form-row { grid-template-columns: 1fr; }
            .footer-content { grid-template-columns: 1fr; gap: 2rem; }
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
            <li><a href="reservation.jsp" class="nav-link active">Book a Table</a></li>
            <li><a href="reviews.jsp"     class="nav-link">Reviews</a></li>
        </ul>
        <div class="nav-actions" id="navActions">
            <a href="login.jsp"    class="btn btn-outline btn-sm">Login</a>
            <a href="register.jsp" class="btn btn-primary  btn-sm">Register</a>
        </div>
    </div>
</nav>

<!-- ══ PAGE BANNER ══ -->
<section class="page-banner">
    <div class="container">
        <h1>Book a <span>Table</span></h1>
        <p>Reserve your table and pre-order your favourite dishes</p>
    </div>
</section>

<!-- ══ MAIN SECTION ══ -->
<section class="section">
    <div class="container">
        <div class="reservation-layout">

            <!-- LEFT — FORM -->
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
                                   placeholder="Select from panel →" readonly>
                        </div>
                    </div>

                    <p class="form-section-label">Pre-order Menu</p>

                    <div class="form-group">
                        <label class="form-label">Selected Items</label>
                        <div id="menuSummaryInForm" style="padding:4px 0;">
                            <span style="color:#bbb;font-size:.85rem;">No items selected — pick from the panel →</span>
                        </div>
                    </div>

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
                        <i class="fas fa-calendar-check"></i> Confirm Reservation
                    </button>

                </form>
            </div>

            <!-- RIGHT — PANELS -->
            <div class="panels-column">

                <!-- TABLE PANEL -->
                <div class="side-panel">
                    <div class="panel-header">
                        <h3 class="panel-title"><i class="fas fa-chair"></i> Available Tables</h3>
                        <button class="refresh-btn" onclick="loadTables()">
                            <i class="fas fa-rotate-right"></i> Refresh
                        </button>
                    </div>
                    <p class="panel-sub">Click a table to select it. Menu unlocks after selection.</p>
                    <div id="tablesContainer">
                        <div class="panel-loading"><i class="fas fa-spinner"></i>Loading tables...</div>
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

                <!-- MENU PANEL -->
                <div class="side-panel">
                    <div class="panel-header">
                        <h3 class="panel-title"><i class="fas fa-bowl-food"></i> Pre-order Menu</h3>
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
                        <div class="order-summary-title"><i class="fas fa-receipt"></i> Order Summary</div>
                        <div class="order-summary-list" id="orderSummaryList"></div>
                        <div class="order-total">
                            <span>Total</span>
                            <span id="orderTotal">Rs. 0.00</span>
                        </div>
                        <div style="margin-top:6px;padding-top:6px;border-top:1px dashed rgba(244,166,35,.4);font-size:.8rem;color:#888;">
                            Deposit required (30%): <strong style="color:var(--gold-dk);" id="depositAmount">Rs. 0.00</strong>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>

<!-- ══ FOOTER ══ -->
<footer class="customer-footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>About Us</h3>
            <p>Golden Reech is a modern restaurant offering delicious meals, excellent customer service, and a relaxing dining experience for families, couples, and friends.</p>
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
    var selectedTableNumber   = null;
    var selectedTableCapacity = null;
    var allMenuItems          = [];
    var selectedMenuItems     = {};
    var activeCategory        = "All";
    var menuTotal             = 0;

    document.addEventListener("DOMContentLoaded", function() {
        fillCustomerData();
        loadTables();
    });

    function fillCustomerData() {
        var customer = JSON.parse(localStorage.getItem("customer") || "null");
        if (customer) {
            document.getElementById("customerName").value  = customer.fullName || "";
            document.getElementById("customerEmail").value = customer.email    || "";
            document.getElementById("customerPhone").value = customer.phone    || "";
        }
    }

    async function loadTables() {
        var container = document.getElementById("tablesContainer");
        container.innerHTML = '<div class="panel-loading"><i class="fas fa-spinner"></i>Loading tables...</div>';
        try {
            var res    = await fetch(API_BASE + "/tables");
            if (!res.ok) { throw new Error("fail"); }
            var tables = await res.json();
            if (!tables || tables.length === 0) {
                container.innerHTML = '<div class="panel-empty"><i class="fas fa-chair"></i>No tables found.</div>';
                return;
            }
            renderTables(tables);
        } catch (e) {
            container.innerHTML =
                '<div class="panel-empty"><i class="fas fa-triangle-exclamation"></i>Could not load tables.<br>' +
                '<button onclick="loadTables()" style="margin-top:10px;padding:5px 14px;border:1.5px solid var(--gold);background:none;color:var(--gold-dk);border-radius:8px;cursor:pointer;font-size:.8rem;">Try Again</button></div>';
        }
    }

    function renderTables(tables) {
        var container = document.getElementById("tablesContainer");
        var html = '<div class="tables-grid">';
        for (var i = 0; i < tables.length; i++) {
            var t        = tables[i];
            var isAvail  = t.status === "AVAILABLE" || t.available === true;
            var cardClass = isAvail ? "available" : "occupied";
            var statusTxt = isAvail ? "Available"  : "Occupied";
            var capacity  = t.capacity || t.seatingCapacity || "?";
            var tableNum  = t.tableNumber || t.id;
            var onclick   = isAvail ? 'onclick="selectTable(' + tableNum + ', ' + capacity + ')"' : "";
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
        if (selectedTableNumber !== null) { applyTableHighlight(selectedTableNumber); }
    }

    function selectTable(tableNum, capacity) {
        var wasAlreadySelected = (selectedTableNumber !== null);
        selectedTableNumber   = tableNum;
        selectedTableCapacity = capacity;
        document.getElementById("tableNumber").value = tableNum;
        applyTableHighlight(tableNum);
        document.getElementById("tableHintText").textContent = "Table " + tableNum + " selected  (" + capacity + " seats)";
        document.getElementById("tableHint").style.display = "flex";
        if (!wasAlreadySelected) { unlockMenuPanel(); }
    }

    function applyTableHighlight(tableNum) {
        document.querySelectorAll(".table-card").forEach(function(c) { c.classList.remove("selected"); });
        var target = document.getElementById("tcard-" + tableNum);
        if (target) { target.classList.add("selected"); }
    }

    function unlockMenuPanel() {
        document.getElementById("menuRefreshBtn").style.display = "flex";
        loadMenuItems();
    }

    async function loadMenuItems() {
        var body = document.getElementById("menuPanelBody");
        body.innerHTML = '<div class="panel-loading"><i class="fas fa-spinner"></i>Loading menu...</div>';
        try {
            var res = await fetch(API_BASE + "/menu");
            if (!res.ok) { throw new Error("fail"); }
            allMenuItems = await res.json();
            if (!allMenuItems || allMenuItems.length === 0) {
                body.innerHTML = '<div class="panel-empty"><i class="fas fa-bowl-food"></i>No menu items found.</div>';
                return;
            }
            activeCategory = "All";
            renderMenuPanel();
        } catch (e) {
            body.innerHTML =
                '<div class="panel-empty"><i class="fas fa-triangle-exclamation"></i>Could not load menu.<br>' +
                '<button onclick="loadMenuItems()" style="margin-top:10px;padding:5px 14px;border:1.5px solid var(--gold);background:none;color:var(--gold-dk);border-radius:8px;cursor:pointer;font-size:.8rem;">Try Again</button></div>';
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
            catHtml += '<button class="cat-btn' + active + '" onclick="filterCategory(\'' + escQ(cats[c]) + '\')">' + cats[c] + '</button>';
        }
        body.innerHTML =
            '<div class="menu-search"><i class="fas fa-magnifying-glass"></i>' +
            '<input type="text" id="menuSearchInput" placeholder="Search dishes..." oninput="applyMenuFilter()"></div>' +
            '<div class="menu-categories">' + catHtml + '</div>' +
            '<div class="menu-items-list" id="menuItemsList"></div>';
        applyMenuFilter();
    }

    function filterCategory(cat) { activeCategory = cat; renderMenuPanel(); }

    function applyMenuFilter() {
        var searchEl = document.getElementById("menuSearchInput");
        var q = searchEl ? searchEl.value.toLowerCase() : "";
        var list = document.getElementById("menuItemsList");
        if (!list) { return; }
        var filtered = [];
        for (var i = 0; i < allMenuItems.length; i++) {
            var item   = allMenuItems[i];
            var cat    = item.category || item.categoryName || "Other";
            var name   = (item.name || item.itemName || "").toLowerCase();
            var matchC = activeCategory === "All" || cat === activeCategory;
            var matchQ = name.indexOf(q) !== -1;
            if (matchC && matchQ) { filtered.push(item); }
        }
        if (filtered.length === 0) {
            list.innerHTML = '<div class="panel-empty" style="padding:1rem 0;"><i class="fas fa-bowl-food"></i>No items found.</div>';
            return;
        }
        var html = "";
        for (var j = 0; j < filtered.length; j++) { html += buildMenuCard(filtered[j]); }
        list.innerHTML = html;
    }

    function buildMenuCard(item) {
        var id = item.id, name = item.name || item.itemName || "Item";
        var cat = item.category || item.categoryName || "";
        var price = item.price || 0, imgSrc = item.imageUrl || item.image || "";
        var isSel = (selectedMenuItems[id] !== undefined);
        var qty = isSel ? selectedMenuItems[id].qty : 1;
        var cardClass = "menu-item-card" + (isSel ? " selected-menu" : "");
        var thumb = imgSrc
            ? '<img src="' + imgSrc + '" alt="" onerror="this.style.display=\'none\';">'
            : '<i class="fas fa-bowl-food" style="color:#ddd;"></i>';
        return (
            '<div class="' + cardClass + '" id="mcard-' + id + '">' +
            '<div class="menu-item-thumb">' + thumb + '</div>' +
            '<div class="menu-item-info" onclick="toggleMenuItem(' + id + ')" style="cursor:pointer;">' +
            '<div class="menu-item-name">' + name + '</div>' +
            '<div class="menu-item-cat">' + cat + '</div></div>' +
            '<div class="menu-item-price" onclick="toggleMenuItem(' + id + ')" style="cursor:pointer;">Rs. ' + Number(price).toFixed(2) + '</div>' +
            '<div class="qty-stepper">' +
            '<button class="qty-btn" onclick="changeQty(' + id + ', -1)">&#8722;</button>' +
            '<span class="qty-num" id="qty-' + id + '">' + qty + '</span>' +
            '<button class="qty-btn" onclick="changeQty(' + id + ', 1)">&#43;</button></div>' +
            '<div class="menu-item-check" onclick="toggleMenuItem(' + id + ')" style="cursor:pointer;"><i class="fas fa-check"></i></div>' +
            '</div>'
        );
    }

    function toggleMenuItem(id) {
        var item = null;
        for (var i = 0; i < allMenuItems.length; i++) {
            if (String(allMenuItems[i].id) === String(id)) { item = allMenuItems[i]; break; }
        }
        if (!item) { return; }
        if (selectedMenuItems[id] !== undefined) { delete selectedMenuItems[id]; }
        else { selectedMenuItems[id] = { item: item, qty: 1 }; }
        var card = document.getElementById("mcard-" + id);
        if (card) { card.outerHTML = buildMenuCard(item); }
        updateOrderSummary(); updateFormMenuSummary(); updatePaymentNotice();
    }

    function changeQty(id, delta) {
        if (!selectedMenuItems[id]) { return; }
        var newQty = selectedMenuItems[id].qty + delta;
        if (newQty < 1) { toggleMenuItem(id); return; }
        selectedMenuItems[id].qty = newQty;
        var qtyEl = document.getElementById("qty-" + id);
        if (qtyEl) { qtyEl.textContent = newQty; }
        updateOrderSummary(); updateFormMenuSummary(); updatePaymentNotice();
    }

    function calcMenuTotal() {
        var total = 0;
        Object.keys(selectedMenuItems).forEach(function(k) {
            var e = selectedMenuItems[k];
            total += (e.item.price || 0) * e.qty;
        });
        return total;
    }

    function updateOrderSummary() {
        var keys = Object.keys(selectedMenuItems);
        var summary = document.getElementById("orderSummary");
        if (keys.length === 0) { summary.style.display = "none"; menuTotal = 0; return; }
        summary.style.display = "block";
        var listHtml = "", total = 0;
        for (var k = 0; k < keys.length; k++) {
            var entry = selectedMenuItems[keys[k]];
            var sub = (entry.item.price || 0) * entry.qty;
            total += sub;
            listHtml += (entry.item.name || "Item") + " x" + entry.qty + "  &mdash;  Rs. " + sub.toFixed(2) + "<br>";
        }
        menuTotal = total;
        document.getElementById("orderSummaryList").innerHTML = listHtml;
        document.getElementById("orderTotal").textContent    = "Rs. " + total.toFixed(2);
        document.getElementById("depositAmount").textContent = "Rs. " + (total * 0.30).toFixed(2);
    }

    function updateFormMenuSummary() {
        var el = document.getElementById("menuSummaryInForm");
        var keys = Object.keys(selectedMenuItems);
        if (keys.length === 0) {
            el.innerHTML = '<span style="color:#bbb;font-size:.85rem;">No items selected — pick from the panel →</span>';
            return;
        }
        var html = "";
        for (var k = 0; k < keys.length; k++) {
            var entry = selectedMenuItems[keys[k]];
            html += '<span class="menu-summary-pill"><i class="fas fa-bowl-food"></i>' + (entry.item.name || "Item") + ' x' + entry.qty + '</span>';
        }
        el.innerHTML = html;
    }

    function updatePaymentNotice() {
        var hasItems = Object.keys(selectedMenuItems).length > 0;
        document.getElementById("paymentNotice").style.display = hasItems ? "block" : "none";
        document.getElementById("submitBtn").innerHTML = hasItems
            ? '<i class="fas fa-credit-card"></i> Proceed to Payment'
            : '<i class="fas fa-calendar-check"></i> Confirm Reservation';
    }

    document.getElementById("reservationForm").addEventListener("submit", submitReservation);

    async function submitReservation(event) {
        event.preventDefault();
        if (!selectedTableNumber) { alert("Please select a table from the Available Tables panel."); return; }
        var orderedItems = [];
        Object.keys(selectedMenuItems).forEach(function(k) {
            var e = selectedMenuItems[k];
            orderedItems.push({ menuItemId: e.item.id, name: e.item.name || e.item.itemName, quantity: e.qty, price: e.item.price || 0 });
        });
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
        var btn = document.getElementById("submitBtn");
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
        try {
            var res = await fetch(API_BASE + "/reservations", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(reservationData)
            });
            if (!res.ok) { throw new Error("fail"); }
            var created = await res.json();
            if (orderedItems.length > 0) {
                var total = calcMenuTotal();
                sessionStorage.setItem("pendingPayment", JSON.stringify({
                    reservationId: created.id,
                    customerName:  reservationData.customerName,
                    customerEmail: reservationData.customerEmail,
                    fullMenuTotal: total,
                    depositAmount: total * 0.30,
                    orderedItems:  orderedItems
                }));
                window.location.href = "payment.jsp";
            } else {
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
        selectedTableNumber = null; selectedTableCapacity = null;
        selectedMenuItems = {}; menuTotal = 0;
        document.getElementById("tableHint").style.display     = "none";
        document.getElementById("orderSummary").style.display  = "none";
        document.getElementById("paymentNotice").style.display = "none";
        document.getElementById("menuSummaryInForm").innerHTML =
            '<span style="color:#bbb;font-size:.85rem;">No items selected — pick from the panel →</span>';
        document.getElementById("menuPanelBody").innerHTML =
            '<div class="menu-panel-locked" id="menuLocked"><i class="fas fa-lock"></i>' +
            '<p>Select a table first<br>to unlock menu pre-ordering</p></div>';
        document.getElementById("menuRefreshBtn").style.display = "none";
        document.getElementById("submitBtn").innerHTML = '<i class="fas fa-calendar-check"></i> Confirm Reservation';
        fillCustomerData();
        loadTables();
    }

    function escQ(str) { return String(str).replace(/'/g, "\\'"); }

    function logout() { localStorage.removeItem("customer"); window.location.href = "home.jsp"; }
</script>

</body>
</html>