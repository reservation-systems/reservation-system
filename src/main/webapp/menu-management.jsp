<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Management - Golden Reech</title>

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

        .category-filter-wrapper {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 1.5rem;
        }

        .category-btn {
            padding: 10px 22px;
            border: 1px solid #ff6b00;
            border-radius: 999px;
            background: #ffffff;
            color: #ff6b00;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .category-btn:hover,
        .category-btn.active {
            background: #ff6b00;
            color: #ffffff;
        }

        .form-control,
        #itemCategory,
        #itemPrice,
        #itemName,
        #itemDescription,
        #itemPhoto {
            border-radius: 12px;
        }

        .available-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 12px;
            margin-bottom: 18px;
        }

        .available-checkbox {
            width: 18px;
            height: 18px;
            accent-color: #ff6b00;
        }

        .available-label {
            background: #ff6b00;
            color: #ffffff;
            padding: 8px 18px;
            border-radius: 999px;
            font-weight: 600;
            font-size: 14px;
        }

        .menu-items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .menu-item-card {
            background: #ffffff;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,0.09);
            display: flex;
            flex-direction: column;
        }

        .menu-item-image {
            position: relative;
            height: 180px;
            background: #fff4e8;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
        }

        .food-photo {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .menu-item-image i {
            font-size: 38px;
            color: #ff6b00;
        }

        .available-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: #ff6b00;
            color: #ffffff;
            padding: 5px 13px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
        }

        .unavailable-badge {
            background: #dc3545;
        }

        .menu-item-info {
            padding: 14px 16px 8px;
            flex: 1;
        }

        .menu-item-info h4 {
            margin: 0 0 5px;
            font-size: 1rem;
            font-weight: 700;
            color: #1a1a1a;
        }

        .menu-item-info .price {
            color: #ff6b00;
            font-weight: 700;
            font-size: 0.95rem;
            margin: 0 0 3px;
        }

        .menu-item-info .category-tag {
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.05em;
            color: #999;
            text-transform: uppercase;
            margin: 0 0 6px;
        }

        .menu-item-info .desc {
            font-size: 0.84rem;
            color: #666;
            margin: 0;
        }

        .menu-item-actions {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
            padding: 10px 14px 14px;
            border-top: 1px solid #f2f2f2;
            background: #fafafa;
            flex-shrink: 0;
        }

        .action-btn {
            width: 38px;
            height: 38px;
            border: none;
            border-radius: 50%;
            color: #ffffff;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s, opacity 0.2s;
        }

        .action-btn.edit  { background: #ff6b00; }
        .action-btn.delete { background: #dc3545; }

        .action-btn:hover {
            opacity: 0.85;
            transform: scale(1.1);
        }

        .form-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #ff6b00;
        }

        .photo-preview-box {
            margin-top: 10px;
            display: none;
        }

        .photo-preview-box img {
            width: 100%;
            max-height: 180px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid #ff6b00;
        }

        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.45);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.open {
            display: flex;
        }

        .modal-box {
            background: #ffffff;
            border-radius: 20px;
            width: 100%;
            max-width: 520px;
            max-height: 90vh;
            overflow-y: auto;
            padding: 2rem;
            position: relative;
            box-shadow: 0 8px 40px rgba(0,0,0,0.18);
        }

        .modal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.4rem;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 700;
            color: #ff6b00;
        }

        .modal-close {
            width: 34px;
            height: 34px;
            border: none;
            border-radius: 50%;
            background: #f0f0f0;
            cursor: pointer;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s;
        }

        .modal-close:hover { background: #e0e0e0; }

        .modal-form-group {
            margin-bottom: 1rem;
        }

        .modal-form-group label {
            display: block;
            font-weight: 600;
            font-size: 0.88rem;
            color: #444;
            margin-bottom: 5px;
        }

        .modal-form-group input,
        .modal-form-group select,
        .modal-form-group textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.93rem;
            outline: none;
            transition: border 0.2s;
            box-sizing: border-box;
        }

        .modal-form-group input:focus,
        .modal-form-group select:focus,
        .modal-form-group textarea:focus {
            border-color: #ff6b00;
        }

        .modal-available-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 10px 0 18px;
        }

        .modal-available-row input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #ff6b00;
        }

        .modal-available-row span {
            background: #ff6b00;
            color: #fff;
            padding: 6px 16px;
            border-radius: 999px;
            font-weight: 600;
            font-size: 13px;
        }

        .modal-footer {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 1.2rem;
        }

        .modal-edit-preview {
            margin-top: 8px;
            display: none;
        }

        .modal-edit-preview img {
            width: 100%;
            max-height: 160px;
            object-fit: cover;
            border-radius: 10px;
            border: 2px solid #ff6b00;
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

            <a href="menu-management.jsp" class="sidebar-nav-item active">
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
                    <span>Menu</span>
                </div>
            </div>

            <div class="navbar-right">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text"
                           id="menuSearch"
                           placeholder="Search menu items..."
                           onkeyup="filterMenuItems()">
                </div>
            </div>

        </nav>

        <div class="admin-content">

            <div class="page-header">
                <h1>Menu Management</h1>

                <div class="page-actions">
                    <button class="btn btn-outline" onclick="window.print()">
                        <i class="fas fa-print"></i> Print
                    </button>

                    <button class="btn btn-primary" onclick="openAddForm()">
                        <i class="fas fa-plus"></i> Add Item
                    </button>
                </div>
            </div>

            <div id="menuFormBox"
                 class="data-table-container"
                 style="display:none; margin-bottom:1.5rem;">

                <div class="table-header">
                    <h3 class="form-title">Add Menu Item</h3>
                </div>

                <div style="padding:1rem;">

                    <input type="hidden" id="itemPhotoData">

                    <div class="form-group">
                        <label class="form-label">Item Name</label>
                        <input type="text" id="itemName" class="form-control"
                               placeholder="Enter menu item name">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Category</label>
                        <select id="itemCategory" class="form-control">
                            <option value="STARTER">Starter</option>
                            <option value="MAIN_COURSE">Main Course</option>
                            <option value="DESSERT">Dessert</option>
                            <option value="DRINK">Drink</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Price</label>
                        <input type="number" id="itemPrice" class="form-control"
                               placeholder="Enter price in Rs." min="0" step="0.01">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Food Photo</label>
                        <input type="file" id="itemPhoto" class="form-control"
                               accept="image/*" onchange="previewAddPhoto(event)">
                        <div class="photo-preview-box" id="addPhotoPreview">
                            <img id="addPhotoImg" src="" alt="Preview">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea id="itemDescription" class="form-control"
                                  rows="3" placeholder="Enter description"></textarea>
                    </div>

                    <div class="available-row">
                        <input type="checkbox" id="itemAvailable"
                               class="available-checkbox" checked>
                        <span class="available-label">Available</span>
                    </div>

                    <button class="btn btn-primary" onclick="saveNewItem()">
                        <i class="fas fa-save"></i> Save
                    </button>

                    <button class="btn btn-outline" onclick="closeAddForm()">
                        Cancel
                    </button>

                </div>
            </div>

            <div class="category-filter-wrapper">
                <button class="category-btn active"
                        onclick="filterByCategory('ALL', this)">All Items</button>
                <button class="category-btn"
                        onclick="filterByCategory('STARTER', this)">Starters</button>
                <button class="category-btn"
                        onclick="filterByCategory('MAIN_COURSE', this)">Main Course</button>
                <button class="category-btn"
                        onclick="filterByCategory('DESSERT', this)">Desserts</button>
                <button class="category-btn"
                        onclick="filterByCategory('DRINK', this)">Drinks</button>
            </div>

            <div class="data-table-container" style="margin-bottom:1.5rem;">
                <div class="table-header">
                    <h3 id="menuCount">Menu Items (0)</h3>
                </div>
            </div>

            <div class="menu-items-grid" id="menuItemsGrid">
                <p>Loading menu items...</p>
            </div>

        </div>

    </main>

</div>

<div class="modal-overlay" id="editModal">
    <div class="modal-box">

        <div class="modal-header">
            <h3><i class="fas fa-pen"></i> &nbsp;Edit Menu Item</h3>
            <button class="modal-close" onclick="closeEditModal()">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <input type="hidden" id="editItemId">
        <input type="hidden" id="editPhotoData">

        <div class="modal-form-group">
            <label>Item Name</label>
            <input type="text" id="editName" placeholder="Item name">
        </div>

        <div class="modal-form-group">
            <label>Category</label>
            <select id="editCategory">
                <option value="STARTER">Starter</option>
                <option value="MAIN_COURSE">Main Course</option>
                <option value="DESSERT">Dessert</option>
                <option value="DRINK">Drink</option>
            </select>
        </div>

        <div class="modal-form-group">
            <label>Price (Rs.)</label>
            <input type="number" id="editPrice" placeholder="Price" min="0" step="0.01">
        </div>

        <div class="modal-form-group">
            <label>Food Photo</label>
            <input type="file" id="editPhoto" accept="image/*"
                   onchange="previewEditPhoto(event)">
            <div class="modal-edit-preview" id="editPhotoPreview">
                <img id="editPhotoImg" src="" alt="Preview">
            </div>
        </div>

        <div class="modal-form-group">
            <label>Description</label>
            <textarea id="editDescription" rows="3"
                      placeholder="Description"></textarea>
        </div>

        <div class="modal-available-row">
            <input type="checkbox" id="editAvailable" checked>
            <span>Available</span>
        </div>

        <div class="modal-footer">
            <button class="btn btn-outline" onclick="closeEditModal()">
                Cancel
            </button>
            <button class="btn btn-primary" onclick="saveEditedItem()">
                <i class="fas fa-save"></i> Update
            </button>
        </div>

    </div>
</div>

<script src="./js/main.js"></script>
<script src="./js/validation.js"></script>
<script src="./js/admin.js"></script>

<script>
    var API_BASE = "http://localhost:8080/api";
    var menuItems = [];
    var selectedCategory = "ALL";

    document.addEventListener("DOMContentLoaded", loadMenuItems);

    async function loadMenuItems() {
        var grid = document.getElementById("menuItemsGrid");

        try {
            var res = await fetch(API_BASE + "/menu");

            if (!res.ok) {
                throw new Error("Failed");
            }

            menuItems = await res.json();

            var photos = JSON.parse(localStorage.getItem("menuPhotos") || "{}");

            menuItems = menuItems.map(function(item) {
                return Object.assign({}, item, {
                    photo: photos[String(item.id)] || ""
                });
            });

            renderMenuItems(menuItems);

        } catch (e) {
            grid.innerHTML = "<p>Failed to load menu items.</p>";
        }
    }

    function getPhotoHTML(item) {
        if (item.photo) {
            return '<img src="' + item.photo + '" class="food-photo" alt="' + escapeText(item.name) + '">';
        }

        return '<i class="fas fa-utensils"></i>';
    }

    function renderMenuItems(items) {
        var grid = document.getElementById("menuItemsGrid");

        document.getElementById("menuCount").textContent =
            "Menu Items (" + items.length + ")";

        if (items.length === 0) {
            grid.innerHTML = "<p>No menu items found.</p>";
            return;
        }

        grid.innerHTML = items.map(function(item) {
            var badgeClass = item.available ? "" : "unavailable-badge";
            var badgeText = item.available ? "Available" : "Unavailable";

            return (
                '<div class="menu-item-card">' +

                '<div class="menu-item-image">' +
                getPhotoHTML(item) +
                '<span class="available-badge ' + badgeClass + '">' +
                badgeText +
                '</span>' +
                '</div>' +

                '<div class="menu-item-info">' +
                '<h4>' + (item.name || "-") + '</h4>' +
                '<p class="price">Rs. ' + Number(item.price || 0).toFixed(2) + '</p>' +
                '<p class="category-tag">' + formatCategory(item.category) + '</p>' +
                '<p class="desc">' + (item.description || "") + '</p>' +
                '</div>' +

                '<div class="menu-item-actions">' +

                '<button class="action-btn edit" title="Edit"' +
                ' onclick="openEditModal(' + item.id + ')">' +
                '<i class="fas fa-pen"></i>' +
                '</button>' +

                '<button class="action-btn delete" title="Delete"' +
                ' onclick="deleteMenuItem(' + item.id + ', \'' + escapeText(item.name) + '\')">' +
                '<i class="fas fa-trash"></i>' +
                '</button>' +

                '</div>' +

                '</div>'
            );
        }).join("");
    }

    function openAddForm() {
        document.getElementById("itemName").value = "";
        document.getElementById("itemCategory").value = "STARTER";
        document.getElementById("itemPrice").value = "";
        document.getElementById("itemPhoto").value = "";
        document.getElementById("itemPhotoData").value = "";
        document.getElementById("itemDescription").value = "";
        document.getElementById("itemAvailable").checked = true;
        document.getElementById("addPhotoPreview").style.display = "none";
        document.getElementById("addPhotoImg").src = "";
        document.getElementById("menuFormBox").style.display = "block";
        document.getElementById("menuFormBox").scrollIntoView({ behavior: "smooth" });
    }

    function closeAddForm() {
        document.getElementById("menuFormBox").style.display = "none";
    }

    function previewAddPhoto(event) {
        var file = event.target.files[0];

        if (!file) {
            return;
        }

        var reader = new FileReader();

        reader.onload = function(e) {
            document.getElementById("itemPhotoData").value = e.target.result;
            document.getElementById("addPhotoImg").src = e.target.result;
            document.getElementById("addPhotoPreview").style.display = "block";
        };

        reader.readAsDataURL(file);
    }

    async function saveNewItem() {
        var item = {
            name: document.getElementById("itemName").value.trim(),
            category: document.getElementById("itemCategory").value,
            price: Number(document.getElementById("itemPrice").value),
            description: document.getElementById("itemDescription").value.trim(),
            available: document.getElementById("itemAvailable").checked
        };

        var photoData = document.getElementById("itemPhotoData").value;

        if (!item.name || isNaN(item.price) || item.price < 0) {
            alert("Please fill all details correctly.");
            return;
        }

        try {
            var res = await fetch(API_BASE + "/menu", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(item)
            });

            if (!res.ok) {
                throw new Error("Failed");
            }

            var saved = await res.json();

            if (photoData) {
                var photos = JSON.parse(localStorage.getItem("menuPhotos") || "{}");
                photos[String(saved.id)] = photoData;
                localStorage.setItem("menuPhotos", JSON.stringify(photos));
            }

            closeAddForm();
            loadMenuItems();

        } catch (e) {
            alert("Failed to save item.");
        }
    }

    function openEditModal(id) {
        var item = null;

        for (var i = 0; i < menuItems.length; i++) {
            if (String(menuItems[i].id) === String(id)) {
                item = menuItems[i];
                break;
            }
        }

        if (!item) {
            alert("Item not found.");
            return;
        }

        document.getElementById("editItemId").value = item.id;
        document.getElementById("editName").value = item.name || "";
        document.getElementById("editCategory").value = item.category || "STARTER";
        document.getElementById("editPrice").value = item.price || "";
        document.getElementById("editDescription").value = item.description || "";
        document.getElementById("editAvailable").checked = item.available;
        document.getElementById("editPhoto").value = "";

        if (item.photo) {
            document.getElementById("editPhotoData").value = item.photo;
            document.getElementById("editPhotoImg").src = item.photo;
            document.getElementById("editPhotoPreview").style.display = "block";
        } else {
            document.getElementById("editPhotoData").value = "";
            document.getElementById("editPhotoImg").src = "";
            document.getElementById("editPhotoPreview").style.display = "none";
        }

        document.getElementById("editModal").classList.add("open");
        document.body.style.overflow = "hidden";
    }

    function closeEditModal() {
        document.getElementById("editModal").classList.remove("open");
        document.body.style.overflow = "";
    }

    document.getElementById("editModal").addEventListener("click", function(e) {
        if (e.target === this) {
            closeEditModal();
        }
    });

    function previewEditPhoto(event) {
        var file = event.target.files[0];

        if (!file) {
            return;
        }

        var reader = new FileReader();

        reader.onload = function(e) {
            document.getElementById("editPhotoData").value = e.target.result;
            document.getElementById("editPhotoImg").src = e.target.result;
            document.getElementById("editPhotoPreview").style.display = "block";
        };

        reader.readAsDataURL(file);
    }

    async function saveEditedItem() {
        var id = document.getElementById("editItemId").value;
        var name = document.getElementById("editName").value.trim();
        var price = Number(document.getElementById("editPrice").value);

        if (!name || isNaN(price) || price < 0) {
            alert("Please fill all details correctly.");
            return;
        }

        var updated = {
            name: name,
            category: document.getElementById("editCategory").value,
            price: price,
            description: document.getElementById("editDescription").value.trim(),
            available: document.getElementById("editAvailable").checked
        };

        var photoData = document.getElementById("editPhotoData").value;

        try {
            var res = await fetch(API_BASE + "/menu/" + id, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(updated)
            });

            var savedId = id;

            if (res.ok) {
                var savedItem = await res.json();
                savedId = String(savedItem.id);
            }

            var photos = JSON.parse(localStorage.getItem("menuPhotos") || "{}");

            if (photoData) {
                photos[savedId] = photoData;
            }

            localStorage.setItem("menuPhotos", JSON.stringify(photos));

            for (var i = 0; i < menuItems.length; i++) {
                if (String(menuItems[i].id) === String(id)) {
                    menuItems[i] = Object.assign({}, menuItems[i], updated, {
                        photo: photoData || menuItems[i].photo
                    });
                    break;
                }
            }

            closeEditModal();
            applyFilters();
            loadMenuItems();

        } catch (e) {
            alert("Failed to update item. Please check your backend PUT endpoint.");
        }
    }

    async function deleteMenuItem(id, name) {
        if (!confirm('Delete "' + name + '" ?')) {
            return;
        }

        try {
            var res = await fetch(API_BASE + "/menu/" + id, {
                method: "DELETE"
            });

            if (!res.ok) {
                throw new Error("Failed");
            }

            var photos = JSON.parse(localStorage.getItem("menuPhotos") || "{}");
            delete photos[String(id)];
            localStorage.setItem("menuPhotos", JSON.stringify(photos));

            loadMenuItems();

        } catch (e) {
            alert("Failed to delete item.");
        }
    }

    function filterByCategory(category, button) {
        selectedCategory = category;

        document.querySelectorAll(".category-btn").forEach(function(btn) {
            btn.classList.remove("active");
        });

        button.classList.add("active");

        applyFilters();
    }

    function filterMenuItems() {
        applyFilters();
    }

    function applyFilters() {
        var keyword = document.getElementById("menuSearch").value.toLowerCase();

        var filtered = menuItems.filter(function(item) {
            var matchSearch =
                (item.name || "").toLowerCase().includes(keyword) ||
                (item.description || "").toLowerCase().includes(keyword) ||
                (item.category || "").toLowerCase().includes(keyword);

            var matchCat =
                selectedCategory === "ALL" || item.category === selectedCategory;

            return matchSearch && matchCat;
        });

        renderMenuItems(filtered);
    }

    function formatCategory(cat) {
        if (!cat) {
            return "-";
        }

        return cat.replace(/_/g, " ")
            .toLowerCase()
            .replace(/\b\w/g, function(c) {
                return c.toUpperCase();
            });
    }

    function escapeText(text) {
        return String(text || "").replace(/'/g, "\\'");
    }
</script>

</body>
</html>