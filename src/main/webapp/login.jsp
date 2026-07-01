<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Golden Reech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

    <style>
        :root {
            --gold:    #F4A623;
            --gold-dk: #C97D10;
            --brown:   #3B1F0A;
            --cream:   #FFF8EE;
            --white:   #FFFFFF;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'DM Sans', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background:
                    linear-gradient(135deg, rgba(30,13,3,.82) 0%, rgba(30,13,3,.65) 100%),
                    url('./images/restaurant-banner.jpg') center/cover no-repeat;
        }

        /* ══ CARD ══ */
        .login-card {
            width: 100%;
            max-width: 420px;
            background: var(--white);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 24px 60px rgba(0,0,0,.35);
            animation: slideUp .6s ease both;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ══ HEADER ══ */
        .card-header {
            background: linear-gradient(135deg, var(--brown) 0%, #6B3A1F 100%);
            padding: 2.5rem 2rem 2rem;
            text-align: center;
            color: var(--white);
        }

        .logo-circle {
            width: 72px; height: 72px;
            background: rgba(255,255,255,.12);
            border: 2px solid rgba(244,166,35,.5);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.8rem;
            color: var(--gold);
        }

        .card-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 1.7rem;
            font-weight: 900;
            margin-bottom: .3rem;
        }

        .card-header p {
            font-size: .88rem;
            opacity: .72;
        }

        /* ══ BODY ══ */
        .card-body {
            padding: 2rem;
        }

        .form-group { margin-bottom: 1.2rem; }

        .form-label {
            display: block;
            font-size: .82rem;
            font-weight: 600;
            color: #666;
            margin-bottom: 6px;
        }

        .input-wrap {
            position: relative;
        }

        .input-wrap .icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #bbb;
            font-size: .9rem;
            pointer-events: none;
        }

        .form-control {
            width: 100%;
            padding: .75rem 1rem .75rem 2.6rem;
            border: 1.5px solid rgba(59,31,10,.12);
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: .93rem;
            color: var(--brown);
            background: #fafafa;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }

        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(244,166,35,.12);
            background: var(--white);
        }

        .toggle-pw {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: #bbb;
            font-size: .9rem;
            transition: color .2s;
        }
        .toggle-pw:hover { color: var(--gold-dk); }

        /* ══ SUBMIT ══ */
        .btn-login {
            width: 100%;
            padding: .85rem;
            background: linear-gradient(135deg, var(--gold), var(--gold-dk));
            color: var(--white);
            border: none;
            border-radius: 12px;
            font-family: 'DM Sans', sans-serif;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: .5rem;
            margin-top: 1.2rem;
            transition: transform .2s, box-shadow .2s;
            box-shadow: 0 4px 16px rgba(244,166,35,.3);
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(244,166,35,.4);
        }
        .btn-login:disabled { opacity: .6; cursor: not-allowed; transform: none; }

        /* ══ MESSAGE ══ */
        .login-message {
            text-align: center;
            margin-top: .9rem;
            font-size: .88rem;
            font-weight: 500;
            min-height: 1.2rem;
        }
        .login-message.success { color: #2e7d32; }
        .login-message.error   { color: #c62828; }

        /* ══ DIVIDER ══ */
        .divider {
            display: flex;
            align-items: center;
            gap: .8rem;
            margin: 1.4rem 0;
            color: #ccc;
            font-size: .8rem;
        }
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: rgba(59,31,10,.1);
        }

        /* ══ FOOTER LINKS ══ */
        .card-footer {
            text-align: center;
            font-size: .88rem;
            color: #888;
        }
        .card-footer a {
            color: var(--gold-dk);
            font-weight: 600;
            text-decoration: none;
        }
        .card-footer a:hover { text-decoration: underline; }

        /* ══ BACK LINK ══ */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: .4rem;
            margin-top: 1.6rem;
            color: rgba(255,255,255,.75);
            font-size: .88rem;
            text-decoration: none;
            transition: color .2s;
        }
        .back-link:hover { color: var(--gold); }

        .page-wrap {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem 1rem;
            width: 100%;
        }

        @media (max-width: 480px) {
            .login-card { border-radius: 16px; }
            .card-header { padding: 2rem 1.5rem 1.5rem; }
            .card-body { padding: 1.5rem; }
        }
    </style>
</head>

<body>

<div class="page-wrap">

    <div class="login-card">

        <!-- HEADER -->
        <div class="card-header">
            <div class="logo-circle">
                <i class="fas fa-utensils"></i>
            </div>
            <h1>Welcome Back</h1>
            <p>Sign in to your Golden Reech account</p>
        </div>

        <!-- BODY -->
        <div class="card-body">

            <form id="loginForm" onsubmit="handleLogin(event)">

                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <div class="input-wrap">
                        <i class="fas fa-envelope icon"></i>
                        <input type="email" id="email" class="form-control"
                               placeholder="Enter your email" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <div class="input-wrap">
                        <i class="fas fa-lock icon"></i>
                        <input type="password" id="password" class="form-control"
                               placeholder="Enter your password" required>
                        <button type="button" class="toggle-pw" onclick="togglePassword(this)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-login" id="loginBtn">
                    <i class="fas fa-sign-in-alt"></i> Sign In
                </button>

                <p class="login-message" id="loginMessage"></p>

            </form>

            <div class="divider">or</div>

            <div class="card-footer">
                <p>Don't have an account? <a href="register.jsp">Create one</a></p>
            </div>

        </div>

    </div>

    <a href="home.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>

</div>

<script>
    const API_BASE = "http://localhost:8080/api";

    async function handleLogin(event) {
        event.preventDefault();

        const message  = document.getElementById("loginMessage");
        const btn      = document.getElementById("loginBtn");
        const email    = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        if (!email || !password) {
            showMsg("Please enter email and password.", "error");
            return;
        }

        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing in...';

        try {
            const response = await fetch(`${API_BASE}/auth/login`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ email, password })
            });

            const data = await response.json();

            if (data.status === "success") {
                showMsg("Login successful. Redirecting...", "success");

                setTimeout(() => {
                    if (data.role === "ADMIN") {
                        localStorage.setItem("admin", JSON.stringify(data.admin));
                        window.location.href = "admin-dashboard.jsp";
                    } else {
                        localStorage.setItem("customer", JSON.stringify(data.customer));
                        window.location.href = "home.jsp";
                    }
                }, 1000);

            } else {
                showMsg(data.message || "Invalid credentials.", "error");
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
            }

        } catch (error) {
            showMsg("Server error. Make sure Spring Boot is running.", "error");
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
        }
    }

    function showMsg(text, type) {
        const el = document.getElementById("loginMessage");
        el.textContent = text;
        el.className = "login-message " + type;
    }

    function togglePassword(btn) {
        const input = btn.parentElement.querySelector("input");
        const icon  = btn.querySelector("i");
        const isHidden = input.type === "password";
        input.type = isHidden ? "text" : "password";
        icon.classList.toggle("fa-eye",       !isHidden);
        icon.classList.toggle("fa-eye-slash",  isHidden);
    }
</script>

</body>
</html>