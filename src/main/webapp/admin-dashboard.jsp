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

    <title>Admin Dashboard - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/admin.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>

        body{
            background:#f5f7fb;
            margin:0;
            font-family:Arial,sans-serif;
        }

        .admin-dashboard{
            padding:2rem;
        }

        .dashboard-hero{
            background:linear-gradient(135deg,#2b1205,#8a5200,#f4a100);
            border-radius:24px;
            padding:2.2rem;
            color:#fff;
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:2rem;
            box-shadow:0 10px 35px rgba(0,0,0,0.15);
        }

        .dashboard-hero h1{
            margin:0;
            font-size:2.2rem;
        }

        .dashboard-hero p{
            margin-top:10px;
            opacity:0.9;
        }

        .hero-icon{
            width:90px;
            height:90px;
            border-radius:20px;
            background:rgba(255,255,255,0.15);
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:2.7rem;
        }

        .admin-stats{
            display:grid;
            grid-template-columns:repeat(3,1fr);
            gap:1.5rem;
            margin-bottom:2rem;
        }

        .stat-card{
            background:#fff;
            border-radius:20px;
            padding:1.5rem;
            display:flex;
            align-items:center;
            gap:1rem;
            box-shadow:0 4px 20px rgba(0,0,0,0.08);
        }

        .stat-icon{
            width:60px;
            height:60px;
            border-radius:16px;
            background:#fff3e0;
            color:#ff9800;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:1.5rem;
        }

        .stat-card h3{
            margin:0;
            font-size:1.8rem;
            color:#111;
        }

        .stat-card p{
            margin-top:5px;
            color:#777;
        }

        .dashboard-layout{
            display:grid;
            grid-template-columns:1.4fr 1fr;
            gap:1.5rem;
            margin-bottom:1.5rem;
        }

        .dashboard-card{
            background:#fff;
            border-radius:22px;
            overflow:hidden;
            box-shadow:0 4px 20px rgba(0,0,0,0.08);
        }

        .admin-management-card{
            background:#fff;
            border-radius:22px;
            overflow:hidden;
            box-shadow:0 4px 20px rgba(0,0,0,0.08);
            margin-top:1.5rem;
        }

        .card-header{
            padding:1.5rem;
            border-bottom:1px solid #eee;
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:1rem;
        }

        .card-header-left{
            display:flex;
            align-items:center;
            gap:1rem;
        }

        .card-header .icon{
            width:50px;
            height:50px;
            border-radius:14px;
            background:linear-gradient(135deg,#ff9800,#ff6f00);
            color:#fff;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .card-header h2{
            margin:0;
            font-size:1.2rem;
        }

        .card-header p{
            margin-top:4px;
            color:#777;
            font-size:0.9rem;
        }

        .card-body{
            padding:1.5rem;
        }

        .form-group{
            margin-bottom:1rem;
        }

        .form-label{
            display:block;
            margin-bottom:8px;
            font-weight:700;
            color:#333;
        }

        .form-control{
            width:100%;
            padding:12px 14px;
            border:1.5px solid #ddd;
            border-radius:12px;
            outline:none;
            transition:0.2s;
            box-sizing:border-box;
        }

        .form-control:focus{
            border-color:#ff9800;
            box-shadow:0 0 0 4px rgba(255,152,0,0.12);
        }

        .save-btn{
            width:100%;
            padding:14px;
            border:none;
            border-radius:12px;
            background:linear-gradient(135deg,#ff9800,#ff6f00);
            color:#fff;
            font-weight:700;
            cursor:pointer;
            transition:0.2s;
        }

        .save-btn:hover{
            transform:translateY(-2px);
        }

        .small-btn{
            padding:10px 16px;
            border:none;
            border-radius:10px;
            background:linear-gradient(135deg,#ff9800,#ff6f00);
            color:#fff;
            font-weight:700;
            cursor:pointer;
        }

        .delete-btn{
            padding:8px 12px;
            border:none;
            border-radius:8px;
            background:#e53935;
            color:#fff;
            cursor:pointer;
            font-weight:700;
        }

        .edit-btn{
            padding:8px 12px;
            border:none;
            border-radius:8px;
            background:#ff9800;
            color:#fff;
            cursor:pointer;
            font-weight:700;
            margin-right:6px;
        }

        .quick-links{
            display:grid;
            gap:1rem;
        }

        .quick-link{
            background:#fff7e8;
            padding:1rem;
            border-radius:14px;
            text-decoration:none;
            color:#111;
            display:flex;
            align-items:center;
            gap:1rem;
            font-weight:700;
            transition:0.2s;
        }

        .quick-link:hover{
            background:#ff9800;
            color:#fff;
            transform:translateY(-2px);
        }

        .quick-link i{
            width:35px;
            height:35px;
            background:#fff;
            color:#ff9800;
            border-radius:10px;
            display:flex;
            align-items:center;
            justify-content:center;
        }

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
        }

        .admin-table-wrapper{
            width:100%;
            overflow-x:auto;
        }

        .admin-table{
            width:100%;
            border-collapse:collapse;
        }

        .admin-table th{
            background:#fff3e0;
            color:#ff6f00;
            text-align:left;
            padding:14px;
            font-size:0.85rem;
            text-transform:uppercase;
        }

        .admin-table td{
            padding:14px;
            border-bottom:1px solid #eee;
            color:#333;
        }

        .role-badge{
            display:inline-block;
            padding:6px 10px;
            border-radius:999px;
            background:#fff3e0;
            color:#ff6f00;
            font-size:0.75rem;
            font-weight:700;
        }

        .modal-overlay{
            display:none;
            position:fixed;
            inset:0;
            background:rgba(0,0,0,0.45);
            z-index:9999;
            align-items:center;
            justify-content:center;
        }

        .modal-box{
            background:#fff;
            width:460px;
            max-width:92%;
            border-radius:20px;
            padding:2rem;
            box-shadow:0 12px 45px rgba(0,0,0,0.25);
        }

        .modal-header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:1.5rem;
        }

        .modal-header h2{
            margin:0;
            font-size:1.4rem;
        }

        .modal-close{
            width:36px;
            height:36px;
            border:none;
            border-radius:50%;
            background:#f1f1f1;
            cursor:pointer;
        }

        .modal-actions{
            display:flex;
            gap:10px;
            justify-content:flex-end;
            margin-top:1rem;
        }

        .modal-actions .small-btn{
            width:auto;
        }

        .message-box{
            margin-top:1rem;
            font-weight:700;
        }

        @media(max-width:1000px){

            .admin-stats{
                grid-template-columns:1fr;
            }

            .dashboard-layout{
                grid-template-columns:1fr;
            }

            .dashboard-hero{
                flex-direction:column;
                align-items:flex-start;
                gap:1rem;
            }
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
                <p class="name" id="sidebarAdminName">Admin User</p>
                <p class="role">Restaurant Manager</p>
            </div>
        </div>

        <nav class="sidebar-nav">

            <p class="sidebar-nav-title">MAIN</p>

            <a href="admin-dashboard.jsp"
               class="sidebar-nav-item active">

                <i class="fas fa-gauge-high"></i>
                <span>Dashboard</span>
            </a>

            <a href="reservations-admin.jsp"
               class="sidebar-nav-item">

                <i class="fas fa-calendar-check"></i>
                <span>Reservations</span>

                <span class="badge"
                      id="reservationBadge">0</span>
            </a>

            <a href="customers.jsp"
               class="sidebar-nav-item">

                <i class="fas fa-users"></i>
                <span>Customers</span>
            </a>

            <a href="tables.jsp"
               class="sidebar-nav-item">

                <i class="fas fa-chair"></i>
                <span>Tables</span>
            </a>

            <p class="sidebar-nav-title">MANAGEMENT</p>

            <a href="menu-management.jsp"
               class="sidebar-nav-item">

                <i class="fas fa-utensils"></i>
                <span>Menu</span>
            </a>

            <a href="staff.jsp"
               class="sidebar-nav-item">

                <i class="fas fa-user-tie"></i>
                <span>Staff</span>
            </a>

            <a href="offers-management.jsp"
               class="sidebar-nav-item">

                <i class="fas fa-tags"></i>
                <span>Offers</span>
            </a>

            <p class="sidebar-nav-title">FINANCE</p>

            <a href="payments.jsp"
               class="sidebar-nav-item">

                <i class="fas fa-credit-card"></i>
                <span>Payments</span>
            </a>

            <p class="sidebar-nav-title">OTHER</p>

            <a href="reviews-management.jsp"
               class="sidebar-nav-item">

                <i class="fas fa-star"></i>
                <span>Reviews</span>

                <span class="badge"
                      id="reviewBadge">0</span>
            </a>

            <a href="#"
               onclick="logout()"
               class="sidebar-nav-item">

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
                    <span>Dashboard</span>
                </div>

            </div>

            <div class="navbar-right">

                <div class="search-box">
                    <i class="fas fa-search"></i>

                    <input type="text"
                           placeholder="Search...">
                </div>

            </div>

        </nav>

        <div class="admin-content admin-dashboard">

            <div class="dashboard-hero">

                <div>

                    <h1>Dashboard Overview</h1>

                    <p>
                        Manage Golden Reech restaurant operations
                        from one modern dashboard.
                    </p>

                </div>

                <div class="hero-icon">
                    <i class="fas fa-chart-line"></i>
                </div>

            </div>

            <div class="admin-stats">

                <div class="stat-card">

                    <div class="stat-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>

                    <div>
                        <h3 id="statReservations">0</h3>
                        <p>Reservations</p>
                    </div>

                </div>

                <div class="stat-card">

                    <div class="stat-icon">
                        <i class="fas fa-star"></i>
                    </div>

                    <div>
                        <h3 id="statReviews">0</h3>
                        <p>Reviews</p>
                    </div>

                </div>

                <div class="stat-card">

                    <div class="stat-icon">
                        <i class="fas fa-user-shield"></i>
                    </div>

                    <div>
                        <h3 id="statAdmins">0</h3>
                        <p>Total Admins</p>
                    </div>

                </div>

            </div>

            <div class="dashboard-layout">

                <div class="dashboard-card">

                    <div class="card-header">

                        <div class="card-header-left">
                            <div class="icon">
                                <i class="fas fa-user-cog"></i>
                            </div>

                            <div>
                                <h2>My Admin Profile</h2>
                                <p>Update only your logged-in admin account</p>
                            </div>
                        </div>

                    </div>

                    <div class="card-body">

                        <form onsubmit="updateAdminProfile(event)">

                            <div class="form-group">

                                <label class="form-label">
                                    Admin Name
                                </label>

                                <input type="text"
                                       id="adminName"
                                       class="form-control"
                                       required>

                            </div>

                            <div class="form-group">

                                <label class="form-label">
                                    Admin Email
                                </label>

                                <input type="email"
                                       id="adminEmail"
                                       class="form-control"
                                       required>

                            </div>

                            <div class="form-group">

                                <label class="form-label">
                                    New Password
                                </label>

                                <input type="password"
                                       id="adminPassword"
                                       class="form-control"
                                       placeholder="Leave empty to keep old password">

                            </div>

                            <button type="submit"
                                    class="save-btn">

                                <i class="fas fa-save"></i>
                                Save My Profile
                            </button>

                            <p id="profileMessage"
                               class="message-box"></p>

                        </form>

                    </div>

                </div>

                <div class="dashboard-card">

                    <div class="card-header">

                        <div class="card-header-left">
                            <div class="icon">
                                <i class="fas fa-bolt"></i>
                            </div>

                            <div>
                                <h2>Quick Actions</h2>
                                <p>Open management pages fast</p>
                            </div>
                        </div>

                    </div>

                    <div class="card-body">

                        <div class="quick-links">

                            <a href="reservations-admin.jsp"
                               class="quick-link">

                                <i class="fas fa-calendar-check"></i>
                                Reservations
                            </a>

                            <a href="tables.jsp"
                               class="quick-link">

                                <i class="fas fa-chair"></i>
                                Tables
                            </a>

                            <a href="menu-management.jsp"
                               class="quick-link">

                                <i class="fas fa-utensils"></i>
                                Menu
                            </a>

                            <a href="staff.jsp"
                               class="quick-link">

                                <i class="fas fa-user-tie"></i>
                                Staff
                            </a>

                            <a href="offers-management.jsp"
                               class="quick-link">

                                <i class="fas fa-tags"></i>
                                Offers
                            </a>

                            <a href="payments.jsp"
                               class="quick-link">

                                <i class="fas fa-credit-card"></i>
                                Payments
                            </a>

                        </div>

                    </div>

                </div>

            </div>

            <div class="admin-management-card">

                <div class="card-header">

                    <div class="card-header-left">

                        <div class="icon">
                            <i class="fas fa-user-shield"></i>
                        </div>

                        <div>
                            <h2>Admin Account Management</h2>
                            <p>Add, update, delete and manage all admin login accounts</p>
                        </div>

                    </div>

                    <button class="small-btn"
                            onclick="openAdminModal()">

                        <i class="fas fa-plus"></i>
                        Add Admin
                    </button>

                </div>

                <div class="card-body">

                    <div class="admin-table-wrapper">

                        <table class="admin-table">

                            <thead>

                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>

                            </thead>

                            <tbody id="adminTableBody">

                            <tr>
                                <td colspan="5">Loading admins...</td>
                            </tr>

                            </tbody>

                        </table>

                    </div>

                    <p id="adminManageMessage"
                       class="message-box"></p>

                </div>

            </div>

        </div>

    </main>

</div>

<div class="modal-overlay"
     id="adminModal">

    <div class="modal-box">

        <div class="modal-header">

            <h2 id="adminModalTitle">
                Add Admin
            </h2>

            <button class="modal-close"
                    onclick="closeAdminModal()">

                <i class="fas fa-times"></i>
            </button>

        </div>

        <input type="hidden"
               id="editAdminId">

        <div class="form-group">

            <label class="form-label">
                Admin Name
            </label>

            <input type="text"
                   id="newAdminName"
                   class="form-control"
                   placeholder="Enter admin name">

        </div>

        <div class="form-group">

            <label class="form-label">
                Admin Email
            </label>

            <input type="email"
                   id="newAdminEmail"
                   class="form-control"
                   placeholder="Enter admin email">

        </div>

        <div class="form-group">

            <label class="form-label">
                Password
            </label>

            <input type="password"
                   id="newAdminPassword"
                   class="form-control"
                   placeholder="Enter password / leave empty when editing">

        </div>

        <div class="form-group">

            <label class="form-label">
                Role
            </label>

            <select id="newAdminRole"
                    class="form-control">

                <option value="ADMIN">
                    ADMIN
                </option>

                <option value="SUPER_ADMIN">
                    SUPER_ADMIN
                </option>

            </select>

        </div>

        <div class="modal-actions">

            <button class="small-btn"
                    style="background:#777;"
                    onclick="closeAdminModal()">

                Cancel
            </button>

            <button class="small-btn"
                    onclick="saveAdminAccount()">

                <i class="fas fa-save"></i>
                Save
            </button>

        </div>

    </div>

</div>

<script src="./js/main.js"></script>
<script src="./js/admin.js"></script>

<script>

    const API_BASE =
        "http://localhost:8080/api";

    let admin =
        JSON.parse(localStorage.getItem("admin"));

    let allAdmins =
        [];

    if (!admin) {

        window.location.href =
            "login.jsp";

    } else {

        document.getElementById("adminName").value =
            admin.name || "";

        document.getElementById("adminEmail").value =
            admin.email || "";

        document.getElementById("sidebarAdminName").textContent =
            admin.name || "Admin User";
    }

    document.addEventListener(
        "DOMContentLoaded",
        function(){

            loadAllAdmins();
        }
    );

    async function updateAdminProfile(event){

        event.preventDefault();

        const message =
            document.getElementById("profileMessage");

        const updatedAdmin = {

            name:
                document.getElementById("adminName").value.trim(),

            email:
                document.getElementById("adminEmail").value.trim(),

            password:
                document.getElementById("adminPassword").value.trim(),

            role:
                admin.role || "ADMIN"
        };

        try{

            const response = await fetch(
                API_BASE + "/admin/update/" + admin.id,
                {
                    method:"PUT",

                    headers:{
                        "Content-Type":"application/json"
                    },

                    body:JSON.stringify(updatedAdmin)
                }
            );

            const data =
                await response.json();

            if(data.status === "success"){

                localStorage.setItem(
                    "admin",
                    JSON.stringify(data.admin)
                );

                admin = data.admin;

                document.getElementById("sidebarAdminName").textContent =
                    admin.name || "Admin User";

                document.getElementById("adminPassword").value =
                    "";

                message.style.color =
                    "green";

                message.textContent =
                    "Profile updated successfully.";

                loadAllAdmins();

            }else{

                message.style.color =
                    "red";

                message.textContent =
                    data.message || "Update failed.";
            }

        }catch(error){

            message.style.color =
                "red";

            message.textContent =
                "Server error.";

            console.log(error);
        }
    }

    async function loadAllAdmins(){

        const tbody =
            document.getElementById("adminTableBody");

        try{

            const response =
                await fetch(API_BASE + "/admin/all");

            if(!response.ok){

                throw new Error("Failed to load admins");
            }

            allAdmins =
                await response.json();

            document.getElementById("statAdmins").textContent =
                allAdmins.length;

            if(allAdmins.length === 0){

                tbody.innerHTML =
                    "<tr><td colspan='5'>No admins found.</td></tr>";

                return;
            }

            tbody.innerHTML =
                allAdmins.map(function(a){

                    return `
                        <tr>
                            <td>#${a.id}</td>

                            <td>${a.name || "-"}</td>

                            <td>${a.email || "-"}</td>

                            <td>
                                <span class="role-badge">
                                    ${a.role || "ADMIN"}
                                </span>
                            </td>

                            <td>
                                <button class="edit-btn"
                                        onclick="editAdminAccount(${a.id})">
                                    <i class="fas fa-edit"></i>
                                    Edit
                                </button>

                                <button class="delete-btn"
                                        onclick="deleteAdminAccount(${a.id})">
                                    <i class="fas fa-trash"></i>
                                    Delete
                                </button>
                            </td>
                        </tr>
                    `;

                }).join("");

        }catch(error){

            tbody.innerHTML =
                "<tr><td colspan='5'>Failed to load admins. Check Spring Boot API.</td></tr>";
        }
    }

    function openAdminModal(){

        document.getElementById("adminModalTitle").textContent =
            "Add Admin";

        document.getElementById("editAdminId").value =
            "";

        document.getElementById("newAdminName").value =
            "";

        document.getElementById("newAdminEmail").value =
            "";

        document.getElementById("newAdminPassword").value =
            "";

        document.getElementById("newAdminRole").value =
            "ADMIN";

        document.getElementById("adminModal").style.display =
            "flex";
    }

    function closeAdminModal(){

        document.getElementById("adminModal").style.display =
            "none";
    }

    function editAdminAccount(id){

        const found =
            allAdmins.find(function(a){

                return Number(a.id) === Number(id);
            });

        if(!found){

            alert("Admin not found.");
            return;
        }

        document.getElementById("adminModalTitle").textContent =
            "Edit Admin";

        document.getElementById("editAdminId").value =
            found.id;

        document.getElementById("newAdminName").value =
            found.name || "";

        document.getElementById("newAdminEmail").value =
            found.email || "";

        document.getElementById("newAdminPassword").value =
            "";

        document.getElementById("newAdminRole").value =
            found.role || "ADMIN";

        document.getElementById("adminModal").style.display =
            "flex";
    }

    async function saveAdminAccount(){

        const message =
            document.getElementById("adminManageMessage");

        const id =
            document.getElementById("editAdminId").value;

        const name =
            document.getElementById("newAdminName").value.trim();

        const email =
            document.getElementById("newAdminEmail").value.trim();

        const password =
            document.getElementById("newAdminPassword").value.trim();

        const role =
            document.getElementById("newAdminRole").value;

        if(!name || !email){

            alert("Please enter name and email.");
            return;
        }

        if(!id && !password){

            alert("Please enter password for new admin.");
            return;
        }

        const payload = {

            name:name,
            email:email,
            password:password,
            role:role
        };

        let url =
            API_BASE + "/admin/add";

        let method =
            "POST";

        if(id){

            url =
                API_BASE + "/admin/update/" + id;

            method =
                "PUT";
        }

        try{

            const response =
                await fetch(url,{
                    method:method,

                    headers:{
                        "Content-Type":"application/json"
                    },

                    body:JSON.stringify(payload)
                });

            const data =
                await response.json();

            if(data.status === "success"){

                closeAdminModal();

                message.style.color =
                    "green";

                message.textContent =
                    data.message || "Admin saved successfully.";

                loadAllAdmins();

            }else{

                message.style.color =
                    "red";

                message.textContent =
                    data.message || "Failed to save admin.";
            }

        }catch(error){

            message.style.color =
                "red";

            message.textContent =
                "Server error while saving admin.";
        }
    }

    async function deleteAdminAccount(id){

        if(Number(id) === Number(admin.id)){

            alert("You cannot delete your currently logged-in admin account.");
            return;
        }

        if(!confirm("Delete this admin account?")){

            return;
        }

        const message =
            document.getElementById("adminManageMessage");

        try{

            const response =
                await fetch(API_BASE + "/admin/delete/" + id,{
                    method:"DELETE"
                });

            const data =
                await response.json();

            if(data.status === "success"){

                message.style.color =
                    "green";

                message.textContent =
                    "Admin deleted successfully.";

                loadAllAdmins();

            }else{

                message.style.color =
                    "red";

                message.textContent =
                    data.message || "Delete failed.";
            }

        }catch(error){

            message.style.color =
                "red";

            message.textContent =
                "Server error while deleting admin.";
        }
    }

    function logout(){

        localStorage.removeItem("admin");

        window.location.href =
            "login.jsp";
    }

</script>

</body>
</html>