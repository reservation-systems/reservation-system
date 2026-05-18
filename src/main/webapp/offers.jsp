<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Offers - Golden Reech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">
    <style>
        .offers-section-title { font-size:1.4rem; font-weight:700; color:#1A0A00; margin:0 0 6px; display:flex; align-items:center; gap:10px; }
        .offers-section-title i { color:#F4A100; }
        .offers-section-sub { font-size:0.88rem; color:#999; margin:0 0 1.6rem; }

        .offers-search-bar { display:flex; align-items:center; gap:10px; background:#fff; border:1.5px solid #e8e8e8; border-radius:12px; padding:10px 16px; margin-bottom:2rem; box-shadow:0 1px 6px rgba(0,0,0,0.05); }
        .offers-search-bar i { color:#ccc; }
        .offers-search-bar input { border:none; outline:none; font-size:0.95rem; width:100%; background:transparent; }

        .promo-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(300px,1fr)); gap:20px; margin-bottom:3rem; }

        .promo-card { background:#fff; border-radius:16px; overflow:hidden; box-shadow:0 2px 16px rgba(0,0,0,0.07); transition:transform 0.2s,box-shadow 0.2s; display:flex; flex-direction:column; }
        .promo-card:hover { transform:translateY(-4px); box-shadow:0 8px 28px rgba(244,161,0,0.15); }

        .promo-card-header { background:linear-gradient(135deg,#F4A100,#ff9a3c); padding:1.4rem 1.5rem; position:relative; overflow:hidden; }
        .promo-card-header::after { content:''; position:absolute; right:-20px; top:-20px; width:100px; height:100px; border-radius:50%; background:rgba(255,255,255,0.12); }
        .promo-badge { display:inline-block; background:rgba(255,255,255,0.25); color:#fff; font-size:0.72rem; font-weight:700; text-transform:uppercase; letter-spacing:0.08em; padding:3px 10px; border-radius:999px; margin-bottom:8px; }
        .promo-discount { font-size:2.4rem; font-weight:900; color:#fff; line-height:1; margin-bottom:2px; }
        .promo-card-title { font-size:1rem; font-weight:700; color:rgba(255,255,255,0.92); }

        .promo-card-body { padding:1.2rem 1.5rem; flex:1; }
        .promo-description { font-size:0.87rem; color:#666; line-height:1.6; margin-bottom:1rem; }

        .promo-code-box { display:flex; align-items:center; justify-content:space-between; gap:10px; background:#fff7ef; border:1px dashed #F4A100; border-radius:10px; padding:10px 12px; margin-bottom:1rem; }
        .promo-code-text { font-size:0.9rem; font-weight:800; color:#F4A100; letter-spacing:0.05em; word-break:break-all; }
        .copy-code-btn { border:none; background:#F4A100; color:#fff; border-radius:8px; padding:7px 10px; font-size:0.8rem; font-weight:700; cursor:pointer; white-space:nowrap; }
        .copy-code-btn:hover { background:#B87000; }

        .promo-meta { display:flex; flex-direction:column; gap:6px; }
        .promo-meta-row { display:flex; align-items:center; gap:8px; font-size:0.83rem; color:#555; }
        .promo-meta-row i { color:#F4A100; width:16px; text-align:center; flex-shrink:0; }
        .promo-meta-row strong { color:#1A0A00; }

        .promo-card-footer { padding:1rem 1.5rem; border-top:1px solid #f5f5f5; }
        .btn-book-now { width:100%; padding:10px; background:linear-gradient(135deg,#F4A100,#C97D00); color:#fff; border:none; border-radius:10px; font-size:0.9rem; font-weight:700; cursor:pointer; display:flex; align-items:center; justify-content:center; gap:8px; transition:0.18s; text-decoration:none; }
        .btn-book-now:hover { transform:translateY(-1px); box-shadow:0 4px 14px rgba(244,161,0,0.35); }

        .state-box { text-align:center; padding:3rem 1rem; color:#ccc; }
        .state-box i { font-size:2.5rem; display:block; margin-bottom:10px; }
        .state-box p { font-size:0.9rem; }

        .toast { position:fixed; bottom:28px; left:50%; transform:translateX(-50%) translateY(80px); background:#1a1a1a; color:#fff; padding:10px 22px; border-radius:999px; font-size:0.88rem; font-weight:600; transition:transform 0.3s; z-index:999; display:flex; align-items:center; gap:8px; white-space:nowrap; }
        .toast.show { transform:translateX(-50%) translateY(0); }
        .toast i { color:#F4A100; }
    </style>
</head>
<body>

<nav class="customer-navbar">
    <div class="navbar-container">
        <a href="home.jsp" class="logo"><i class="fas fa-utensils"></i><span>Golden Reech</span></a>
        <ul class="nav-menu">
            <li><a href="home.jsp" class="nav-link">Home</a></li>
            <li><a href="menu.jsp" class="nav-link">Menu</a></li>
            <li><a href="offers.jsp" class="nav-link active">Offers</a></li>
            <li><a href="reservation.jsp" class="nav-link">Book a Table</a></li>
            <li><a href="reviews.jsp" class="nav-link">Reviews</a></li>
        </ul>
        <div class="nav-actions" id="navActions">
            <a href="login.jsp" class="btn btn-outline btn-sm">Login</a>
            <a href="register.jsp" class="btn btn-primary btn-sm">Register</a>
        </div>
    </div>
</nav>

<section class="page-banner">
    <div class="container">
        <h1>Special Offers</h1>
        <p>Exclusive deals, seasonal promotions and discount codes at Golden Reech</p>
    </div>
</section>

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
                <i class="fas fa-spinner fa-spin" style="color:#F4A100;"></i>
                <p>Loading offers...</p>
            </div>
        </div>

    </div>
</section>

<div class="toast" id="toast">
    <i class="fas fa-check-circle"></i>
    <span id="toastMsg">Copied!</span>
</div>

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
    <div class="footer-bottom"><p>&copy; 2024 Golden Reech. All rights reserved.</p></div>
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
                    '<div class="state-box" style="grid-column:1/-1;"><i class="fas fa-triangle-exclamation"></i><p>Could not load offers. Make sure Spring Boot is running.</p></div>';
            });
    }

    function renderPromos(list) {
        var grid = document.getElementById("promoGrid");

        if (!list || list.length === 0) {
            grid.innerHTML = '<div class="state-box" style="grid-column:1/-1;"><i class="fas fa-tag"></i><p>No active promotional offers at the moment.</p></div>';
            return;
        }

        var html = "";

        for (var i = 0; i < list.length; i++) {
            var o = list[i];

            var pct   = o.discountPercentage || 0;
            var start = o.startDate || null;
            var end   = o.endDate || null;
            var code  = o.offerCode || "";

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
                '<div class="promo-meta-row">' +
                '<i class="fas fa-calendar-day"></i>' +
                '<span>Valid from:</span>' +
                '<strong>' + fmt(start) + '</strong>' +
                '</div>' +
                '<div class="promo-meta-row">' +
                '<i class="fas fa-calendar-check"></i>' +
                '<span>Valid until:</span>' +
                '<strong>' + fmtEndDate(end) + '</strong>' +
                '</div>' +
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
            return (o.title || "").toLowerCase().includes(q) ||
                (o.description || "").toLowerCase().includes(q) ||
                (o.offerCode || "").toLowerCase().includes(q);
        }));
    }

    function fmt(d) {
        if (!d) return "-";

        var dt = new Date(d);

        return isNaN(dt.getTime()) ? "-" : dt.toLocaleDateString("en-GB", {
            day:"2-digit",
            month:"short",
            year:"numeric"
        });
    }

    function fmtEndDate(d) {
        if (!d) return "Still valid";
        return fmt(d);
    }

    function copyOfferCode(code) {
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(code).then(function() {
                showToast("Offer code copied: " + code);
            }).catch(function() {
                fallbackCopy(code);
            });
        } else {
            fallbackCopy(code);
        }
    }

    function fallbackCopy(code) {
        var temp = document.createElement("input");
        temp.value = code;
        document.body.appendChild(temp);
        temp.select();
        document.execCommand("copy");
        document.body.removeChild(temp);
        showToast("Offer code copied: " + code);
    }

    function showToast(msg) {
        var toast = document.getElementById("toast");
        document.getElementById("toastMsg").textContent = msg;
        toast.classList.add("show");

        setTimeout(function() {
            toast.classList.remove("show");
        }, 2200);
    }

    function esc(t) {
        return String(t || "").replace(/'/g, "\\'");
    }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>
</body>
</html>