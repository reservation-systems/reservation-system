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

    <title>Menu - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
        .menu-card {
            border-radius: 20px;
            overflow: hidden;
        }

        .menu-image {
            width: 100%;
            height: 250px;
            background: #222;
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .food-photo {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .menu-image i {
            font-size: 42px;
            color: #F4A100;
        }

        .menu-image-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 22px;
            background: linear-gradient(
                    transparent,
                    rgba(0, 0, 0, 0.85)
            );
            color: #ffffff;
        }

        .menu-image-overlay h3 {
            margin: 0;
            font-size: 28px;
            font-weight: 700;
            color: #ffffff;
        }

        .menu-image-overlay .price {
            display: block;
            margin-top: 8px;
            font-size: 20px;
            font-weight: 600;
            color: #ffffff;
        }

        .menu-content {
            padding-top: 12px;
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
            <li><a href="menu.jsp" class="nav-link active">Menu</a></li>
            <li><a href="offers.jsp" class="nav-link">Offers</a></li>
            <li><a href="reservation.jsp" class="nav-link">Book a Table</a></li>
            <li><a href="reviews.jsp" class="nav-link">Reviews</a></li>
        </ul>

        <div class="nav-actions" id="navActions">
            <a href="login.jsp" class="btn btn-outline btn-sm">Login</a>
            <a href="register.jsp" class="btn btn-primary btn-sm">Register</a>
        </div>

        <button class="mobile-menu-toggle" onclick="toggleMobileMenu()">
            <i class="fas fa-bars"></i>
        </button>

    </div>
</nav>

<section class="page-banner">
    <div class="container">
        <h1>Our Menu</h1>
        <p>Freshly prepared dishes from Golden Reech</p>
    </div>
</section>

<section class="menu-page section">
    <div class="container">

        <div class="menu-filters">

            <button class="filter-btn active" onclick="filterMenu('ALL', event)">
                All
            </button>

            <button class="filter-btn" onclick="filterMenu('STARTER', event)">
                Starters
            </button>

            <button class="filter-btn" onclick="filterMenu('MAIN_COURSE', event)">
                Main Course
            </button>

            <button class="filter-btn" onclick="filterMenu('DESSERT', event)">
                Desserts
            </button>

            <button class="filter-btn" onclick="filterMenu('DRINK', event)">
                Drinks
            </button>

        </div>

        <div class="menu-grid" id="menuContainer">
            <p>Loading menu items...</p>
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

    let allMenuItems = [];

    document.addEventListener("DOMContentLoaded", () => {
        updateNavbar();
        loadMenuItems();
    });

    function updateNavbar() {
        const customer = JSON.parse(localStorage.getItem("customer"));
        const navActions = document.getElementById("navActions");

        if (customer) {
            navActions.innerHTML = `
                <a href="customer-dashboard.jsp" class="btn btn-outline btn-sm">
                    <i class="fas fa-user"></i> Account
                </a>

                <button class="btn btn-primary btn-sm" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            `;
        }
    }

    async function loadMenuItems() {
        const container = document.getElementById("menuContainer");

        try {
            const response = await fetch(`${API_BASE}/menu`);

            if (!response.ok) {
                throw new Error("Failed to fetch menu");
            }

            allMenuItems = await response.json();

            renderMenu(allMenuItems);

        } catch (error) {
            container.innerHTML = `
                <p>
                    Failed to load menu items.
                    Make sure Spring Boot is running.
                </p>
            `;
        }
    }

    function renderMenu(menuItems) {
        const container = document.getElementById("menuContainer");

        if (menuItems.length === 0) {
            container.innerHTML = `
                <p>No menu items found in database.</p>
            `;
            return;
        }

        const savedPhotos =
            JSON.parse(localStorage.getItem("menuPhotos") || "{}");

        container.innerHTML = menuItems.map(item => {
            const photo = savedPhotos[item.id] || item.photo || "";

            return `
                <div class="menu-card">

                    <div class="menu-image">

                        ${
                            photo
                                ? `
                                    <img src="${photo}"
                                         class="food-photo"
                                         alt="${item.name || 'Food'}">
                                  `
                                : `
                                    <i class="fas fa-utensils"></i>
                                  `
                        }

                        <div class="menu-image-overlay">
                            <h3>${item.name || "Menu Item"}</h3>

                            <span class="price">
                                Rs. ${Number(item.price || 0).toFixed(2)}
                            </span>
                        </div>

                    </div>

                    <div class="menu-content">

                        <p class="description">
                            ${item.description || "No description available"}
                        </p>

                        <div class="menu-footer">

                            <span class="category">
                                ${formatCategory(item.category)}
                            </span>

                            <button class="btn btn-primary btn-sm"
                                    onclick="bookTable()">
                                Order
                            </button>

                        </div>

                    </div>

                </div>
            `;
        }).join("");
    }

    function filterMenu(category, event) {
        document.querySelectorAll(".filter-btn").forEach(btn => {
            btn.classList.remove("active");
        });

        event.target.classList.add("active");

        if (category === "ALL") {
            renderMenu(allMenuItems);
            return;
        }

        const filtered = allMenuItems.filter(item =>
            item.category === category
        );

        renderMenu(filtered);
    }

    function formatCategory(category) {
        if (!category) {
            return "Food";
        }

        return category
            .replaceAll("_", " ")
            .toLowerCase()
            .replace(/\b\w/g, c => c.toUpperCase());
    }

    function bookTable() {
        window.location.href = "reservation.jsp";
    }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>

</body>
</html>