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

    <title>Offers Management - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/admin.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
        .sidebar-nav-item.active {
            background: linear-gradient(135deg,#ff9800,#ff6f00);
            color: #fff !important;
            border-radius: 12px;
            margin: 6px 10px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(255,152,0,0.3);
        }

        .sidebar-nav-item.active i {
            color: #fff !important;
        }

        .sidebar-nav-item {
            transition: 0.25s;
            border-radius: 12px;
            margin: 4px 10px;
        }

        .sidebar-nav-item:hover {
            background: #fff3e0;
            transform: translateX(4px);
        }

        .sidebar-nav-title {
            padding-left: 18px;
            margin-top: 18px;
            font-size: 12px;
            font-weight: 700;
            color: #ff9800;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
        }

        .breadcrumb a {
            color: #ff9800;
            text-decoration: none;
        }

        .breadcrumb span {
            color: #555;
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

            <a href="offers-management.jsp" class="sidebar-nav-item active">
                <i class="fas fa-tag"></i>
                <span>Offers</span>
            </a>

            <p class="sidebar-nav-title">Finance</p>

            <a href="payments.jsp" class="sidebar-nav-item">
                <i class="fas fa-credit-card"></i>
                <span>Payments</span>
            </a>

            <p class="sidebar-nav-title">Other</p>

            <a href="reviews-management.jsp" class="sidebar-nav-item">
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

                <button class="sidebar-toggle" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>

                <div class="breadcrumb">
                    <a href="admin-dashboard.jsp">Dashboard</a>
                    <i class="fas fa-chevron-right"
                       style="font-size:0.75rem;color:#999;"></i>
                    <span>Offers</span>
                </div>

            </div>

            <div class="navbar-right">

                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text"
                           id="offerSearch"
                           placeholder="Search offers..."
                           onkeyup="filterOffers()">
                </div>

            </div>

        </nav>

        <div class="admin-content">

            <div class="page-header">

                <h1>Offers Management</h1>

                <div class="page-actions">

                    <button class="btn btn-outline" onclick="window.print()">
                        <i class="fas fa-print"></i>
                        Print
                    </button>

                    <button class="btn btn-primary" onclick="openOfferForm()">
                        <i class="fas fa-plus"></i>
                        Add Offer
                    </button>

                </div>

            </div>

            <div id="offerFormBox"
                 class="data-table-container"
                 style="display:none; margin-bottom:1.5rem;">

                <div class="table-header">
                    <h3 id="formTitle">Add Offer</h3>
                </div>

                <div style="padding:1rem;">

                    <input type="hidden" id="offerId">

                    <div class="form-group">
                        <label class="form-label">Offer Title</label>
                        <input type="text"
                               id="offerTitle"
                               class="form-control"
                               placeholder="Enter offer title">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Offer Code</label>
                        <input type="text"
                               id="offerCode"
                               class="form-control"
                               placeholder="e.g. GOLDEN50">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Discount Percentage</label>
                        <input type="number"
                               id="discountPercentage"
                               class="form-control"
                               placeholder="e.g. 10"
                               min="1"
                               max="100">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Start Date</label>
                        <input type="date"
                               id="startDate"
                               class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">End Date</label>
                        <input type="date"
                               id="endDate"
                               class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea id="offerDescription"
                                  class="form-control"
                                  rows="3"
                                  placeholder="Describe this offer..."></textarea>
                    </div>

                    <div class="form-group">
                        <label style="display:flex; align-items:center; gap:0.5rem;">
                            <input type="checkbox" id="offerActive" checked>
                            Active Offer
                        </label>
                    </div>

                    <button class="btn btn-primary" onclick="saveOffer()">
                        Save
                    </button>

                    <button class="btn btn-outline" onclick="closeOfferForm()">
                        Cancel
                    </button>

                </div>

            </div>

            <div class="data-table-container">

                <div class="table-header">
                    <h3 id="offerCount">All Offers (0)</h3>
                </div>

                <div class="table-responsive">

                    <table class="data-table">

                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Code</th>
                            <th>Discount</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>

                        <tbody id="offersBody">
                        <tr>
                            <td colspan="8">Loading offers...</td>
                        </tr>
                        </tbody>

                    </table>

                </div>

                <div class="table-footer">
                    <p id="footerText">Showing 0 offers from database</p>
                </div>

            </div>

        </div>

    </main>

</div>

<script src="./js/main.js"></script>
<script src="./js/admin.js"></script>

<script>
    const API_BASE = "http://localhost:8080/api";

    let allOffers = [];

    document.addEventListener("DOMContentLoaded", loadOffers);

    async function loadOffers() {
        try {
            const r = await fetch(API_BASE + "/offers");

            if (!r.ok) {
                throw new Error();
            }

            allOffers = await r.json();

            renderOffers(allOffers);

        } catch (e) {
            document.getElementById("offersBody").innerHTML =
                '<tr><td colspan="8">Failed to load offers. Make sure Spring Boot is running.</td></tr>';
        }
    }

    function renderOffers(offers) {

        document.getElementById("offerCount").textContent =
            "All Offers (" + offers.length + ")";

        document.getElementById("footerText").textContent =
            "Showing " + offers.length + " offers from database";

        if (!offers.length) {
            document.getElementById("offersBody").innerHTML =
                '<tr><td colspan="8">No offers found in database.</td></tr>';
            return;
        }

        document.getElementById("offersBody").innerHTML =
            offers.map(function(o) {
                return '<tr>' +
                    '<td>#' + o.id + '</td>' +
                    '<td><strong>' + (o.title || "-") + '</strong></td>' +
                    '<td><span style="font-weight:700; color:#ff9800;">' + (o.offerCode || "-") + '</span></td>' +
                    '<td><span style="font-weight:600; color:#ff9800;">' + (o.discountPercentage || 0) + '% OFF</span></td>' +
                    '<td>' + fmt(o.startDate) + '</td>' +
                    '<td>' + fmtEndDate(o.endDate) + '</td>' +
                    '<td><span class="badge ' + (o.active ? "badge-confirmed" : "badge-cancelled") + '">' + (o.active ? "ACTIVE" : "INACTIVE") + '</span></td>' +
                    '<td><div class="actions">' +
                    '<button class="action-btn edit" onclick="editOffer(' + o.id + ')" title="Edit"><i class="fas fa-edit"></i></button>' +
                    '<button class="action-btn delete" onclick="deleteOffer(' + o.id + ',\'' + esc(o.title) + '\')" title="Delete"><i class="fas fa-trash"></i></button>' +
                    '</div></td>' +
                    '</tr>';
            }).join("");
    }

    function openOfferForm() {

        document.getElementById("offerFormBox").style.display = "block";
        document.getElementById("formTitle").textContent = "Add Offer";

        [
            "offerId",
            "offerTitle",
            "offerCode",
            "discountPercentage",
            "startDate",
            "endDate",
            "offerDescription"
        ].forEach(function(id) {
            document.getElementById(id).value = "";
        });

        document.getElementById("offerActive").checked = true;
    }

    function closeOfferForm() {
        document.getElementById("offerFormBox").style.display = "none";
    }

    async function saveOffer() {

        var id = document.getElementById("offerId").value;

        var payload = {
            title: document.getElementById("offerTitle").value,
            offerCode: document.getElementById("offerCode").value,
            discountPercentage: Number(document.getElementById("discountPercentage").value),
            startDate: document.getElementById("startDate").value || null,
            endDate: document.getElementById("endDate").value || null,
            description: document.getElementById("offerDescription").value,
            active: document.getElementById("offerActive").checked
        };

        try {
            var r = await fetch(
                id ? API_BASE + "/offers/" + id : API_BASE + "/offers",
                {
                    method: id ? "PUT" : "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(payload)
                }
            );

            if (!r.ok) {
                throw new Error();
            }

            closeOfferForm();
            loadOffers();

        } catch(e) {
            alert("Failed to save offer.");
        }
    }

    function editOffer(id) {

        var o = allOffers.find(function(x) {
            return x.id === id;
        });

        if (!o) {
            return;
        }

        document.getElementById("offerFormBox").style.display = "block";
        document.getElementById("formTitle").textContent = "Edit Offer";
        document.getElementById("offerId").value = o.id;
        document.getElementById("offerTitle").value = o.title || "";
        document.getElementById("offerCode").value = o.offerCode || "";
        document.getElementById("discountPercentage").value = o.discountPercentage || 0;
        document.getElementById("startDate").value = o.startDate || "";
        document.getElementById("endDate").value = o.endDate || "";
        document.getElementById("offerDescription").value = o.description || "";
        document.getElementById("offerActive").checked = o.active;
    }

    async function deleteOffer(id, title) {

        if (!confirm('Delete "' + title + '"?')) {
            return;
        }

        try {
            var r = await fetch(API_BASE + "/offers/" + id, {
                method: "DELETE"
            });

            if (!r.ok) {
                throw new Error();
            }

            loadOffers();

        } catch(e) {
            alert("Failed to delete offer.");
        }
    }

    function filterOffers() {

        var q = document.getElementById("offerSearch").value.toLowerCase();

        renderOffers(
            allOffers.filter(function(o) {
                return (o.title || "").toLowerCase().includes(q) ||
                    (o.description || "").toLowerCase().includes(q) ||
                    (o.offerCode || "").toLowerCase().includes(q);
            })
        );
    }

    function fmt(d) {

        if (!d) {
            return "-";
        }

        var dt = new Date(d);

        return isNaN(dt.getTime())
            ? "-"
            : dt.toLocaleDateString("en-GB", {
                day:"2-digit",
                month:"short",
                year:"numeric"
            });
    }

    function fmtEndDate(d) {
        if (!d) {
            return "Still valid";
        }

        return fmt(d);
    }

    function esc(t) {
        return String(t || "").replace(/'/g, "\\'");
    }
</script>

</body>
</html>