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

    <title>Review Management - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/admin.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
        .sidebar-nav-item.active{
            background:linear-gradient(135deg,#ff9800,#ff6f00);
            color:#fff !important;
            border-radius:12px;
            margin:6px 10px;
            font-weight:700;
            box-shadow:0 4px 15px rgba(255,152,0,0.3);
        }

        .sidebar-nav-item.active i{
            color:#fff !important;
        }

        .sidebar-nav-item{
            transition:0.25s;
            border-radius:12px;
            margin:4px 10px;
        }

        .sidebar-nav-item:hover{
            background:#fff3e0;
            transform:translateX(4px);
        }

        .sidebar-nav-title{
            padding-left:18px;
            margin-top:18px;
            font-size:12px;
            font-weight:700;
            color:#ff9800;
            letter-spacing:1px;
            text-transform:uppercase;
        }
    </style>
</head>

<body>

<div class="admin-layout">

    <aside class="admin-sidebar">

        <div class="sidebar-header">
            <div class="sidebar-logo">
                <i class="fas fa-utensils"></i>
            </div>
            <h2>Admin Portal</h2>
        </div>

        <div class="sidebar-user">
            <div class="avatar">AD</div>
            <div class="info">
                <p class="name">Admin User</p>
                <p class="role">Restaurant Manager</p>
            </div>
        </div>

        <nav class="sidebar-nav">

            <p class="sidebar-nav-title">Main</p>

            <a href="admin-dashboard.jsp" class="sidebar-nav-item">
                <i class="fas fa-gauge-high"></i>
                <span>Dashboard</span>
            </a>

            <a href="reservations-admin.jsp" class="sidebar-nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Reservations</span>
            </a>

            <a href="customers.jsp" class="sidebar-nav-item">
                <i class="fas fa-users"></i>
                <span>Customers</span>
            </a>

            <a href="tables.jsp" class="sidebar-nav-item">
                <i class="fas fa-chair"></i>
                <span>Tables</span>
            </a>

            <p class="sidebar-nav-title">Management</p>

            <a href="menu-management.jsp" class="sidebar-nav-item">
                <i class="fas fa-utensils"></i>
                <span>Menu</span>
            </a>

            <a href="staff.jsp" class="sidebar-nav-item">
                <i class="fas fa-user-tie"></i>
                <span>Staff</span>
            </a>

            <a href="offers-management.jsp" class="sidebar-nav-item">
                <i class="fas fa-tag"></i>
                <span>Offers</span>
            </a>

            <p class="sidebar-nav-title">Finance</p>

            <a href="payments.jsp" class="sidebar-nav-item">
                <i class="fas fa-credit-card"></i>
                <span>Payments</span>
            </a>

            <p class="sidebar-nav-title">Other</p>

            <a href="reviews-management.jsp" class="sidebar-nav-item active">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>

            <a href="home.jsp" class="sidebar-nav-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>

        </nav>

    </aside>

    <main class="admin-main">

        <nav class="admin-navbar">

            <div class="navbar-left">

                <button class="sidebar-toggle"
                        onclick="toggleSidebar()">

                    <i class="fas fa-bars"></i>

                </button>

                <div class="breadcrumb">
                    <a href="admin-dashboard.jsp">Dashboard</a>
                    <i class="fas fa-chevron-right"
                       style="font-size:0.75rem;"></i>
                    <span>Reviews</span>
                </div>

            </div>

            <div class="navbar-right">

                <div class="search-box">

                    <i class="fas fa-search"></i>

                    <input type="text"
                           id="reviewSearch"
                           placeholder="Search reviews..."
                           onkeyup="filterReviews()">

                </div>

            </div>

        </nav>

        <div class="admin-content">

            <div class="page-header">

                <h1>Review Management</h1>

                <div class="page-actions">

                    <button class="btn btn-outline"
                            onclick="window.print()">

                        <i class="fas fa-print"></i>
                        Print

                    </button>

                </div>

            </div>

            <div class="stats-grid">

                <div class="stat-card primary">

                    <h3 id="totalReviews">0</h3>
                    <p>Total Reviews</p>

                </div>

                <div class="stat-card success">

                    <h3 id="averageRating">0.0</h3>
                    <p>Average Rating</p>

                </div>

                <div class="stat-card warning">

                    <h3 id="fiveStarReviews">0</h3>
                    <p>5 Star Reviews</p>

                </div>

            </div>

            <div class="data-table-container">

                <div class="table-header">

                    <h3>Customer Reviews</h3>

                    <select class="form-control"
                            id="ratingFilter"
                            onchange="filterReviews()">

                        <option value="">All Ratings</option>
                        <option value="5">5 Stars</option>
                        <option value="4">4 Stars</option>
                        <option value="3">3 Stars</option>
                        <option value="2">2 Stars</option>
                        <option value="1">1 Star</option>

                    </select>

                </div>

                <div class="table-responsive">

                    <table class="data-table">

                        <thead>

                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Email</th>
                            <th>Rating</th>
                            <th>Comment</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>

                        </thead>

                        <tbody id="reviewsTableBody">

                        <tr>
                            <td colspan="7">
                                Loading reviews...
                            </td>
                        </tr>

                        </tbody>

                    </table>

                </div>

                <div class="table-footer">

                    <p id="footerText">
                        Showing 0 reviews
                    </p>

                </div>

            </div>

        </div>

    </main>

</div>

<script src="./js/main.js"></script>
<script src="./js/admin.js"></script>

<script>

    const API_BASE =
        "http://localhost:8080/api";

    let allReviews = [];

    document.addEventListener(
        "DOMContentLoaded",
        loadReviews
    );

    async function loadReviews(){

        const tbody =
            document.getElementById(
                "reviewsTableBody"
            );

        try{

            const response =
                await fetch(
                    `${API_BASE}/reviews`
                );

            if(!response.ok){

                throw new Error("Failed");
            }

            allReviews =
                await response.json();

            renderReviews(
                allReviews
            );

            updateStats(
                allReviews
            );

        }catch(error){

            tbody.innerHTML = `
                <tr>
                    <td colspan="7">
                        Failed to load reviews.
                        Make sure Spring Boot is running.
                    </td>
                </tr>
            `;
        }
    }

    function renderReviews(reviews){

        const tbody =
            document.getElementById(
                "reviewsTableBody"
            );

        document.getElementById(
            "footerText"
        ).textContent =
            `Showing ${reviews.length} reviews`;

        if(reviews.length === 0){

            tbody.innerHTML = `
                <tr>
                    <td colspan="7">
                        No reviews found.
                    </td>
                </tr>
            `;

            return;
        }

        tbody.innerHTML =
            reviews.map(r => `

            <tr>

                <td>#${r.id}</td>

                <td>${r.customerName || "-"}</td>

                <td>${r.customerEmail || "-"}</td>

                <td style="color:orange;">
                    ${getStars(r.rating)}
                </td>

                <td>
                    ${r.comment || "-"}
                </td>

                <td>
                    ${formatDate(r.reviewDate)}
                </td>

                <td>

                    <div class="actions">

                        <button class="action-btn view"
                                onclick="viewReview(${r.id})"
                                title="View">

                            <i class="fas fa-eye"></i>

                        </button>

                        <button class="action-btn delete"
                                onclick="deleteReview(${r.id})"
                                title="Delete">

                            <i class="fas fa-trash"></i>

                        </button>

                    </div>

                </td>

            </tr>

        `).join("");
    }

    function updateStats(reviews){

        const total =
            reviews.length;

        const fiveStars =
            reviews.filter(
                r => Number(r.rating) === 5
            ).length;

        let average = 0;

        if(total > 0){

            average =
                reviews.reduce(
                    (sum, r) =>
                        sum + Number(r.rating || 0),
                    0
                ) / total;
        }

        document.getElementById(
            "totalReviews"
        ).textContent =
            total;

        document.getElementById(
            "averageRating"
        ).textContent =
            average.toFixed(1);

        document.getElementById(
            "fiveStarReviews"
        ).textContent =
            fiveStars;
    }

    function filterReviews(){

        const keyword =
            document.getElementById(
                "reviewSearch"
            ).value.toLowerCase();

        const rating =
            document.getElementById(
                "ratingFilter"
            ).value;

        const filtered =
            allReviews.filter(r => {

                const matchesKeyword =

                    (r.customerName || "")
                        .toLowerCase()
                        .includes(keyword)

                    ||

                    (r.customerEmail || "")
                        .toLowerCase()
                        .includes(keyword)

                    ||

                    (r.comment || "")
                        .toLowerCase()
                        .includes(keyword);

                const matchesRating =

                    rating === ""
                    ||
                    String(r.rating) === rating;

                return matchesKeyword
                    &&
                    matchesRating;
            });

        renderReviews(filtered);

        updateStats(filtered);
    }

    function viewReview(id){

        const review =
            allReviews.find(
                r => r.id === id
            );

        if(!review){
            return;
        }

        alert(

            `Review Details\n\n`

            +

            `Customer: ${review.customerName}\n`

            +

            `Email: ${review.customerEmail}\n`

            +

            `Rating: ${review.rating} Stars\n`

            +

            `Date: ${review.reviewDate}\n\n`

            +

            `Comment:\n${review.comment}`
        );
    }

    async function deleteReview(id){

        if(!confirm(
            `Delete review #${id}?`
        )){
            return;
        }

        try{

            const response =
                await fetch(
                    `${API_BASE}/reviews/${id}`,
                    {
                        method:"DELETE"
                    }
                );

            if(!response.ok){

                throw new Error("Failed");
            }

            loadReviews();

        }catch(error){

            alert(
                "Failed to delete review."
            );
        }
    }

    function getStars(rating){

        let stars = "";

        for(let i = 1; i <= 5; i++){

            if(i <= rating){

                stars +=
                    `<i class="fas fa-star"></i>`;

            }else{

                stars +=
                    `<i class="far fa-star"></i>`;
            }
        }

        return stars;
    }

    function formatDate(date){

        if(!date){
            return "-";
        }

        return new Date(date)
            .toLocaleDateString();
    }

</script>

</body>
</html>