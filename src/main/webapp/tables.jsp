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

    <title>Table Management - Golden Reech</title>

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

            <a href="tables.jsp" class="sidebar-nav-item active">
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

                <button class="sidebar-toggle"
                        onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>

                <div class="breadcrumb">
                    <a href="admin-dashboard.jsp">Dashboard</a>
                    <i class="fas fa-chevron-right" style="font-size:0.75rem;"></i>
                    <span>Tables</span>
                </div>

            </div>

            <div class="navbar-right">
                <div class="navbar-actions">
                    <button class="navbar-btn">
                        <i class="fas fa-bell"></i>
                        <span class="notification-badge">3</span>
                    </button>
                </div>
            </div>

        </nav>

        <div class="admin-content">

            <div class="page-header">

                <h1>Table Management</h1>

                <div class="page-actions">

                    <button class="btn btn-primary"
                            onclick="openAddModal()">
                        <i class="fas fa-plus"></i>
                        Add Table
                    </button>

                </div>

            </div>

            <div class="card" style="margin-bottom: 1.5rem;">
                <div class="card-body"
                     style="display: flex; gap: 2rem; flex-wrap: wrap;">

                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                        <div style="width: 20px; height: 20px; border-radius: 4px; border: 2px solid var(--success-color);"></div>
                        <span>Available</span>
                    </div>

                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                        <div style="width: 20px; height: 20px; border-radius: 4px; border: 2px solid var(--accent-color); background: rgba(231, 76, 60, 0.05);"></div>
                        <span>Occupied</span>
                    </div>

                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                        <div style="width: 20px; height: 20px; border-radius: 4px; border: 2px solid var(--warning-color); background: rgba(243, 156, 18, 0.05);"></div>
                        <span>Reserved</span>
                    </div>

                </div>
            </div>

            <div class="stats-grid"
                 style="grid-template-columns: repeat(4, 1fr); margin-bottom: 1.5rem;">

                <div class="stat-card">
                    <div class="info">
                        <h3 id="totalTables">0</h3>
                        <p>Total Tables</p>
                    </div>
                </div>

                <div class="stat-card success">
                    <div class="info">
                        <h3 id="availableTables">0</h3>
                        <p>Available</p>
                    </div>
                </div>

                <div class="stat-card"
                     style="background: rgba(231, 76, 60, 0.1);">
                    <div class="info">
                        <h3 id="occupiedTables">0</h3>
                        <p>Occupied</p>
                    </div>
                </div>

                <div class="stat-card warning">
                    <div class="info">
                        <h3 id="reservedTables">0</h3>
                        <p>Reserved</p>
                    </div>
                </div>

            </div>

            <div class="card">

                <div class="card-header">
                    <h3>Restaurant Floor Plan</h3>
                    <p style="margin-bottom: 0; font-size: 0.875rem; opacity: 0.8;">
                        Click on a table to change its status
                    </p>
                </div>

                <div class="card-body">
                    <div class="tables-grid" id="floorPlanGrid">
                        <p>Loading floor plan...</p>
                    </div>
                </div>

            </div>

            <div class="data-table-container" style="margin-top: 1.5rem;">

                <div class="table-header">
                    <h3>Table Details</h3>
                </div>

                <div class="table-responsive">

                    <table class="data-table">

                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Table Number</th>
                            <th>Capacity</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>

                        <tbody id="tablesTableBody">
                        <tr>
                            <td colspan="6">Loading tables...</td>
                        </tr>
                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </main>

</div>

<div id="tableModal"
     style="display:none;
            position:fixed;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background:rgba(0,0,0,0.5);
            z-index:9999;">

    <div style="background:white;
                width:90%;
                max-width:500px;
                margin:50px auto;
                padding:2rem;
                border-radius:10px;">

        <h2 id="modalTitle">Add Table</h2>

        <form id="tableForm">

            <input type="hidden" id="tableId">

            <div class="form-group">
                <label class="form-label">Table Number</label>
                <input type="number" id="tableNumber" class="form-control" required>
            </div>

            <div class="form-group">
                <label class="form-label">Capacity</label>
                <input type="number" id="capacity" class="form-control" required>
            </div>

            <div class="form-group">
                <label class="form-label">Location</label>
                <input type="text" id="location" class="form-control">
            </div>

            <div class="form-group">
                <label class="form-label">Status</label>
                <select id="status" class="form-control">
                    <option value="AVAILABLE">AVAILABLE</option>
                    <option value="OCCUPIED">OCCUPIED</option>
                    <option value="RESERVED">RESERVED</option>
                </select>
            </div>

            <div style="display:flex; gap:1rem; margin-top:1rem;">
                <button type="submit" class="btn btn-primary">Save</button>
                <button type="button" class="btn btn-outline" onclick="closeModal()">Cancel</button>
            </div>

        </form>

    </div>

</div>

<script src="./js/main.js"></script>
<script src="./js/validation.js"></script>
<script src="./js/admin.js"></script>

