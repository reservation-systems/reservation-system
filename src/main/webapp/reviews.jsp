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

    <title>Reviews - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">
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
            <li><a href="reviews.jsp" class="nav-link active">Reviews</a></li>
        </ul>

        <div class="nav-actions" id="navActions">
            <a href="login.jsp" class="btn btn-outline btn-sm">Login</a>
            <a href="register.jsp" class="btn btn-primary btn-sm">Register</a>
        </div>

    </div>
</nav>

<section class="page-banner">
    <div class="container">
        <h1>Reviews</h1>
        <p>Customer feedback from database</p>
    </div>
</section>

<section class="section">
    <div class="container">

        <div class="reviews-layout">

            <div class="review-form-card">

                <h2>
                    <i class="fas fa-pen"></i>
                    Write a Review
                </h2>

                <form id="reviewForm">

                    <div class="form-group">
                        <label class="form-label">Rating</label>
                        <select id="rating" class="form-control" required>
                            <option value="">Select rating</option>
                            <option value="5">5 - Excellent</option>
                            <option value="4">4 - Good</option>
                            <option value="3">3 - Average</option>
                            <option value="2">2 - Poor</option>
                            <option value="1">1 - Bad</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Comment</label>
                        <textarea id="comment"
                                  class="form-control"
                                  rows="5"
                                  placeholder="Write your review..."
                                  required></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-paper-plane"></i>
                        Submit Review
                    </button>

                </form>

            </div>

            <div class="reviews-list-section">

                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1.5rem;">
                    <h2>Guest Reviews</h2>

                    <select id="sortReviews"
                            class="form-control"
                            style="width:auto;"
                            onchange="sortReviews()">
                        <option value="recent">Most Recent</option>
                        <option value="highest">Highest Rated</option>
                        <option value="lowest">Lowest Rated</option>
                    </select>
                </div>

                <div class="card" style="margin-bottom:1.5rem;">
                    <div class="card-body" style="display:flex; align-items:center; gap:2rem; flex-wrap:wrap;">

                        <div style="text-align:center;">
                            <div id="averageRating"
                                 style="font-size:3rem; font-weight:700; color:var(--secondary-color);">
                                0.0
                            </div>

                            <div class="stars"
                                 id="averageStars"
                                 style="color:var(--warning-color);">
                            </div>

                            <p id="reviewCount"
                               style="margin-bottom:0; font-size:0.875rem; color:var(--dark-gray);">
                                Based on 0 reviews
                            </p>
                        </div>

                    </div>
                </div>

                <div class="reviews-list" id="reviewsList">
                    <p>Loading reviews...</p>
                </div>

            </div>

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

    let allReviews = [];

    document.addEventListener("DOMContentLoaded", () => {
        updateNavbar();
        loadReviews();

        document.getElementById("reviewForm")
            .addEventListener("submit", submitReview);
    });

    function updateNavbar() {
        const customer = JSON.parse(localStorage.getItem("customer"));
        const navActions = document.getElementById("navActions");

        if (customer) {
            navActions.innerHTML = `
                <a href="customer-dashboard.jsp" class="btn btn-outline btn-sm">
                    <i class="fas fa-user"></i> Dashboard
                </a>

                <button class="btn btn-primary btn-sm" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            `;
        }
    }

    async function loadReviews() {
        const list = document.getElementById("reviewsList");

        try {
            const response = await fetch(`${API_BASE}/reviews`);

            if (!response.ok) {
                throw new Error("Failed");
            }

            allReviews = await response.json();

            renderReviews(allReviews);
            updateReviewSummary(allReviews);

        } catch (error) {
            list.innerHTML = `
                <p>
                    Failed to load reviews.
                    Make sure Spring Boot is running.
                </p>
            `;
        }
    }

    function renderReviews(reviews) {
        const list = document.getElementById("reviewsList");

        if (reviews.length === 0) {
            list.innerHTML = "<p>No reviews found in database.</p>";
            return;
        }

        list.innerHTML = reviews.map(review => `
            <div class="review-item">

                <div class="review-header">

                    <div class="review-author">

                        <div class="avatar">
                            ${getInitials(review.customerName)}
                        </div>

                        <div class="info">
                            <h4>${review.customerName || "Guest"}</h4>
                            <p class="date">${formatDate(review.reviewDate)}</p>
                        </div>

                    </div>

                    <div class="review-rating">
                        ${getStars(review.rating)}
                    </div>

                </div>

                <p class="review-content">
                    ${review.comment || ""}
                </p>

            </div>
        `).join("");
    }

    async function submitReview(event) {
        event.preventDefault();

        const customer = JSON.parse(localStorage.getItem("customer"));

        if (!customer) {
            alert("Please login before writing a review.");
            window.location.href = "login.jsp";
            return;
        }

        const review = {
            customerName: customer.fullName || customer.name || "Customer",
            customerEmail: customer.email,
            rating: Number(document.getElementById("rating").value),
            comment: document.getElementById("comment").value
        };

        try {
            const response = await fetch(`${API_BASE}/reviews`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(review)
            });

            if (!response.ok) {
                throw new Error("Failed");
            }

            alert("Review submitted successfully!");

            document.getElementById("reviewForm").reset();

            loadReviews();

        } catch (error) {
            alert("Failed to submit review.");
        }
    }

    function updateReviewSummary(reviews) {
        if (reviews.length === 0) {
            document.getElementById("averageRating").textContent = "0.0";
            document.getElementById("averageStars").innerHTML = getStars(0);
            document.getElementById("reviewCount").textContent = "Based on 0 reviews";
            return;
        }

        const total = reviews.reduce((sum, r) => sum + Number(r.rating || 0), 0);
        const average = total / reviews.length;

        document.getElementById("averageRating").textContent = average.toFixed(1);
        document.getElementById("averageStars").innerHTML = getStars(Math.round(average));
        document.getElementById("reviewCount").textContent =
            `Based on ${reviews.length} reviews`;
    }

    function sortReviews() {
        const type = document.getElementById("sortReviews").value;
        let sorted = [...allReviews];

        if (type === "highest") {
            sorted.sort((a, b) => Number(b.rating || 0) - Number(a.rating || 0));
        } else if (type === "lowest") {
            sorted.sort((a, b) => Number(a.rating || 0) - Number(b.rating || 0));
        } else {
            sorted.reverse();
        }

        renderReviews(sorted);
    }

    function getStars(rating) {
        const value = Number(rating || 0);
        let stars = "";

        for (let i = 1; i <= 5; i++) {
            stars += `<i class="${i <= value ? "fas" : "far"} fa-star"></i>`;
        }

        return stars;
    }

    function getInitials(name) {
        if (!name) return "GU";

        return name
            .split(" ")
            .map(word => word.charAt(0))
            .join("")
            .substring(0, 2)
            .toUpperCase();
    }

    function formatDate(date) {
        if (!date) return "-";
        return new Date(date).toLocaleDateString();
    }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>

</body>
</html>