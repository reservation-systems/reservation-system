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

    <title>Register - Golden Reech</title>

    <!-- Fonts & Icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500;700&display=swap"
          rel="stylesheet">

    <style>

        :root{

            --gold:#F4A100;
            --gold-dark:#C97D00;
            --brown:#3B1F0A;
            --brown-light:#5A2F0C;
            --cream:#FFF3DC;
            --white:#FFFFFF;

            --shadow:
                    0 20px 60px rgba(0,0,0,0.15);

            --transition:0.3s ease;
        }

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{

            font-family:'DM Sans',sans-serif;
            background:var(--cream);
            color:var(--gold);
            min-height:100vh;
        }

        /* =========================
           NAVBAR
        ========================== */

        .customer-navbar{

            position:fixed;
            top:0;
            left:0;
            right:0;

            z-index:1000;

            background:rgba(26,10,0,0.95);

            backdrop-filter:blur(12px);

            border-bottom:1px solid rgba(244,161,0,0.22);

            box-shadow:0 2px 28px rgba(0,0,0,0.30);
        }

        .navbar-container{

            max-width:1300px;

            margin:auto;

            height:75px;

            padding:0 2rem;

            display:flex;

            align-items:center;

            justify-content:space-between;
        }

        .logo{

            display:flex;

            align-items:center;

            gap:10px;

            text-decoration:none;

            font-family:'Playfair Display',serif;

            font-size:1.5rem;

            font-weight:900;

            color:var(--gold);
        }

        .logo i{

            color:var(--gold);
        }

        .nav-menu{

            display:flex;

            list-style:none;

            gap:1rem;
        }

        .nav-link{

            text-decoration:none;

            color:var(--gold);

            font-weight:500;

            padding:10px 16px;

            border-radius:8px;

            transition:var(--transition);
        }

        .nav-link:hover{

            background:rgba(244,166,35,0.12);

            color:var(--gold);
        }

        .btn{

            display:inline-flex;

            align-items:center;

            justify-content:center;

            gap:8px;

            text-decoration:none;

            border:none;

            cursor:pointer;

            transition:var(--transition);

            font-weight:600;

            border-radius:10px;
        }

        .btn-sm{

            padding:10px 18px;

            font-size:14px;
        }

        .btn-outline{

            border:2px solid var(--gold);

            color:var(--gold);

            background:transparent;
        }

        .btn-outline:hover{

            background:var(--gold);

            color:#fff;
        }

        /* =========================
           REGISTER PAGE
        ========================== */

        .register-page{

            min-height:100vh;

            display:flex;

            align-items:center;

            justify-content:center;

            padding:120px 20px 60px;

            background:
                    linear-gradient(
                            135deg,
                            rgba(244,166,35,0.08),
                            rgba(255,248,238,1)
                    );
        }

        .register-container{

            width:100%;

            max-width:1200px;
        }

        .register-card{

            display:grid;

            grid-template-columns:1fr 1fr;

            background:#fff;

            border-radius:28px;

            overflow:hidden;

            box-shadow:var(--shadow);
        }

        /* LEFT SIDE */

        .register-left{

            background:
                    linear-gradient(
                            135deg,
                            rgba(59,31,10,0.96),
                            rgba(90,47,12,0.96)
                    );

            color:#fff;

            padding:70px 60px;

            position:relative;

            overflow:hidden;

            display:flex;

            flex-direction:column;

            justify-content:center;
        }

        .register-left::before{

            content:'';

            position:absolute;

            width:350px;
            height:350px;

            border-radius:50%;

            background:
                    radial-gradient(
                            circle,
                            rgba(244,166,35,0.25),
                            transparent
                    );

            top:-80px;
            right:-80px;
        }

        .register-left h1{

            font-family:'Playfair Display',serif;

            font-size:3.2rem;

            line-height:1.1;

            margin-bottom:20px;

            color:var(--gold);

            position:relative;

            z-index:2;
        }

        .register-left p{

            font-size:1rem;

            line-height:1.9;

            opacity:0.9;

            margin-bottom:35px;

            position:relative;

            z-index:2;
        }

        .feature-list{

            display:flex;

            flex-direction:column;

            gap:18px;

            position:relative;

            z-index:2;
        }

        .feature-item{

            display:flex;

            align-items:center;

            gap:14px;

            font-size:15px;
        }

        .feature-item i{

            color:var(--gold);

            font-size:18px;
        }

        /* RIGHT SIDE */

        .register-right{

            background:var(--cream);

            padding:55px;
        }

        .register-header{

            margin-bottom:30px;
        }

        .register-header h2{

            font-family:'Playfair Display',serif;

            font-size:2rem;

            color:var(--gold);

            margin-bottom:10px;
        }

        .register-header p{

            color:#777;
        }

        form{

            display:flex;

            flex-direction:column;

            gap:18px;
        }

        .form-group{

            display:flex;

            flex-direction:column;
        }

        .form-group label{

            margin-bottom:8px;

            font-weight:600;

            color:var(--gold);
        }

        .form-group input,
        .form-group textarea{

            width:100%;

            padding:15px 16px;

            border-radius:14px;

            border:1px solid #ddd;

            background:#fff;

            font-size:15px;

            transition:var(--transition);
        }

        .form-group input:focus,
        .form-group textarea:focus{

            outline:none;

            border-color:var(--gold);

            box-shadow:
                    0 0 0 4px rgba(244,166,35,0.12);
        }

        textarea{

            resize:none;
        }

        .register-btn{

            width:100%;

            padding:15px;

            border:none;

            border-radius:14px;

            background:var(--gold);

            color:#fff;

            font-size:16px;

            font-weight:700;

            cursor:pointer;

            transition:var(--transition);

            margin-top:10px;
        }

        .register-btn:hover{

            background:var(--gold-dark);

            transform:translateY(-2px);

            box-shadow:
                    0 10px 25px rgba(244,166,35,0.3);
        }

        .login-link{

            margin-top:22px;

            text-align:center;

            color:#666;
        }

        .login-link a{

            color:var(--gold);

            text-decoration:none;

            font-weight:700;
        }

        /* =========================
           FOOTER
        ========================== */

        .customer-footer{

            background:var(--brown);

            color:#ddd;

            padding:60px 20px 20px;
        }

        .footer-content{

            max-width:1200px;

            margin:auto;

            display:grid;

            grid-template-columns:2fr 1fr 1fr;

            gap:40px;
        }

        .footer-section h3{

            color:var(--gold);

            margin-bottom:18px;
        }

        .footer-section p,
        .footer-section li{

            line-height:1.8;

            font-size:14px;
        }

        .footer-section ul{

            list-style:none;
        }

        .footer-section a{

            color:#ddd;

            text-decoration:none;
        }

        .footer-section a:hover{

            color:var(--gold);
        }

        .footer-bottom{

            text-align:center;

            margin-top:40px;

            padding-top:20px;

            border-top:1px solid rgba(255,255,255,0.1);

            font-size:13px;
        }

        /* =========================
           RESPONSIVE
        ========================== */

        @media(max-width:950px){

            .register-card{

                grid-template-columns:1fr;
            }

            .register-left{

                padding:50px 40px;
            }

            .register-right{

                padding:40px 30px;
            }
        }

        @media(max-width:700px){

            .nav-menu{

                display:none;
            }

            .register-left h1{

                font-size:2.4rem;
            }

            .footer-content{

                grid-template-columns:1fr;
            }
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav class="customer-navbar">

    <div class="navbar-container">

        <a href="home.jsp" class="logo">

            <i class="fas fa-utensils"></i>

            <span>Golden Reech</span>

        </a>

        <ul class="nav-menu">

            <li>
                <a href="home.jsp" class="nav-link">
                    Home
                </a>
            </li>

            <li>
                <a href="menu.jsp" class="nav-link">
                    Menu
                </a>
            </li>

            <li>
                <a href="offers.jsp" class="nav-link">
                    Offers
                </a>
            </li>

            <li>
                <a href="reservation.jsp" class="nav-link">
                    Reservation
                </a>
            </li>

            <li>
                <a href="reviews.jsp" class="nav-link">
                    Reviews
                </a>
            </li>

        </ul>

        <a href="login.jsp"
           class="btn btn-outline btn-sm">

            Login

        </a>

    </div>

</nav>

<!-- REGISTER SECTION -->

<section class="register-page">

    <div class="register-container">

        <div class="register-card">

            <!-- LEFT -->

            <div class="register-left">

                <h1>
                    Join<br>
                    Golden Reech
                </h1>

                <p>
                    Create your account and enjoy premium dining,
                    fast reservations, luxury atmosphere,
                    and exclusive restaurant offers.
                </p>

                <div class="feature-list">

                    <div class="feature-item">
                        <i class="fas fa-check-circle"></i>
                        Online Reservation System
                    </div>

                    <div class="feature-item">
                        <i class="fas fa-check-circle"></i>
                        Premium Dining Experience
                    </div>

                    <div class="feature-item">
                        <i class="fas fa-check-circle"></i>
                        Exclusive Offers & Discounts
                    </div>

                </div>

            </div>

            <!-- RIGHT -->

            <div class="register-right">

                <div class="register-header">

                    <h2>Create Account</h2>

                    <p>
                        Register your Golden Reech account
                    </p>

                </div>

                <form id="registerForm">

                    <div class="form-group">

                        <label>Full Name</label>

                        <input type="text"
                               id="fullName"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Email</label>

                        <input type="email"
                               id="email"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Phone Number</label>

                        <input type="text"
                               id="phone"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Address</label>

                        <textarea id="address"
                                  rows="3"></textarea>

                    </div>

                    <div class="form-group">

                        <label>Password</label>

                        <input type="password"
                               id="password"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Confirm Password</label>

                        <input type="password"
                               id="confirmPassword"
                               required>

                    </div>

                    <button type="submit"
                            class="register-btn">

                        <i class="fas fa-user-plus"></i>

                        Create Account

                    </button>

                </form>

                <div class="login-link">

                    Already have an account?

                    <a href="login.jsp">
                        Login
                    </a>

                </div>

            </div>

        </div>

    </div>

</section>

<!-- FOOTER -->

<footer class="customer-footer">

    <div class="footer-content">

        <div class="footer-section">

            <h3>About Us</h3>

            <p>
                Golden Reech is a modern restaurant offering delicious meals,
                premium dining experiences, and excellent customer service.
            </p>

        </div>

        <div class="footer-section">

            <h3>Quick Links</h3>

            <ul>

                <li>
                    <a href="home.jsp">Home</a>
                </li>

                <li>
                    <a href="menu.jsp">Menu</a>
                </li>

                <li>
                    <a href="offers.jsp">Offers</a>
                </li>

                <li>
                    <a href="reservation.jsp">Reservations</a>
                </li>

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
                    <i class="fas fa-envelope"></i>
                    info@goldenreech.com
                </li>

            </ul>

        </div>

    </div>

    <div class="footer-bottom">

        <p>
            &copy; 2024 Golden Reech.
            All rights reserved.
        </p>

    </div>

</footer>

<!-- SCRIPT -->

<script>

    const API_BASE =
        "http://localhost:8080/api";

    document.getElementById(
        "registerForm"
    ).addEventListener(
        "submit",
        registerUser
    );

    async function registerUser(event){

        event.preventDefault();

        const password =
            document.getElementById(
                "password"
            ).value;

        const confirmPassword =
            document.getElementById(
                "confirmPassword"
            ).value;

        if(password !== confirmPassword){

            alert(
                "Passwords do not match."
            );

            return;
        }

        const user = {

            fullName:
            document.getElementById(
                "fullName"
            ).value,

            email:
            document.getElementById(
                "email"
            ).value,

            phone:
            document.getElementById(
                "phone"
            ).value,

            address:
            document.getElementById(
                "address"
            ).value,

            password:
            password
        };

        try{

            const response =
                await fetch(
                    `${API_BASE}/customers`,
                    {

                        method:"POST",

                        headers:{
                            "Content-Type":
                                "application/json"
                        },

                        body:
                            JSON.stringify(user)
                    }
                );

            if(!response.ok){

                throw new Error(
                    "Registration failed"
                );
            }

            alert(
                "Registration successful!"
            );

            window.location.href =
                "login.jsp";

        }catch(error){

            console.error(error);

            alert(
                "Failed to register user."
            );
        }
    }

</script>

</body>
</html>