<script>

    const API_BASE = "http://localhost:8080/api";

    let allTables = [];

    document.addEventListener("DOMContentLoaded", () => {
        loadTables();
        document.getElementById("tableForm").addEventListener("submit", saveTable);
    });

    async function loadTables() {

        try {

            const response = await fetch(`${API_BASE}/tables`);

            if (!response.ok) {
                throw new Error("Failed");
            }

            allTables = await response.json();

            renderFloorPlan(allTables);
            renderTableDetails(allTables);
            updateStats(allTables);

        } catch (error) {

            document.getElementById("tablesTableBody").innerHTML = `
                <tr>
                    <td colspan="6">Failed to load tables. Make sure Spring Boot is running.</td>
                </tr>
            `;
        }
    }

    function renderFloorPlan(tables) {

        const grid = document.getElementById("floorPlanGrid");

        if (tables.length === 0) {
            grid.innerHTML = "<p>No tables found.</p>";
            return;
        }

        grid.innerHTML = tables.map(t => {

            const statusClass = getFloorStatusClass(t.status);

            return `
                <div class="table-card ${statusClass}"
                     onclick="toggleTableStatus(this, ${t.id})"
                     data-id="${t.id}"
                     data-status="${t.status}">
                    <i class="fas fa-utensils"></i>
                    <span class="table-number">T${t.tableNumber}</span>
                    <span class="table-capacity">${t.capacity} seats</span>
                </div>
            `;
        }).join("");
    }

    function getFloorStatusClass(status) {
        if (status === "AVAILABLE") return "available";
        if (status === "OCCUPIED") return "occupied";
        if (status === "RESERVED") return "reserved";
        return "available";
    }

    function renderTableDetails(tables) {

        const tbody = document.getElementById("tablesTableBody");

        if (tables.length === 0) {
            tbody.innerHTML = `<tr><td colspan="6">No tables found.</td></tr>`;
            return;
        }

        tbody.innerHTML = tables.map(t => `
            <tr>
                <td>#${t.id}</td>
                <td>${t.tableNumber}</td>
                <td>${t.capacity}</td>
                <td>${t.location || "-"}</td>
                <td>
                    <span class="badge ${getBadgeClass(t.status)}">
                        ${t.status}
                    </span>
                </td>
                <td>
                    <div class="actions">
                        <button class="action-btn edit"
                                onclick="editTable(${t.id})"
                                title="Edit">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="action-btn delete"
                                onclick="deleteTable(${t.id})"
                                title="Delete">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>
        `).join("");
    }

    function getBadgeClass(status) {
        if (status === "AVAILABLE") return "badge-confirmed";
        if (status === "OCCUPIED") return "badge-cancelled";
        if (status === "RESERVED") return "badge-pending";
        return "badge-pending";
    }

    function updateStats(tables) {
        document.getElementById("totalTables").textContent = tables.length;

        document.getElementById("availableTables").textContent =
            tables.filter(t => t.status === "AVAILABLE").length;

        document.getElementById("occupiedTables").textContent =
            tables.filter(t => t.status === "OCCUPIED").length;

        document.getElementById("reservedTables").textContent =
            tables.filter(t => t.status === "RESERVED").length;
    }

    async function toggleTableStatus(card, id) {

        const current = card.getAttribute("data-status");

        let next;

        if (current === "AVAILABLE") {
            next = "OCCUPIED";
        } else if (current === "OCCUPIED") {
            next = "RESERVED";
        } else {
            next = "AVAILABLE";
        }

        const table = allTables.find(t => t.id === id);

        if (!table) {
            return;
        }

        table.status = next;

        try {
            await fetch(`${API_BASE}/tables/${id}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(table)
            });

            loadTables();

        } catch (error) {
            alert("Failed to update table status.");
        }
    }

    function openAddModal() {
        document.getElementById("modalTitle").textContent = "Add Table";
        document.getElementById("tableForm").reset();
        document.getElementById("tableId").value = "";
        document.getElementById("tableModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("tableModal").style.display = "none";
    }

    async function saveTable(event) {

        event.preventDefault();

        const id = document.getElementById("tableId").value;

        const table = {
            tableNumber: Number(document.getElementById("tableNumber").value),
            capacity: Number(document.getElementById("capacity").value),
            location: document.getElementById("location").value,
            status: document.getElementById("status").value
        };

        const url = id ? `${API_BASE}/tables/${id}` : `${API_BASE}/tables`;
        const method = id ? "PUT" : "POST";

        try {
            const response = await fetch(url, {
                method: method,
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(table)
            });

            if (!response.ok) {
                throw new Error("Failed");
            }

            closeModal();
            loadTables();

        } catch (error) {
            alert("Failed to save table.");
        }
    }

    function editTable(id) {

        const table = allTables.find(t => t.id === id);

        if (!table) {
            return;
        }

        document.getElementById("modalTitle").textContent = "Edit Table";
        document.getElementById("tableId").value = table.id;
        document.getElementById("tableNumber").value = table.tableNumber;
        document.getElementById("capacity").value = table.capacity;
        document.getElementById("location").value = table.location || "";
        document.getElementById("status").value = table.status;
        document.getElementById("tableModal").style.display = "block";
    }

    async function deleteTable(id) {

        if (!confirm("Delete table #" + id + "?")) {
            return;
        }

        try {
            const response = await fetch(`${API_BASE}/tables/${id}`, {
                method: "DELETE"
            });

            if (!response.ok) {
                throw new Error("Failed");
            }

            loadTables();

        } catch (error) {
            alert("Failed to delete table.");
        }
    }

</script>

</body>
</html>