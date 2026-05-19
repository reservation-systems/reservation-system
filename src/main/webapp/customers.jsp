<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Golden Reech</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

            <a href="customers.jsp" class="sidebar-nav-item active">
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
                    <i class="fas fa-chevron-right" style="font-size:0.75rem;"></i>
                    <span>Customers</span>
                </div>

            </div>

            <div class="navbar-right">

                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text"
                           id="customer-search"
                           placeholder="Search customers..."
                           onkeyup="filterCustomers()">
                </div>

            </div>

        </nav>

        <div class="admin-content">

            <div class="page-header">

                <h1>Customer Management</h1>

                <div class="page-actions">

                    <button class="btn btn-outline" onclick="window.print()">
                        <i class="fas fa-print"></i>
                        Print
                    </button>

                    <button class="btn btn-primary" onclick="openAddCustomerForm()">
                        <i class="fas fa-plus"></i>
                        Add Customer
                    </button>

                </div>

            </div>

            <div id="customerFormBox"
                 class="data-table-container"
                 style="display:none; margin-bottom:1.5rem;">

                <div class="table-header">
                    <h3 id="formTitle">Add Customer</h3>
                </div>

                <div style="padding:1rem;">

                    <input type="hidden" id="customerId">

                    <div class="form-group">
                        <label class="form-label">Name</label>
                        <input type="text" id="name" class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" id="email" class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" id="password" class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone</label>
                        <input type="text" id="phone" class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Address</label>
                        <input type="text" id="address" class="form-control">
                    </div>

                    <button class="btn btn-primary" onclick="saveCustomer()">
                        Save
                    </button>

                    <button class="btn btn-outline" onclick="closeCustomerForm()">
                        Cancel
                    </button>

                </div>

            </div>

            <div class="data-table-container">

                <div class="table-header">
                    <h3 id="customerCount">All Customers (0)</h3>
                </div>

                <div class="table-responsive">

                    <table class="data-table" id="customers-table">

                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Actions</th>
                        </tr>
                        </thead>

                        <tbody id="customersBody">
                        <tr>
                            <td colspan="5">Loading customers...</td>
                        </tr>
                        </tbody>

                    </table>

                </div>

                <div class="table-footer">
                    <p id="footerText">Showing 0 customers from database</p>
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

    let customers = [];

    document.addEventListener("DOMContentLoaded", loadCustomers);

    async function loadCustomers() {
        try {
            const response = await fetch(`${API_BASE}/customers`);

            if (!response.ok) {
                throw new Error("Failed to fetch customers");
            }

            customers = await response.json();

            renderCustomers(customers);

        } catch (error) {
            document.getElementById("customersBody").innerHTML = `
                <tr>
                    <td colspan="5">
                        Failed to load customers. Make sure Spring Boot is running.
                    </td>
                </tr>
            `;
        }
    }

    function renderCustomers(list) {
        const tbody = document.getElementById("customersBody");

        document.getElementById("customerCount").textContent =
            `All Customers (${list.length})`;

        document.getElementById("footerText").textContent =
            `Showing ${list.length} customers from database`;

        if (list.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="5">No customers found in database.</td>
                </tr>
            `;
            return;
        }

        tbody.innerHTML = list.map(customer => `
            <tr>
                <td>#${customer.id}</td>

                <td>
                    <div class="user-cell">
                        <div class="user-avatar">
                            ${getInitials(customer.name)}
                        </div>

                        <div class="user-info">
                            <p>${customer.name || "-"}</p>
                            <p class="email">${customer.email || "-"}</p>
                        </div>
                    </div>
                </td>

                <td>${customer.phone || "-"}</td>

                <td>${customer.address || "-"}</td>

                <td>
                    <div class="actions">

                        <button class="action-btn view"
                                onclick="viewCustomer(${customer.id})"
                                title="View">
                            <i class="fas fa-eye"></i>
                        </button>

                        <button class="action-btn edit"
                                onclick="editCustomer(${customer.id})"
                                title="Edit">
                            <i class="fas fa-edit"></i>
                        </button>

                        <button class="action-btn delete"
                                onclick="deleteCustomer(${customer.id}, '${escapeText(customer.name)}')"
                                title="Delete">
                            <i class="fas fa-trash"></i>
                        </button>

                    </div>
                </td>
            </tr>
        `).join("");
    }

    function filterCustomers() {
        const keyword =
            document.getElementById("customer-search").value.toLowerCase();

        const filtered = customers.filter(c =>
            (c.name || "").toLowerCase().includes(keyword) ||
            (c.email || "").toLowerCase().includes(keyword) ||
            (c.phone || "").toLowerCase().includes(keyword) ||
            (c.address || "").toLowerCase().includes(keyword)
        );

        renderCustomers(filtered);
    }

    function openAddCustomerForm() {
        document.getElementById("customerFormBox").style.display = "block";
        document.getElementById("formTitle").textContent = "Add Customer";

        document.getElementById("customerId").value = "";
        document.getElementById("name").value = "";
        document.getElementById("email").value = "";
        document.getElementById("password").value = "";
        document.getElementById("phone").value = "";
        document.getElementById("address").value = "";
    }

    function closeCustomerForm() {
        document.getElementById("customerFormBox").style.display = "none";
    }

    async function saveCustomer() {
        const id = document.getElementById("customerId").value;

        const customer = {
            name: document.getElementById("name").value,
            email: document.getElementById("email").value,
            password: document.getElementById("password").value,
            phone: document.getElementById("phone").value,
            address: document.getElementById("address").value
        };

        const url =
            id ? `${API_BASE}/customers/${id}` : `${API_BASE}/customers`;

        const method =
            id ? "PUT" : "POST";

        try {
            const response = await fetch(url, {
                method: method,
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(customer)
            });

            if (!response.ok) {
                throw new Error("Failed to save customer");
            }

            closeCustomerForm();

            loadCustomers();

        } catch (error) {
            alert("Failed to save customer.");
        }
    }

    function viewCustomer(id) {
        const customer = customers.find(c => c.id === id);

        if (!customer) {
            return;
        }

        alert(
            "Customer Details\n\n" +
            "ID: " + customer.id + "\n" +
            "Name: " + (customer.name || "-") + "\n" +
            "Email: " + (customer.email || "-") + "\n" +
            "Phone: " + (customer.phone || "-") + "\n" +
            "Address: " + (customer.address || "-")
        );
    }

    function editCustomer(id) {
        const customer = customers.find(c => c.id === id);

        if (!customer) {
            return;
        }

        document.getElementById("customerFormBox").style.display = "block";
        document.getElementById("formTitle").textContent = "Edit Customer";

        document.getElementById("customerId").value = customer.id;
        document.getElementById("name").value = customer.name || "";
        document.getElementById("email").value = customer.email || "";
        document.getElementById("password").value = customer.password || "";
        document.getElementById("phone").value = customer.phone || "";
        document.getElementById("address").value = customer.address || "";
    }

    async function deleteCustomer(id, name) {
        if (!confirm(`Delete customer "${name}"?`)) {
            return;
        }

        try {
            const response = await fetch(`${API_BASE}/customers/${id}`, {
                method: "DELETE"
            });

            if (!response.ok) {
                throw new Error("Failed to delete customer");
            }

            loadCustomers();

        } catch (error) {
            alert("Failed to delete customer.");
        }
    }

    function getInitials(name) {
        if (!name) {
            return "NA";
        }

        return name
            .split(" ")
            .map(w => w.charAt(0))
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