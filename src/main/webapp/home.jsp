<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Golden Reech</title>
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

        /* ── Reset / Base ── */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; background: var(--cream); color: var(--brown); }

        /* ══════════════════════════════
           NAVBAR
        ══════════════════════════════ */
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

        .nav-menu {
            display: flex;
            list-style: none;
            gap: .25rem;
        }
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
        .btn-sm   { padding: .48rem 1.1rem; font-size: .85rem; }
        .btn-lg   { padding: .85rem 2rem;   font-size: 1rem; }
        .btn-outline {
            border: 1.5px solid var(--gold);
            color: var(--gold-dk);
            background: transparent;
        }
        .btn-outline:hover { background: var(--gold); color: var(--white); }
        .btn-primary  { background: var(--gold); color: var(--white); }
        .btn-primary:hover { background: var(--gold-dk); transform: translateY(-1px); box-shadow: 0 6px 20px rgba(244,166,35,.35); }

        /* ══════════════════════════════
           HERO  — full-width, tall, layered
        ══════════════════════════════ */
        .hero {
            position: relative;
            width: 100%;
            height: 100vh;
            min-height: 620px;
            max-height: 900px;
            margin-top: 70px;
            overflow: hidden;
            display: flex;
            align-items: center;
        }

        .hero-bg-image {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center center;
            z-index: 0;
        }

        .hero::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(
                    105deg,
                    rgba(30,13,3,.78) 0%,
                    rgba(30,13,3,.55) 45%,
                    rgba(30,13,3,.18) 100%
            );
            z-index: 1;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: -80px; right: 10%;
            width: 500px; height: 500px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(244,166,35,.22) 0%, transparent 70%);
            z-index: 1;
            pointer-events: none;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 640px;
            margin-left: clamp(2rem, 8vw, 140px);
            color: var(--white);
            animation: heroFadeUp .9s ease both;
        }

        .hero-eyebrow {
            display: inline-flex;
            align-items: center;
            gap: .5rem;
            font-size: .78rem;
            font-weight: 500;
            letter-spacing: .18em;
            text-transform: uppercase;
            color: var(--gold);
            margin-bottom: 1.1rem;
        }
        .hero-eyebrow::before,
        .hero-eyebrow::after {
            content: '';
            width: 28px; height: 1px;
            background: var(--gold);
            opacity: .6;
        }

        .hero-content h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.6rem, 5.5vw, 4.4rem);
            font-weight: 900;
            line-height: 1.1;
            margin-bottom: 1.2rem;
        }
        .hero-content h1 span { color: var(--gold); }

        .hero-content p {
            font-size: 1.05rem;
            line-height: 1.7;
            opacity: .88;
            max-width: 480px;
            margin-bottom: 2.2rem;
        }

        .hero-buttons { display: flex; gap: 1rem; flex-wrap: wrap; }

        .scroll-hint {
            position: absolute;
            bottom: 2.5rem;
            left: 50%;
            transform: translateX(-50%);
            z-index: 2;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: .4rem;
            color: rgba(255,255,255,.55);
            font-size: .72rem;
            letter-spacing: .12em;
            text-transform: uppercase;
        }
        .scroll-hint span { animation: bounce 1.8s infinite; display: block; }
        @keyframes bounce {
            0%,100% { transform: translateY(0); }
            50%      { transform: translateY(6px); }
        }

        @keyframes heroFadeUp {
            from { opacity: 0; transform: translateY(36px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ══════════════════════════════
           FEATURES STRIP
        ══════════════════════════════ */
        .features { padding: 80px 0; background: var(--cream); }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 2rem; }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }
        .section-title h2 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(1.8rem, 3vw, 2.5rem);
            font-weight: 700;
            color: var(--brown);
        }
        .section-title h2::after {
            content: '';
            display: block;
            width: 52px; height: 3px;
            background: var(--gold);
            margin: .7rem auto 0;
            border-radius: 2px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }
        .feature-card {
            background: var(--white);
            border-radius: 16px;
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: 0 4px 24px rgba(59,31,10,.07);
            transition: transform .25s, box-shadow .25s;
        }
        .feature-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow);
        }
        .feature-card i {
            font-size: 2rem;
            color: var(--gold);
            margin-bottom: 1rem;
            display: block;
        }
        .feature-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            margin-bottom: .6rem;
            color: var(--brown);
        }
        .feature-card p { font-size: .9rem; opacity: .72; line-height: 1.6; }

        /* ══════════════════════════════
           FEATURED DISHES
        ══════════════════════════════ */
        .featured-dishes { padding: 80px 0; background: #FDF3E3; }

        .dishes-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.8rem;
            margin-bottom: 2.5rem;
        }
        .dish-card {
            background: var(--white);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
            transition: transform .25s, box-shadow .25s;
        }
        .dish-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }
        .menu-image {
            height: 200px;
            background: linear-gradient(135deg, #f0d9b5, #e8c98a);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .menu-image img { width: 100%; height: 100%; object-fit: cover; }
        .menu-image i { font-size: 3rem; color: var(--gold-dk); opacity: .5; }
        .dish-content { padding: 1.4rem; }
        .dish-content h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.15rem;
            margin-bottom: .4rem;
            color: var(--brown);
        }
        .dish-price {
            font-weight: 700;
            color: var(--gold-dk);
            font-size: 1.1rem;
            margin-bottom: .5rem;
        }
        .dish-content p { font-size: .85rem; opacity: .7; line-height: 1.5; }

        .text-center { text-align: center; }
        .mt-4 { margin-top: 1.5rem; }
        .section { padding: 80px 0; }

        /* ══════════════════════════════
           FOOTER
        ══════════════════════════════ */
        .customer-footer {
            background: var(--brown);
            color: rgba(255,255,255,.75);
        }
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

        /* ── Responsive ── */
        @media (max-width: 900px) {
            .features-grid, .dishes-grid { grid-template-columns: 1fr 1fr; }
            .footer-content { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 620px) {
            .nav-menu { display: none; }
            .features-grid, .dishes-grid { grid-template-columns: 1fr; }
            .footer-content { grid-template-columns: 1fr; gap: 2rem; }
            .hero-content { margin-left: 1.5rem; margin-right: 1.5rem; }
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
            <li><a href="home.jsp"        class="nav-link active">Home</a></li>
            <li><a href="menu.jsp"        class="nav-link">Menu</a></li>
            <li><a href="offers.jsp"      class="nav-link">Offers</a></li>
            <li><a href="reservation.jsp" class="nav-link">Book a Table</a></li>
            <li><a href="reviews.jsp"     class="nav-link">Reviews</a></li>
        </ul>
        <div class="nav-actions" id="navActions">
            <a href="login.jsp"    class="btn btn-outline btn-sm">Login</a>
            <a href="register.jsp" class="btn btn-primary  btn-sm">Register</a>
        </div>
    </div>
</nav>

<!-- ══ HERO ══ -->
<section class="hero">
    <img src="./images/restaurant-banner.jpg"
         class="hero-bg-image"
         alt="Restaurant Banner">

    <div class="hero-content">
        <div class="hero-eyebrow">
            <span></span> Fine Dining Experience <span></span>
        </div>

        <h1>
            Experience<br>
            <span>Culinary</span><br>
            Excellence
        </h1>

        <p>
            Reserve your table, browse our curated menu,
            and enjoy exclusive offers from Golden Reech.
        </p>

        <div class="hero-buttons">
            <a href="reservation.jsp" class="btn btn-primary btn-lg">
                <i class="fas fa-calendar-check"></i>
                Book a Table
            </a>
            <a href="menu.jsp" class="btn btn-outline btn-lg">
                <i class="fas fa-book-open"></i>
                View Menu
            </a>
        </div>
    </div>

    <div class="scroll-hint">
        <span>&#8595;</span>
        Scroll
    </div>
</section>

<!-- ══ FEATURES ══ -->
<section class="features section">
    <div class="container">
        <div class="section-title">
            <h2>Why Choose Golden Reech</h2>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <i class="fas fa-utensils"></i>
                <h3>Fresh Menu</h3>
                <p>Fresh food prepared daily by our professional chefs using the finest local ingredients.</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-calendar-check"></i>
                <h3>Easy Booking</h3>
                <p>Reserve your table online quickly and easily — no waiting, no hassle.</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-tags"></i>
                <h3>Special Offers</h3>
                <p>Enjoy exclusive discounts and seasonal food offers crafted just for you.</p>
            </div>
        </div>
    </div>
</section>

<!-- ══ FEATURED DISHES ══ -->
<section class="featured-dishes section">
    <div class="container">
        <div class="section-title">
            <h2>Featured Dishes</h2>
        </div>
        <div class="dishes-grid" id="featuredDishes">
            <p>Loading menu items...</p>
        </div>
        <div class="text-center mt-4">
            <a href="menu.jsp" class="btn btn-primary btn-lg">View Full Menu</a>
        </div>
    </div>
</section>

<!-- ══ FOOTER ══ -->
<footer class="customer-footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>About Us</h3>
            <p>Golden Reech is a modern restaurant offering delicious meals and quality service in a warm, welcoming atmosphere.</p>
        </div>
        <div class="footer-section">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="menu.jsp">Menu</a></li>
                <li><a href="reservation.jsp">Reservations</a></li>
                <li><a href="offers.jsp">Offers</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h3>Contact</h3>
            <ul>
                <li><i class="fas fa-phone"></i> +94 77 568 4650</li>
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

    document.addEventListener("DOMContentLoaded", () => {
        updateNavbar();
        loadFeaturedDishes();
    });

    function updateNavbar() {
        const customer   = JSON.parse(localStorage.getItem("customer"));
        const navActions = document.getElementById("navActions");
        if (customer) {
            navActions.innerHTML = `
                <a href="customer-dashboard.jsp" class="btn btn-outline btn-sm">
                    <i class="fas fa-user"></i> Account
                </a>
                <button class="btn btn-primary btn-sm" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>`;
        }
    }

    async function loadFeaturedDishes() {
        const container = document.getElementById("featuredDishes");
        try {
            const response  = await fetch(`${API_BASE}/menu/available`);
            const menuItems = await response.json();
            if (menuItems.length === 0) {
                container.innerHTML = "<p>No menu items found.</p>";
                return;
            }

            const savedPhotos = JSON.parse(localStorage.getItem("menuPhotos") || "{}");
            container.innerHTML = menuItems.slice(0, 3).map(item => {
                const photo = savedPhotos[item.id] || "";
                return `
                    <div class="dish-card">
                        <div class="menu-image">
                            ${photo
                                ? `<img src="${photo}" class="food-photo" alt="${item.name}">`
                                : `<i class="fas fa-utensils"></i>`}
                        </div>
                        <div class="dish-content">
                            <h3>${item.name}</h3>
                            <div class="dish-price">Rs. ${Number(item.price).toFixed(2)}</div>
                            <p>${item.description || "No description available"}</p>
                        </div>
                    </div>`;
            }).join("");
        } catch (error) {
            container.innerHTML = "<p>Failed to load menu items.</p>";
        }
    }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>

</body>
</html>