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

    <title>My Profile - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

    <!-- KEEP ORIGINAL PATHS -->
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
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
        .btn-outline { border: 1.5px solid var(--gold); color: var(--gold-dk); background: transparent; }
        .btn-outline:hover { background: var(--gold); color: var(--white); }
        .btn-primary { background: var(--gold); color: var(--white); padding: .8rem 1.6rem; font-size: .92rem; }
        .btn-primary:hover { background: var(--gold-dk); transform: translateY(-1px); box-shadow: 0 6px 20px rgba(244,166,35,.35); }

        /* ══ PAGE BANNER ══ */
        .page-banner {
            margin-top: 70px;
            background: linear-gradient(135deg, var(--brown) 0%, #6B3A1F 100%);
            padding: 3.6rem 2rem;
            text-align: center;
            color: var(--white);
            position: relative;
            overflow: hidden;
        }
        .page-banner::after {
            content: '';
            position: absolute;
            right: -60px; top: -80px;
            width: 260px; height: 260px;
            border-radius: 50%;
            background: rgba(244,166,35,.08);
        }
        .page-banner::before {
            content: '';
            position: absolute;
            left: 8%; bottom: -90px;
            width: 180px; height: 180px;
            border-radius: 50%;
            background: rgba(255,255,255,.04);
        }
        .page-banner .container { position: relative; z-index: 1; }
        .page-banner h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(1.8rem, 4vw, 2.6rem);
            font-weight: 900;
            margin-bottom: .5rem;
        }
        .page-banner p { font-size: .95rem; opacity: .75; }

        /* ══ CONTAINER / SECTION ══ */
        .container { max-width: 1100px; margin: 0 auto; padding: 0 2rem; }
        .section { padding: 3.5rem 0 4.5rem; }

        /* ══ PROFILE LAYOUT ══ */
        .profile-layout {
            display: grid;
            grid-template-columns: 1fr 1.6fr;
            gap: 1.6rem;
            align-items: start;
        }

        /* ══ PROFILE CARD (left) ══ */
        .profile-card {
            background: var(--white);
            border-radius: 18px;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
            padding: 2.4rem 1.6rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .profile-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 90px;
            background: linear-gradient(135deg, var(--gold) 0%, #ff9a3c 100%);
        }
        .profile-avatar {
            position: relative;
            z-index: 1;
            width: 96px; height: 96px;
            margin: 20px auto 1rem;
            border-radius: 50%;
            background: var(--white);
            border: 4px solid var(--white);
            box-shadow: 0 8px 24px rgba(59,31,10,.2);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .profile-avatar i { font-size: 3.2rem; color: var(--gold); }
        .profile-card h2#profileName {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            font-weight: 900;
            color: var(--brown);
            margin-bottom: .35rem;
        }
        .profile-card p#profileEmail {
            font-size: .86rem;
            color: #999;
            word-break: break-all;
        }

        /* ══ PROFILE FORM CARD (right) ══ */
        .profile-form-card {
            background: var(--white);
            border-radius: 18px;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
            padding: 2rem 2.2rem 2.4rem;
        }
        .profile-form-card h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--brown);
            margin-bottom: 1.6rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(59,31,10,.08);
            display: flex;
            align-items: center;
            gap: .5rem;
        }
        .profile-form-card h2::before {
            content: '\f044';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: var(--gold);
            font-size: 1rem;
        }

        .form-group { margin-bottom: 1.3rem; }
        .form-label {
            display: block;
            font-size: .82rem;
            font-weight: 700;
            color: var(--brown);
            margin-bottom: .45rem;
            letter-spacing: .01em;
        }
        .form-control {
            width: 100%;
            padding: .75rem .95rem;
            border: 1.5px solid rgba(59,31,10,.14);
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: .92rem;
            color: var(--brown);
            background: var(--cream);
            transition: border-color .2s, box-shadow .2s, background .2s;
            outline: none;
        }
        .form-control:focus {
            border-color: var(--gold);
            background: var(--white);
            box-shadow: 0 0 0 4px rgba(244,166,35,.12);
        }
        .form-control::placeholder { color: #bbb; }
        textarea.form-control { resize: vertical; min-height: 80px; }

        .profile-form-card .btn-primary {
            width: 100%;
            justify-content: center;
            margin-top: .4rem;
            border-radius: 10px;
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
        .footer-section h3 { font-family: 'Playfair Display', serif; color: var(--gold); font-size: 1.05rem; margin-bottom: 1rem; }
        .footer-section p { font-size: .88rem; line-height: 1.7; }
        .footer-section ul { list-style: none; }
        .footer-section ul li { margin-bottom: .5rem; font-size: .88rem; }
        .footer-section ul li a { color: rgba(255,255,255,.7); text-decoration: none; transition: color .2s; }
        .footer-section ul li a:hover { color: var(--gold); }
        .footer-section ul li i { margin-right: .5rem; color: var(--gold); }
        .footer-bottom { text-align: center; border-top: 1px solid rgba(255,255,255,.1); padding: 1.2rem 2rem; font-size: .82rem; opacity: .55; }

        /* ══ RESPONSIVE ══ */
        @media (max-width: 900px) {
            .profile-layout { grid-template-columns: 1fr; }
            .footer-content { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 620px) {
            .nav-menu { display: none; }
            .footer-content { grid-template-columns: 1fr; gap: 2rem; }
            .profile-form-card { padding: 1.6rem 1.3rem 2rem; }
        }
    </style>

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

            <li><a href="reviews.jsp" class="nav-link">Reviews</a></li>

        </ul>

        <div class="nav-actions">

            <a href="customer-dashboard.jsp"
               class="btn btn-outline btn-sm">

                <i class="fas fa-user"></i>
                Dashboard

            </a>

            <button class="btn btn-primary btn-sm"
                    onclick="logout()">

                <i class="fas fa-sign-out-alt"></i>
                Logout

            </button>

        </div>

    </div>

</nav>

<section class="page-banner">

    <div class="container">

        <h1>My Profile</h1>

        <p>
            Manage your account information
        </p>

    </div>

</section>

<section class="section">

    <div class="container">

        <div class="profile-layout">

            <div class="profile-card">

                <div class="profile-avatar">

                    <i class="fas fa-user-circle"></i>

                </div>

                <h2 id="profileName">
                    Loading...
                </h2>

                <p id="profileEmail">
                    Loading...
                </p>

            </div>

            <div class="profile-form-card">

                <h2>
                    Update Profile
                </h2>

                <form id="profileForm">

                    <input type="hidden"
                           id="userId">

                    <div class="form-group">

                        <label class="form-label">
                            Full Name
                        </label>

                        <input type="text"
                               id="fullName"
                               class="form-control">

                    </div>

                    <div class="form-group">

                        <label class="form-label">
                            Email Address
                        </label>

                        <input type="email"
                               id="email"
                               class="form-control">

                    </div>

                    <div class="form-group">

                        <label class="form-label">
                            Phone Number
                        </label>

                        <input type="text"
                               id="phone"
                               class="form-control">

                    </div>

                    <div class="form-group">

                        <label class="form-label">
                            Address
                        </label>

                        <textarea id="address"
                                  class="form-control"
                                  rows="3"></textarea>

                    </div>

                    <div class="form-group">

                        <label class="form-label">
                            New Password
                        </label>

                        <input type="password"
                               id="password"
                               class="form-control"
                               placeholder="Leave blank to keep current password">

                    </div>

                    <button type="submit"
                            class="btn btn-primary">

                        <i class="fas fa-save"></i>
                        Update Profile

                    </button>

                </form>

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

                <li>
                    <i class="fas fa-phone"></i>
                    +94 77 568 4650
                </li>

                <li>
                    <i class="fas fa-phone"></i>
                    +94 75 457 6071
                </li>

                <li>
                    <i class="fas fa-envelope"></i>
                    info@goldenreech.com
                </li>

            </ul>

        </div>

    </div>

    <div class="footer-bottom">
        <p>&copy; 2024 Golden Reech. All rights reserved.</p>
    </div>

</footer>

<!-- KEEP ORIGINAL PATH -->
<script src="./js/main.js"></script>

<script>

    const API_BASE =
        "http://localhost:8080/api/customers";

    let currentUser = null;

    document.addEventListener(
        "DOMContentLoaded",
        () => {

            const customer =
                JSON.parse(localStorage.getItem("customer"));

            if(!customer){

                alert("Please login first.");

                window.location.href =
                    "login.jsp";

                return;
            }

            loadProfile(customer.email);

            document.getElementById("profileForm")
                .addEventListener(
                    "submit",
                    updateProfile
                );
        }
    );

    async function loadProfile(email){

        try{

            const response =
                await fetch(
                    `${API_BASE}/email/${encodeURIComponent(email)}`
                );

            if(!response.ok){
                throw new Error("Failed");
            }

            currentUser =
                await response.json();

            fillProfileData(currentUser);

        }catch(error){

            console.error(error);

            alert(
                "Failed to load profile."
            );
        }
    }

    function fillProfileData(user){

        document.getElementById("userId").value =
            user.id || "";

        document.getElementById("fullName").value =
            user.name || "";

        document.getElementById("email").value =
            user.email || "";

        document.getElementById("phone").value =
            user.phone || "";

        document.getElementById("address").value =
            user.address || "";

        document.getElementById("profileName").textContent =
            user.name || "Customer";

        document.getElementById("profileEmail").textContent =
            user.email || "";
    }

    async function updateProfile(event){

        event.preventDefault();

        const updatedUser = {

            id:
            document.getElementById("userId").value,

            name:
            document.getElementById("fullName").value,

            email:
            document.getElementById("email").value,

            phone:
            document.getElementById("phone").value,

            address:
            document.getElementById("address").value,

            password:
                document.getElementById("password").value
                || currentUser.password
        };

        try{

            const response =
                await fetch(
                    `${API_BASE}/${updatedUser.id}`,
                    {

                        method:"PUT",

                        headers:{
                            "Content-Type":"application/json"
                        },

                        body: JSON.stringify(updatedUser)
                    }
                );

            if(!response.ok){
                throw new Error("Failed");
            }

            localStorage.setItem(
                "customer",
                JSON.stringify(updatedUser)
            );

            alert(
                "Profile updated successfully!"
            );

            loadProfile(updatedUser.email);

            document.getElementById("password").value = "";

        }catch(error){

            console.error(error);

            alert(
                "Failed to update profile."
            );
        }
    }

    function logout(){

        localStorage.removeItem("customer");

        window.location.href =
            "home.jsp";
    }

</script>

</body>
</html>