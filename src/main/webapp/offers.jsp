<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Offers - Golden Reech</title>
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
        .section { padding: 80px 0; }

        /* ══ SEARCH BAR ══ */
        .offers-search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
            background: var(--white);
            border: 1.5px solid rgba(59,31,10,.12);
            border-radius: 12px;
            padding: .75rem 1.2rem;
            margin-bottom: 2rem;
            box-shadow: 0 1px 6px rgba(0,0,0,.05);
            transition: border-color .2s;
        }
        .offers-search-bar:focus-within { border-color: var(--gold); }
        .offers-search-bar i { color: #ccc; }
        .offers-search-bar input {
            border: none;
            outline: none;
            font-family: 'DM Sans', sans-serif;
            font-size: .95rem;
            width: 100%;
            background: transparent;
            color: var(--brown);
        }

        /* ══ SECTION HEADING ══ */
        .offers-section-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--brown);
            margin-bottom: .4rem;
            display: flex;
            align-items: center;
            gap: .5rem;
        }
        .offers-section-title i { color: var(--gold); }
        .offers-section-title::after {
            content: '';
            display: block;
            width: 40px; height: 3px;
            background: var(--gold);
            border-radius: 2px;
            margin-left: .5rem;
            align-self: center;
        }
        .offers-section-sub {
            font-size: .88rem;
            color: #999;
            margin-bottom: 1.8rem;
        }

        /* ══ PROMO GRID ══ */
        .promo-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.6rem;
            margin-bottom: 3rem;
        }

        /* ══ PROMO CARD ══ */
        .promo-card {
            background: var(--white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
            transition: transform .25s, box-shadow .25s;
            display: flex;
            flex-direction: column;
        }
        .promo-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .promo-card-header {
            background: linear-gradient(135deg, var(--gold) 0%, #ff9a3c 100%);
            padding: 1.5rem;
            position: relative;
            overflow: hidden;
        }
        .promo-card-header::after {
            content: '';
            position: absolute;
            right: -20px; top: -20px;
            width: 110px; height: 110px;
            border-radius: 50%;
            background: rgba(255,255,255,.12);
        }
        .promo-badge {
            display: inline-block;
            background: rgba(255,255,255,.25);
            color: var(--white);
            font-size: .72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .08em;
            padding: 3px 12px;
            border-radius: 999px;
            margin-bottom: .6rem;
        }
        .promo-discount {
            font-family: 'Playfair Display', serif;
            font-size: 2.6rem;
            font-weight: 900;
            color: var(--white);
            line-height: 1;
            margin-bottom: .25rem;
        }
        .promo-card-title {
            font-size: 1rem;
            font-weight: 600;
            color: rgba(255,255,255,.92);
        }

        .promo-card-body { padding: 1.3rem 1.5rem; flex: 1; }
        .promo-description {
            font-size: .87rem;
            color: #666;
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .promo-code-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            background: rgba(244,166,35,.08);
            border: 1.5px dashed var(--gold);
            border-radius: 10px;
            padding: .7rem 1rem;
            margin-bottom: 1rem;
        }
        .promo-code-text {
            font-size: .9rem;
            font-weight: 800;
            color: var(--gold-dk);
            letter-spacing: .05em;
            word-break: break-all;
        }
        .copy-code-btn {
            border: none;
            background: var(--gold);
            color: var(--white);
            border-radius: 8px;
            padding: .45rem .8rem;
            font-family: 'DM Sans', sans-serif;
            font-size: .8rem;
            font-weight: 700;
            cursor: pointer;
            white-space: nowrap;
            transition: background .2s, transform .2s;
        }
        .copy-code-btn:hover { background: var(--gold-dk); transform: translateY(-1px); }

        .promo-meta { display: flex; flex-direction: column; gap: .5rem; }
        .promo-meta-row {
            display: flex;
            align-items: center;
            gap: .5rem;
            font-size: .83rem;
            color: #555;
        }
        .promo-meta-row i { color: var(--gold); width: 16px; text-align: center; flex-shrink: 0; }
        .promo-meta-row strong { color: var(--brown); }

        .promo-card-footer {
            padding: 1rem 1.5rem;
            border-top: 1px solid rgba(59,31,10,.07);
        }
        .btn-book-now {
            width: 100%;
            padding: .75rem;
            background: linear-gradient(135deg, var(--gold), var(--gold-dk));
            color: var(--white);
            border: none;
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: .9rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: .5rem;
            transition: all .2s;
            text-decoration: none;
        }
        .btn-book-now:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(244,166,35,.4);
        }

        /* ══ STATE BOX ══ */
        .state-box {
            text-align: center;
            padding: 3rem 1rem;
            color: #ccc;
            grid-column: 1 / -1;
        }
        .state-box i { font-size: 2.5rem; display: block; margin-bottom: .6rem; }
        .state-box p { font-size: .9rem; }

        /* ══ TOAST ══ */
        .toast {
            position: fixed;
            bottom: 28px;
            left: 50%;
            transform: translateX(-50%) translateY(80px);
            background: var(--brown);
            color: var(--white);
            padding: .65rem 1.4rem;
            border-radius: 999px;
            font-family: 'DM Sans', sans-serif;
            font-size: .88rem;
            font-weight: 600;
            transition: transform .3s;
            z-index: 9999;
            display: flex;
            align-items: center;
            gap: .5rem;
            white-space: nowrap;
            box-shadow: 0 6px 24px rgba(59,31,10,.25);
        }
        .toast.show { transform: translateX(-50%) translateY(0); }
        .toast i { color: var(--gold); }

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
        .footer-section ul li a {
            color: rgba(255,255,255,.7);
            text-decoration: none;
            transition: color .2s;
        }
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
        @media (max-width: 900px) {
            .promo-grid { grid-template-columns: 1fr 1fr; }
            .footer-content { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 620px) {
            .nav-menu { display: none; }
            .promo-grid { grid-template-columns: 1fr; }
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
            <li><a href="offers.jsp"      class="nav-link active">Offers</a></li>
            <li><a href="reservation.jsp" class="nav-link">Book a Table</a></li>
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
        <h1>Special <span>Offers</span></h1>
        <p>Exclusive deals, seasonal promotions and discount codes at Golden Reech</p>
    </div>
</section>

<!-- ══ OFFERS SECTION ══ -->
<section class="section">
    <div class="container">

        <div class="offers-search-bar">
            <i class="fas fa-magnifying-glass"></i>
            <input type="text" id="offerSearch" placeholder="Search offers..." oninput="filterAll()">
        </div>

        <h2 class="offers-section-title"><i class="fas fa-fire"></i> Promotional Offers</h2>
        <p class="offers-section-sub">Active deals from the restaurant — book a table and enjoy these discounts.</p>

        <div class="promo-grid" id="promoGrid">
            <div class="state-box">
                <i class="fas fa-spinner fa-spin" style="color:var(--gold);"></i>
                <p>Loading offers...</p>
            </div>
        </div>

    </div>
</section>

<!-- ══ TOAST ══ -->
<div class="toast" id="toast">
    <i class="fas fa-check-circle"></i>
    <span id="toastMsg">Copied!</span>
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
    var API_BASE  = "http://localhost:8080/api";
    var allPromos = [];

    document.addEventListener("DOMContentLoaded", function() {
        updateNavbar();
        loadPromos();
    });

    function updateNavbar() {
        var customer = JSON.parse(localStorage.getItem("customer") || "null");
        if (customer) {
            document.getElementById("navActions").innerHTML =
                '<a href="customer-dashboard.jsp" class="btn btn-outline btn-sm"><i class="fas fa-user"></i> Dashboard</a>' +
                '<button class="btn btn-primary btn-sm" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</button>';
        }
    }

    function loadPromos() {
        fetch(API_BASE + "/offers/active")
            .then(function(r) { return r.json(); })
            .then(function(data) {
                allPromos = data || [];
                renderPromos(allPromos);
            })
            .catch(function() {
                document.getElementById("promoGrid").innerHTML =
                    '<div class="state-box"><i class="fas fa-triangle-exclamation"></i><p>Could not load offers. Make sure Spring Boot is running.</p></div>';
            });
    }

    function renderPromos(list) {
        var grid = document.getElementById("promoGrid");
        if (!list || list.length === 0) {
            grid.innerHTML = '<div class="state-box"><i class="fas fa-tag"></i><p>No active promotional offers at the moment.</p></div>';
            return;
        }
        var html = "";
        for (var i = 0; i < list.length; i++) {
            var o     = list[i];
            var pct   = o.discountPercentage || 0;
            var start = o.startDate  || null;
            var end   = o.endDate    || null;
            var code  = o.offerCode  || "";

            html +=
                '<div class="promo-card">' +
                '<div class="promo-card-header">' +
                '<div class="promo-badge">Active Offer</div>' +
                '<div class="promo-discount">' + pct + '% OFF</div>' +
                '<div class="promo-card-title">' + (o.title || "Special Offer") + '</div>' +
                '</div>' +
                '<div class="promo-card-body">' +
                '<p class="promo-description">' + (o.description || "") + '</p>';

            if (code) {
                html +=
                    '<div class="promo-code-box">' +
                    '<span class="promo-code-text">' + code + '</span>' +
                    '<button class="copy-code-btn" onclick="copyOfferCode(\'' + esc(code) + '\')">' +
                    '<i class="fas fa-copy"></i> Copy' +
                    '</button>' +
                    '</div>';
            }

            html +=
                '<div class="promo-meta">' +
                '<div class="promo-meta-row"><i class="fas fa-calendar-day"></i><span>Valid from:</span><strong>' + fmt(start) + '</strong></div>' +
                '<div class="promo-meta-row"><i class="fas fa-calendar-check"></i><span>Valid until:</span><strong>' + fmtEnd(end) + '</strong></div>' +
                '</div>' +
                '</div>' +
                '<div class="promo-card-footer">' +
                '<a href="reservation.jsp" class="btn-book-now">' +
                '<i class="fas fa-calendar-check"></i> Book Now to Enjoy' +
                '</a>' +
                '</div>' +
                '</div>';
        }
        grid.innerHTML = html;
    }

    function filterAll() {
        var q = document.getElementById("offerSearch").value.toLowerCase().trim();
        renderPromos(allPromos.filter(function(o) {
            return (o.title       || "").toLowerCase().includes(q) ||
                (o.description || "").toLowerCase().includes(q) ||
                (o.offerCode   || "").toLowerCase().includes(q);
        }));
    }

    function fmt(d) {
        if (!d) return "-";
        var dt = new Date(d);
        return isNaN(dt.getTime()) ? "-" : dt.toLocaleDateString("en-GB", { day:"2-digit", month:"short", year:"numeric" });
    }

    function fmtEnd(d) { return d ? fmt(d) : "Still valid"; }

    function copyOfferCode(code) {
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(code).then(function() { showToast("Copied: " + code); }).catch(function() { fallbackCopy(code); });
        } else { fallbackCopy(code); }
    }

    function fallbackCopy(code) {
        var tmp = document.createElement("input");
        tmp.value = code;
        document.body.appendChild(tmp);
        tmp.select();
        document.execCommand("copy");
        document.body.removeChild(tmp);
        showToast("Copied: " + code);
    }

    function showToast(msg) {
        var toast = document.getElementById("toast");
        document.getElementById("toastMsg").textContent = msg;
        toast.classList.add("show");
        setTimeout(function() { toast.classList.remove("show"); }, 2200);
    }

    function esc(t) { return String(t || "").replace(/'/g, "\\'"); }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>
</body>
</html>