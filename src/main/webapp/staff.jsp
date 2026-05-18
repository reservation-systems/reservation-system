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

    <title>Staff Management - Golden Reech</title>

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

            <a href="staff.jsp" class="sidebar-nav-item active">
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
                    <i class="fas fa-chevron-right"
                       style="font-size:0.75rem;"></i>
                    <span>Staff</span>
                </div>

            </div>

            <div class="navbar-right">

                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text"
                           id="staff-search"
                           placeholder="Search staff..."
                           onkeyup="filterStaff()">
                </div>

            </div>

        </nav>

        <div class="admin-content">

            <div class="page-header">

                <h1>Staff Management</h1>

                <div class="page-actions">

                    <button class="btn btn-outline"
                            onclick="window.print()">
                        <i class="fas fa-print"></i>
                        Print
                    </button>

                    <button class="btn btn-primary"
                            onclick="openAddModal()">
                        <i class="fas fa-plus"></i>
                        Add Staff
                    </button>

                </div>

            </div>

            <div class="stats-grid">

                <div class="stat-card primary">
                    <h3 id="totalStaff">0</h3>
                    <p>Total Staff</p>
                </div>

                <div class="stat-card success">
                    <h3 id="chefCount">0</h3>
                    <p>Chefs</p>
                </div>

                <div class="stat-card warning">
                    <h3 id="waiterCount">0</h3>
                    <p>Waiters</p>
                </div>

                <div class="stat-card">
                    <h3 id="managerCount">0</h3>
                    <p>Managers</p>
                </div>

            </div>

            <div id="staffFormBox"
                 class="data-table-container"
                 style="display:none; margin-bottom:1.5rem;">

                <div class="table-header">
                    <h3 id="formTitle">Add Staff</h3>
                </div>

                <div style="padding:1rem;">

                    <input type="hidden" id="staffId">

                    <div class="form-group">
                        <label class="form-label">Name</label>
                        <input type="text" id="name" class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Role</label>
                        <select id="role" class="form-control">
                            <option value="Chef">Chef</option>
                            <option value="Waiter">Waiter</option>
                            <option value="Manager">Manager</option>
                            <option value="Cashier">Cashier</option>
                            <option value="Cleaner">Cleaner</option>
                            <option value="Security">Security</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone</label>
                        <input type="text" id="phone" class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" id="email" class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Salary (Rs.)</label>
                        <input type="number" id="salary" class="form-control" min="0" step="0.01">
                    </div>

                    <button class="btn btn-primary"
                            onclick="saveStaff()">
                        Save
                    </button>

                    <button class="btn btn-outline"
                            onclick="closeStaffForm()">
                        Cancel
                    </button>

                </div>

            </div>

            <div class="data-table-container">

                <div class="table-header">
                    <h3 id="staffCount">All Staff (0)</h3>
                </div>

                <div class="table-responsive">

                    <table class="data-table" id="staff-table">

                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Staff Member</th>
                            <th>Role</th>
                            <th>Phone</th>
                            <th>Salary</th>
                            <th>Actions</th>
                        </tr>
                        </thead>

                        <tbody id="staffBody">
                        <tr>
                            <td colspan="6">Loading staff...</td>
                        </tr>
                        </tbody>

                    </table>

                </div>

                <div class="table-footer">
                    <p id="footerText">Showing 0 staff from database</p>
                </div>

            </div>

        </div>

    </main>

</div>

<script src="./js/main.js"></script>
<script src="./js/validation.js"></script>
<script src="./js/admin.js"></script>

