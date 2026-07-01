<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews - Golden Reech</title>
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
        .w-100 { width: 100%; justify-content: center; padding: .85rem; font-size: 1rem; }

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
        .reviews-layout {
            display: grid;
            grid-template-columns: 380px 1fr;
            gap: 28px;
            align-items: start;
        }
        @media (max-width: 900px) { .reviews-layout { grid-template-columns: 1fr; } }

        /* ══ FORM CARD ══ */
        .review-form-card {
            background: var(--white);
            border-radius: 18px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
        }
        .review-form-card h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--brown);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .review-form-card h2 i { color: var(--gold); }

        .form-group { margin-bottom: 1.2rem; }
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
        textarea.form-control { resize: vertical; min-height: 120px; }

        /* ══ REVIEWS LIST SECTION ══ */
        .reviews-list-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--brown);
        }

        .summary-card {
            background: var(--white);
            border-radius: 16px;
            padding: 1.6rem 2rem;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 2rem;
            flex-wrap: wrap;
        }
        .summary-rating {
            text-align: center;
        }
        .summary-rating .big-number {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 900;
            color: var(--gold-dk);
            line-height: 1;
        }
        .stars { color: var(--gold); font-size: 1.1rem; margin: 6px 0; }
        .summary-rating p {
            font-size: .85rem;
            color: #999;
        }

        /* ══ REVIEW ITEMS ══ */
        .reviews-list { display: flex; flex-direction: column; gap: 1rem; }
        .review-item {
            background: var(--white);
            border-radius: 16px;
            padding: 1.4rem 1.6rem;
            box-shadow: 0 2px 14px rgba(59,31,10,.06);
            transition: transform .2s, box-shadow .2s;
        }
        .review-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59,31,10,.1);
        }
        .review-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: .8rem;
            flex-wrap: wrap;
            gap: .5rem;
        }
        .review-author { display: flex; align-items: center; gap: .8rem; }
        .avatar {
            width: 44px; height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--gold), var(--gold-dk));
            color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: .9rem;
            flex-shrink: 0;
        }
        .review-author .info h4 {
            font-size: .95rem;
            font-weight: 700;
            color: var(--brown);
        }
        .review-author .info .date {
            font-size: .78rem;
            color: #999;
        }
        .review-rating { color: var(--gold); font-size: .95rem; }
        .review-content {
            font-size: .9rem;
            color: #555;
            line-height: 1.65;
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
            .footer-content { grid-template-columns: 1fr; gap: 2rem; }
            .summary-card { justify-content: center; text-align: center; }
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
            <li><a href="reviews.jsp"     class="nav-link active">Reviews</a></li>
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
        <h1>Guest <span>Reviews</span></h1>
        <p>Real feedback from our valued customers</p>
    </div>
</section>

<!-- ══ MAIN SECTION ══ -->
<section class="section">
    <div class="container">
        <div class="reviews-layout">

            <!-- LEFT — FORM -->
            <div class="review-form-card">
                <h2><i class="fas fa-pen"></i> Write a Review</h2>

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
                        <textarea id="comment" class="form-control" rows="5"
                                  placeholder="Write your review..." required></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-paper-plane"></i> Submit Review
                    </button>
                </form>
            </div>

            <!-- RIGHT — REVIEWS LIST -->
            <div class="reviews-list-section">

                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1.5rem; flex-wrap:wrap; gap:1rem;">
                    <h2>Guest Reviews</h2>
                    <select id="sortReviews" class="form-control" style="width:auto;" onchange="sortReviews()">
                        <option value="recent">Most Recent</option>
                        <option value="highest">Highest Rated</option>
                        <option value="lowest">Lowest Rated</option>
                    </select>
                </div>

                <div class="summary-card">
                    <div class="summary-rating">
                        <div class="big-number" id="averageRating">0.0</div>
                        <div class="stars" id="averageStars"></div>
                        <p id="reviewCount">Based on 0 reviews</p>
                    </div>
                </div>

                <div class="reviews-list" id="reviewsList">
                    <p>Loading reviews...</p>
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
    const API_BASE = "http://localhost:8080/api";
    let allReviews = [];

    document.addEventListener("DOMContentLoaded", () => {
        updateNavbar();
        loadReviews();
        document.getElementById("reviewForm").addEventListener("submit", submitReview);
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
                </button>`;
        }
    }

    async function loadReviews() {
        const list = document.getElementById("reviewsList");
        try {
            const response = await fetch(`${API_BASE}/reviews`);
            if (!response.ok) throw new Error("Failed");
            allReviews = await response.json();
            renderReviews(allReviews);
            updateReviewSummary(allReviews);
        } catch (error) {
            list.innerHTML = `<p style="opacity:.6;">Failed to load reviews. Make sure Spring Boot is running.</p>`;
        }
    }

    function renderReviews(reviews) {
        const list = document.getElementById("reviewsList");
        if (reviews.length === 0) {
            list.innerHTML = `<p style="opacity:.6;">No reviews found in database.</p>`;
            return;
        }
        list.innerHTML = reviews.map(review => `
            <div class="review-item">
                <div class="review-header">
                    <div class="review-author">
                        <div class="avatar">${getInitials(review.customerName)}</div>
                        <div class="info">
                            <h4>${review.customerName || "Guest"}</h4>
                            <p class="date">${formatDate(review.reviewDate)}</p>
                        </div>
                    </div>
                    <div class="review-rating">${getStars(review.rating)}</div>
                </div>
                <p class="review-content">${review.comment || ""}</p>
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
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(review)
            });
            if (!response.ok) throw new Error("Failed");
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
        document.getElementById("reviewCount").textContent = `Based on ${reviews.length} reviews`;
    }

    function sortReviews() {
        const type = document.getElementById("sortReviews").value;
        let sorted = [...allReviews];
        if (type === "highest") sorted.sort((a, b) => Number(b.rating || 0) - Number(a.rating || 0));
        else if (type === "lowest") sorted.sort((a, b) => Number(a.rating || 0) - Number(b.rating || 0));
        else sorted.reverse();
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
        return name.split(" ").map(w => w.charAt(0)).join("").substring(0, 2).toUpperCase();
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