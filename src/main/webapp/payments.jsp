<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Management - Admin Portal</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        .modal-overlay{
            display:none;
            position:fixed;
            inset:0;
            background:rgba(0,0,0,0.45);
            z-index:1000;
            align-items:center;
            justify-content:center;
        }

        .modal{
            background:white;
            border-radius:16px;
            padding:2rem;
            width:500px;
            max-height:90vh;
            overflow-y:auto;
            box-shadow:0 8px 32px rgba(0,0,0,0.18);
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

            <a href="payments.jsp" class="sidebar-nav-item active">
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
                    <span>Payments</span>
                </div>

            </div>

            <div class="navbar-right">

                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text"
                           id="paymentSearch"
                           placeholder="Search payments..."
                           onkeyup="filterPayments()">
                </div>

            </div>

        </nav>

        <div class="admin-content">

            <div class="page-header">
                <h1>Payment Management</h1>

                <div class="page-actions">
                    <button class="btn btn-outline" onclick="window.print()">
                        <i class="fas fa-print"></i>
                        Print
                    </button>


                </div>
            </div>

            <div class="stats-grid" style="display:grid; grid-template-columns:repeat(4,1fr); gap:1rem; margin-bottom:1.5rem;">

                <div class="stat-card">
                    <div class="stat-icon" style="background:var(--primary-light,#fff3e0); color:var(--primary-color,#e07b00);">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="stat-info">
                        <p class="stat-value" id="statRevenue">Rs. 0.00</p>
                        <p class="stat-label">Total Paid Revenue</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background:#e3f2fd; color:#1565c0;">
                        <i class="fas fa-receipt"></i>
                    </div>
                    <div class="stat-info">
                        <p class="stat-value" id="statTotal">0</p>
                        <p class="stat-label">Total Transactions</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background:#e8f5e9; color:#2e7d32;">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-info">
                        <p class="stat-value" id="statPaid">0</p>
                        <p class="stat-label">Paid Payments</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon" style="background:#fff8e1; color:#f57f17;">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-info">
                        <p class="stat-value" id="statPending">0</p>
                        <p class="stat-label">Pending Payments</p>
                    </div>
                </div>

            </div>

            <div class="data-table-container">

                <div class="table-header">
                    <h3 id="paymentCount">All Payments (0)</h3>

                    <div style="display:flex; gap:0.75rem; align-items:center;">
                        <select id="statusFilter"
                                class="form-control"
                                style="width:auto; padding:0.4rem 0.75rem;"
                                onchange="loadPayments()">
                            <option value="">All Status</option>
                            <option value="PAID">Paid</option>
                            <option value="PENDING">Pending</option>
                            <option value="FAILED">Failed</option>
                        </select>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="data-table" id="paymentsTable">

                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date</th>
                            <th>Customer</th>
                            <th>Email</th>
                            <th>Amount</th>
                            <th>Method</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>

                        <tbody id="paymentsBody">
                        <tr>
                            <td colspan="8">Loading payments...</td>
                        </tr>
                        </tbody>

                    </table>
                </div>

                <div class="table-footer">
                    <p id="footerText">Showing 0 payments from database</p>
                </div>

            </div>

        </div>

    </main>

</div>

<div class="modal-overlay" id="paymentModal">

    <div class="modal">

        <div id="paymentFormSection">

            <h2 style="font-size:1.3rem; font-weight:700; margin-bottom:1.5rem;">
                <i class="fas fa-credit-card" style="color:var(--primary-color,#e07b00); margin-right:8px;"></i>
                Process Payment
            </h2>

            <div class="form-group">
                <label class="form-label">Customer Name *</label>
                <input type="text" id="pay_name" class="form-control" placeholder="Enter customer name">
            </div>

            <div class="form-group">
                <label class="form-label">Customer Email *</label>
                <input type="email" id="pay_email" class="form-control" placeholder="Enter email address">
            </div>

            <div class="form-group">
                <label class="form-label">Amount (Rs.) *</label>
                <input type="number" id="pay_amount" class="form-control" placeholder="0.00" step="0.01">
            </div>

            <div class="form-group">
                <label class="form-label">Payment Method *</label>
                <select id="pay_method" class="form-control" onchange="toggleCardFields()">
                    <option value="">-- Select Method --</option>
                    <option value="CARD">Credit / Debit Card</option>
                    <option value="CASH">Cash</option>
                    <option value="ONLINE">Online Transfer</option>
                </select>
            </div>

            <div id="cardFields" style="display:none;">
                <div class="form-group">
                    <label class="form-label">Card Number</label>
                    <input type="text"
                           id="pay_card"
                           class="form-control"
                           placeholder="1234 5678 9012 3456"
                           maxlength="19"
                           oninput="formatCardNumber(this)">
                </div>

                <div style="display:grid; grid-template-columns:1fr 1fr; gap:1rem;">
                    <div class="form-group">
                        <label class="form-label">Expiry (MM/YY)</label>
                        <input type="text" id="pay_expiry" class="form-control" placeholder="MM/YY" maxlength="5">
                    </div>

                    <div class="form-group">
                        <label class="form-label">CVV</label>
                        <input type="password" id="pay_cvv" class="form-control" placeholder="***" maxlength="3">
                    </div>
                </div>
            </div>

            <div style="display:flex; gap:0.75rem; justify-content:flex-end; margin-top:1.5rem;">
                <button class="btn btn-outline" onclick="closePaymentModal()">Cancel</button>

                <button class="btn btn-primary" onclick="submitPayment()">
                    <i class="fas fa-check"></i>
                    Pay Now
                </button>
            </div>

        </div>

        <div id="paymentSuccessSection" style="display:none; text-align:center; padding:1rem;">
            <i class="fas fa-check-circle" style="font-size:3rem; color:#28a745; display:block; margin-bottom:1rem;"></i>

            <h2 style="color:#2e7d32; margin-bottom:0.5rem;">
                Payment Successful!
            </h2>

            <p id="successDetail" style="color:#555; margin-bottom:1.5rem;"></p>

            <button class="btn btn-primary" onclick="closePaymentModal()">
                Close
            </button>
        </div>

    </div>

</div>

<script src="./js/main.js"></script>
<script src="./js/admin.js"></script>

<script>
    const API_BASE = "http://localhost:8080/api";

    let allPayments = [];

    document.addEventListener("DOMContentLoaded", function() {
        loadPayments();
        loadSummary();
    });

    async function loadPayments() {
        var status = document.getElementById("statusFilter").value;
        var url = API_BASE + "/payments" + (status ? "?status=" + status : "");

        try {
            const response = await fetch(url);

            if (!response.ok) {
                throw new Error("Failed");
            }

            allPayments = await response.json();

            renderPayments(allPayments);

        } catch (error) {
            document.getElementById("paymentsBody").innerHTML =
                '<tr><td colspan="8">No payments found in database.</td></tr>';

            document.getElementById("paymentCount").textContent =
                "All Payments (0)";

            document.getElementById("footerText").textContent =
                "Showing 0 payments from database";
        }
    }

    function renderPayments(data) {
        const tbody = document.getElementById("paymentsBody");

        document.getElementById("paymentCount").textContent =
            "All Payments (" + data.length + ")";

        document.getElementById("footerText").textContent =
            "Showing " + data.length + " payments from database";

        if (!data || data.length === 0) {
            tbody.innerHTML =
                '<tr><td colspan="8">No payments found in database.</td></tr>';
            return;
        }

        tbody.innerHTML = data.map(function(p) {
            var dateStr =
                p.paymentDate ? new Date(p.paymentDate).toLocaleDateString() : "-";

            var methodIcon = "fa-wifi";

            if (p.paymentMethod === "CARD") {
                methodIcon = "fa-credit-card";
            } else if (p.paymentMethod === "CASH") {
                methodIcon = "fa-money-bill";
            }

            var amountHtml = "";

            if (p.discountAmount > 0) {
                amountHtml +=
                    '<span style="text-decoration:line-through;color:#aaa;font-size:0.8rem;">Rs. ' +
                    Number(p.amount || 0).toFixed(2) +
                    '</span><br>';
            }

            amountHtml +=
                '<strong>Rs. ' +
                Number(p.finalAmount || 0).toFixed(2) +
                '</strong>';

            var statusClass = "badge-cancelled";

            if (p.status === "PAID") {
                statusClass = "badge-confirmed";
            } else if (p.status === "PENDING") {
                statusClass = "badge-pending";
            }

            return '<tr>' +
                '<td>#' + p.id + '</td>' +
                '<td>' + dateStr + '</td>' +
                '<td><strong>' + (p.customerName || "-") + '</strong></td>' +
                '<td>' + (p.customerEmail || "-") + '</td>' +
                '<td>' + amountHtml + '</td>' +
                '<td><i class="fas ' + methodIcon + '" style="margin-right:5px;color:#888;"></i>' + (p.paymentMethod || "-") + '</td>' +
                '<td><span class="badge ' + statusClass + '">' + (p.status || "-") + '</span></td>' +
                '<td><div class="actions"><button class="action-btn delete" onclick="deletePayment(' + p.id + ')" title="Delete"><i class="fas fa-trash"></i></button></div></td>' +
                '</tr>';
        }).join("");
    }

    function filterPayments() {
        var q = document.getElementById("paymentSearch").value.toLowerCase();

        var filtered = allPayments.filter(function(p) {
            return (p.customerName || "").toLowerCase().indexOf(q) !== -1 ||
                (p.customerEmail || "").toLowerCase().indexOf(q) !== -1;
        });

        renderPayments(filtered);
    }

    async function loadSummary() {
        try {
            const response = await fetch(API_BASE + "/payments/summary");

            if (!response.ok) {
                throw new Error("Failed");
            }

            const s = await response.json();

            document.getElementById("statRevenue").textContent =
                "Rs. " + Number(s.totalRevenue || 0).toFixed(2);

            document.getElementById("statTotal").textContent =
                s.totalTransactions || 0;

            document.getElementById("statPaid").textContent =
                s.paidPayments || 0;

            document.getElementById("statPending").textContent =
                s.pendingPayments || 0;

        } catch (error) {}
    }

    async function deletePayment(id) {
        if (!confirm("Delete this payment record?")) {
            return;
        }

        try {
            await fetch(API_BASE + "/payments/" + id, {
                method: "DELETE"
            });

            loadPayments();
            loadSummary();

        } catch (error) {
            alert("Failed to delete payment.");
        }
    }

    function openPaymentModal() {
        document.getElementById("paymentModal").style.display = "flex";
        document.getElementById("paymentFormSection").style.display = "block";
        document.getElementById("paymentSuccessSection").style.display = "none";
        document.getElementById("cardFields").style.display = "none";
        clearModalFields();
    }

    function closePaymentModal() {
        document.getElementById("paymentModal").style.display = "none";
        clearModalFields();
    }

    function clearModalFields() {
        ["pay_name", "pay_email", "pay_amount", "pay_card", "pay_expiry", "pay_cvv"].forEach(function(id) {
            var el = document.getElementById(id);

            if (el) {
                el.value = "";
            }
        });

        var method = document.getElementById("pay_method");

        if (method) {
            method.value = "";
        }

        document.getElementById("cardFields").style.display = "none";
    }

    function toggleCardFields() {
        var method = document.getElementById("pay_method").value;

        document.getElementById("cardFields").style.display =
            method === "CARD" ? "block" : "none";
    }

    function formatCardNumber(input) {
        var v = input.value.replace(/\D/g, "").substring(0, 16);
        var formatted = "";

        for (var i = 0; i < v.length; i++) {
            if (i > 0 && i % 4 === 0) {
                formatted += " ";
            }

            formatted += v[i];
        }

        input.value = formatted;
    }

    async function submitPayment() {
        var name = document.getElementById("pay_name").value.trim();
        var email = document.getElementById("pay_email").value.trim();
        var amount = parseFloat(document.getElementById("pay_amount").value);
        var method = document.getElementById("pay_method").value;

        if (!name || !email || !amount || !method) {
            alert("Please fill all required fields.");
            return;
        }

        var cardRaw = document.getElementById("pay_card").value.replace(/\s/g, "");

        if (method === "CARD" && cardRaw.length !== 16) {
            alert("Please enter a valid 16-digit card number.");
            return;
        }

        var payload = {
            customerName: name,
            customerEmail: email,
            amount: amount,
            paymentMethod: method,
            cardNumber: cardRaw
        };

        try {
            const response = await fetch(API_BASE + "/payments/process", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(payload)
            });

            if (!response.ok) {
                throw new Error("Failed");
            }

            const data = await response.json();

            document.getElementById("paymentFormSection").style.display = "none";
            document.getElementById("paymentSuccessSection").style.display = "block";

            document.getElementById("successDetail").textContent =
                "Payment of Rs. " +
                Number(data.finalAmount || 0).toFixed(2) +
                " processed for " +
                (data.customerName || name);

            loadPayments();
            loadSummary();

        } catch (error) {
            alert("Payment failed. Please try again.");
        }
    }
</script>

</body>
</html>