<script>

    const API_BASE = "http://localhost:8080/api";

    let staffList = [];

    document.addEventListener("DOMContentLoaded", loadStaff);

    async function loadStaff() {

        try {

            const response = await fetch(`${API_BASE}/staff`);

            if (!response.ok) {
                throw new Error("Failed to fetch staff");
            }

            staffList = await response.json();

            renderStaff(staffList);
            updateStats(staffList);

        } catch (error) {

            document.getElementById("staffBody").innerHTML = `
                <tr>
                    <td colspan="6">
                        Failed to load staff.
                        Make sure Spring Boot is running.
                    </td>
                </tr>
            `;
        }
    }

    function renderStaff(list) {

        const tbody = document.getElementById("staffBody");

        document.getElementById("staffCount").textContent =
            `All Staff (${list.length})`;

        document.getElementById("footerText").textContent =
            `Showing ${list.length} staff from database`;

        if (list.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="6">No staff found in database.</td>
                </tr>
            `;
            return;
        }

        tbody.innerHTML = list.map(s => `
            <tr>

                <td>#${s.id}</td>

                <td>
                    <div class="user-cell">
                        <div class="user-avatar">
                            ${getInitials(s.name)}
                        </div>
                        <div class="user-info">
                            <p>${s.name || "-"}</p>
                            <p class="email">${s.email || "-"}</p>
                        </div>
                    </div>
                </td>

                <td>
                    <span class="badge ${getRoleBadge(s.role)}">
                        ${s.role || "-"}
                    </span>
                </td>

                <td>${s.phone || "-"}</td>

                <td>Rs. ${Number(s.salary || 0).toFixed(2)}</td>

                <td>
                    <div class="actions">

                        <button class="action-btn view"
                                onclick="viewStaff(${s.id})"
                                title="View">
                            <i class="fas fa-eye"></i>
                        </button>

                        <button class="action-btn edit"
                                onclick="editStaff(${s.id})"
                                title="Edit">
                            <i class="fas fa-edit"></i>
                        </button>

                        <button class="action-btn delete"
                                onclick="deleteStaff(${s.id}, '${escapeText(s.name)}')"
                                title="Delete">
                            <i class="fas fa-trash"></i>
                        </button>

                    </div>
                </td>

            </tr>
        `).join("");
    }

    function updateStats(list) {

        document.getElementById("totalStaff").textContent =
            list.length;

        document.getElementById("chefCount").textContent =
            list.filter(s => (s.role || "").toLowerCase() === "chef").length;

        document.getElementById("waiterCount").textContent =
            list.filter(s => (s.role || "").toLowerCase() === "waiter").length;

        document.getElementById("managerCount").textContent =
            list.filter(s => (s.role || "").toLowerCase() === "manager").length;
    }

    function getRoleBadge(role) {
        if (!role) return "badge-pending";

        const r = role.toLowerCase();

        if (r === "manager") return "badge-confirmed";
        if (r === "chef") return "badge-pending";

        return "badge-info";
    }

    function filterStaff() {

        const keyword =
            document.getElementById("staff-search")
                .value
                .toLowerCase();

        const filtered = staffList.filter(s =>
            (s.name || "").toLowerCase().includes(keyword) ||
            (s.role || "").toLowerCase().includes(keyword) ||
            (s.email || "").toLowerCase().includes(keyword) ||
            (s.phone || "").toLowerCase().includes(keyword)
        );

        renderStaff(filtered);
    }

    function openAddModal() {

        document.getElementById("staffFormBox").style.display = "block";
        document.getElementById("formTitle").textContent = "Add Staff";
        document.getElementById("staffId").value = "";
        document.getElementById("name").value = "";
        document.getElementById("role").value = "Chef";
        document.getElementById("phone").value = "";
        document.getElementById("email").value = "";
        document.getElementById("salary").value = "";
    }

    function closeStaffForm() {
        document.getElementById("staffFormBox").style.display = "none";
    }

    async function saveStaff() {

        const id = document.getElementById("staffId").value;

        const staff = {
            name: document.getElementById("name").value,
            role: document.getElementById("role").value,
            phone: document.getElementById("phone").value,
            email: document.getElementById("email").value,
            salary: Number(document.getElementById("salary").value || 0)
        };

        const url = id ? `${API_BASE}/staff/${id}` : `${API_BASE}/staff`;
        const method = id ? "PUT" : "POST";

        try {

            const response = await fetch(url, {
                method: method,
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(staff)
            });

            if (!response.ok) throw new Error("Failed to save staff");

            closeStaffForm();
            loadStaff();

        } catch (error) {
            alert("Failed to save staff.");
        }
    }

    function viewStaff(id) {

        const s = staffList.find(s => s.id === id);
        if (!s) return;

        alert(
            `Staff Details\n\n` +
            `ID:     ${s.id}\n` +
            `Name:   ${s.name || "-"}\n` +
            `Role:   ${s.role || "-"}\n` +
            `Phone:  ${s.phone || "-"}\n` +
            `Email:  ${s.email || "-"}\n` +
            `Salary: Rs. ${Number(s.salary || 0).toFixed(2)}`
        );
    }

    function editStaff(id) {

        const s = staffList.find(s => s.id === id);
        if (!s) return;

        document.getElementById("staffFormBox").style.display = "block";
        document.getElementById("formTitle").textContent = "Edit Staff";
        document.getElementById("staffId").value = s.id;
        document.getElementById("name").value = s.name || "";
        document.getElementById("role").value = s.role || "Chef";
        document.getElementById("phone").value = s.phone || "";
        document.getElementById("email").value = s.email || "";
        document.getElementById("salary").value = s.salary || "";
    }

    async function deleteStaff(id, name) {

        if (!confirm(`Delete staff member "${name}"?`)) return;

        try {

            const response = await fetch(`${API_BASE}/staff/${id}`, {
                method: "DELETE"
            });

            if (!response.ok) throw new Error("Failed to delete staff");

            loadStaff();

        } catch (error) {
            alert("Failed to delete staff.");
        }
    }

    function getInitials(name) {
        if (!name) return "NA";

        return name
            .split(" ")
            .map(word => word.charAt(0))
            .join("")
            .substring(0, 2)
            .toUpperCase();
    }

    function escapeText(text) {
        return String(text || "").replace(/'/g, "\\'");
    }

</script>

</body>
</html>