<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Golden Reech</title>
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
        .btn-sm  { padding: .48rem 1.1rem; font-size: .85rem; }
        .btn-lg  { padding: .85rem 2rem;   font-size: 1rem; }
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
        .page-banner p {
            font-size: 1rem;
            opacity: .75;
        }

        /* ══ CONTAINER / SECTION ══ */
        .container { max-width: 1200px; margin: 0 auto; padding: 0 2rem; }
        .section { padding: 80px 0; }
        .menu-page { background: var(--cream); }

        /* ══ FILTER BUTTONS ══ */
        .menu-filters {
            display: flex;
            flex-wrap: wrap;
            gap: .6rem;
            justify-content: center;
            margin-bottom: 2.5rem;
        }
        .filter-btn {
            font-family: 'DM Sans', sans-serif;
            font-size: .88rem;
            font-weight: 500;
            padding: .5rem 1.4rem;
            border-radius: 50px;
            border: 1.5px solid rgba(59,31,10,.18);
            background: var(--white);
            color: var(--brown);
            cursor: pointer;
            transition: all .2s ease;
        }
        .filter-btn:hover {
            border-color: var(--gold);
            color: var(--gold-dk);
            background: rgba(244,166,35,.08);
        }
        .filter-btn.active {
            background: var(--gold);
            border-color: var(--gold);
            color: var(--white);
            box-shadow: 0 4px 14px rgba(244,166,35,.35);
        }

        /* ══ MENU GRID ══ */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.8rem;
        }

        /* ══ MENU CARD ══ */
        .menu-card {
            background: var(--white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
            transition: transform .25s, box-shadow .25s;
        }
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .menu-image {
            width: 100%;
            height: 220px;
            background: linear-gradient(135deg, #f0d9b5, #e8c98a);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .food-photo {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .menu-image i { font-size: 2.8rem; color: var(--gold-dk); opacity: .5; }

        .menu-image-overlay {
            position: absolute;
            bottom: 0; left: 0;
            width: 100%;
            padding: 1.2rem 1.4rem;
            background: linear-gradient(transparent, rgba(0,0,0,.82));
            color: var(--white);
        }
        .menu-image-overlay h3 {
            margin: 0;
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--white);
        }
        .menu-image-overlay .price {
            display: block;
            margin-top: .3rem;
            font-size: 1rem;
            font-weight: 600;
            color: var(--gold);
        }

        .menu-content { padding: 1.2rem 1.4rem 1.4rem; }
        .description {
            font-size: .88rem;
            opacity: .72;
            line-height: 1.55;
            margin-bottom: 1rem;
        }
        .menu-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: .5rem;
        }
        .category {
            font-size: .78rem;
            font-weight: 500;
            background: rgba(244,166,35,.12);
            color: var(--gold-dk);
            padding: .28rem .8rem;
            border-radius: 50px;
            white-space: nowrap;
        }

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
        .footer-section p  { font-size: .88rem; line-height: 1.7; }
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
            .menu-grid { grid-template-columns: 1fr 1fr; }
            .footer-content { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 620px) {
            .nav-menu { display: none; }
            .menu-grid { grid-template-columns: 1fr; }
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
            <li><a href="menu.jsp"        class="nav-link active">Menu</a></li>
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

<!-- ══ PAGE BANNER ══ -->
<section class="page-banner">
    <div class="container">
        <h1>Our <span>Menu</span></h1>
        <p>Freshly prepared dishes from Golden Reech</p>
    </div>
</section>

<!-- ══ MENU SECTION ══ -->
<section class="menu-page section">
    <div class="container">

        <div class="menu-filters">
            <button class="filter-btn active" onclick="filterMenu('ALL', event)">All</button>
            <button class="filter-btn" onclick="filterMenu('STARTER', event)">Starters</button>
            <button class="filter-btn" onclick="filterMenu('MAIN_COURSE', event)">Main Course</button>
            <button class="filter-btn" onclick="filterMenu('DESSERT', event)">Desserts</button>
            <button class="filter-btn" onclick="filterMenu('DRINK', event)">Drinks</button>
        </div>

        <div class="menu-grid" id="menuContainer">
            <p>Loading menu items...</p>
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

<script src="./js/main.js"></script>
<script>
    const API_BASE = "http://localhost:8080/api";
    let allMenuItems = [];

    document.addEventListener("DOMContentLoaded", () => {
        updateNavbar();
        loadMenuItems();
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

    async function loadMenuItems() {
        const container = document.getElementById("menuContainer");
        try {
            const response = await fetch(`${API_BASE}/menu`);
            if (!response.ok) throw new Error("Failed to fetch menu");
            allMenuItems = await response.json();
            renderMenu(allMenuItems);
        } catch (error) {
            container.innerHTML = `<p style="opacity:.6;grid-column:1/-1;text-align:center;padding:3rem 0">
                Failed to load menu items. Make sure Spring Boot is running.</p>`;
        }
    }

    function renderMenu(menuItems) {
        const container  = document.getElementById("menuContainer");
        if (menuItems.length === 0) {
            container.innerHTML = `<p style="opacity:.6;grid-column:1/-1;text-align:center;padding:3rem 0">
                No menu items found.</p>`;
            return;
        }
        const savedPhotos = JSON.parse(localStorage.getItem("menuPhotos") || "{}");
        container.innerHTML = menuItems.map(item => {
            const photo = savedPhotos[item.id] || item.photo || "";
            return `
            <div class="menu-card">
                <div class="menu-image">
                    ${photo
                        ? `<img src="${photo}" class="food-photo" alt="${item.name || 'Food'}">`
                        : `<i class="fas fa-utensils"></i>`}
                    <div class="menu-image-overlay">
                        <h3>${item.name || "Menu Item"}</h3>
                        <span class="price">Rs. ${Number(item.price || 0).toFixed(2)}</span>
                    </div>
                </div>
                <div class="menu-content">
                    <p class="description">${item.description || "No description available"}</p>
                    <div class="menu-footer">
                        <span class="category">${formatCategory(item.category)}</span>
                        <button class="btn btn-primary btn-sm" onclick="bookTable()">
                            <i class="fas fa-calendar-check"></i> Book Table
                        </button>
                    </div>
                </div>
            </div>`;
        }).join("");
    }

    function filterMenu(category, event) {
        document.querySelectorAll(".filter-btn").forEach(btn => btn.classList.remove("active"));
        event.target.classList.add("active");
        renderMenu(category === "ALL" ? allMenuItems : allMenuItems.filter(i => i.category === category));
    }

    function formatCategory(category) {
        if (!category) return "Food";
        return category.replaceAll("_", " ").toLowerCase().replace(/\b\w/g, c => c.toUpperCase());
    }

    function bookTable() { window.location.href = "reservation.jsp"; }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>

</body>
</html>