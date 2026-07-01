<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Golden Reech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
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
        .btn-primary { background: var(--gold); color: var(--white); }
        .btn-primary:hover { background: var(--gold-dk); transform: translateY(-1px); box-shadow: 0 6px 20px rgba(244,166,35,.35); }

        /* ══ PAGE BANNER ══ */
        .page-banner {
            margin-top: 70px;
            background: linear-gradient(135deg, var(--brown) 0%, #6B3A1F 100%);
            padding: 4rem 2rem;
            text-align: center;
            color: var(--white);
        }
        .page-banner h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2rem, 4vw, 3rem);
            font-weight: 900;
            margin-bottom: .5rem;
        }
        .page-banner h1 span { color: var(--gold); }
        .page-banner p { font-size: 1rem; opacity: .75; }

        .container { max-width: 1200px; margin: 0 auto; padding: 0 2rem; }
        .section { padding: 60px 0; }

        /* ══ LAYOUT ══ */
        .payment-page-layout {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 28px;
            align-items: start;
        }
        @media (max-width: 960px) { .payment-page-layout { grid-template-columns: 1fr; } }

        /* ══ CARDS ══ */
        .pay-card, .summary-card {
            background: var(--white);
            border-radius: 18px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(59,31,10,.08);
        }
        .summary-card { position: sticky; top: 90px; }

        .pay-card h2, .summary-card h3 {
            font-family: 'Playfair Display', serif;
            color: var(--brown);
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1.4rem;
        }
        .pay-card h2 { font-size: 1.3rem; font-weight: 700; }
        .summary-card h3 { font-size: 1.1rem; font-weight: 700; }
        .pay-card h2 i, .summary-card h3 i { color: var(--gold); }

        /* ══ FORM ══ */
        .form-group { margin-bottom: 1rem; }
        .form-label { display: block; font-size: .85rem; font-weight: 600; color: #666; margin-bottom: 6px; }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid rgba(59,31,10,.12);
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: .93rem;
            color: var(--brown);
            background: #fafafa;
            transition: border-color .2s, box-shadow .2s;
            outline: none;
        }
        .form-control:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(244,166,35,.12);
            background: var(--white);
        }
        .form-control[readonly] {
            background: rgba(244,166,35,.07);
            border-color: rgba(244,166,35,.35);
            color: var(--gold-dk);
            font-weight: 600;
        }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }

        .form-section-label {
            font-size: .78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .06em;
            color: #bbb;
            margin: 1.2rem 0 .7rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-section-label::after { content: ''; flex: 1; height: 1px; background: rgba(59,31,10,.08); }

        /* ══ OFFER ══ */
        .offer-row { display: flex; gap: 8px; }
        .offer-row input { flex: 1; text-transform: uppercase; }
        .btn-apply {
            padding: 10px 18px;
            background: none;
            border: 1.5px solid var(--gold);
            color: var(--gold-dk);
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: .88rem;
            font-weight: 700;
            cursor: pointer;
            white-space: nowrap;
            transition: .18s;
        }
        .btn-apply:hover { background: var(--gold); color: var(--white); }
        .offer-result { margin-top: 8px; padding: 8px 12px; border-radius: 8px; font-size: .83rem; font-weight: 600; display: none; }
        .offer-valid   { background: #e8f5e9; color: #2e7d32; display: block; }
        .offer-invalid { background: #ffebee; color: #c62828; display: block; }

        /* ══ CARD FIELDS ══ */
        .card-fields { display: none; }

        /* ══ PAY BUTTON ══ */
        .btn-pay {
            width: 100%;
            padding: 14px;
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
            gap: 9px;
            margin-top: 1.2rem;
            box-shadow: 0 4px 16px rgba(244,166,35,.28);
            transition: transform .18s, box-shadow .18s;
        }
        .btn-pay:hover { transform: translateY(-2px); box-shadow: 0 6px 22px rgba(244,166,35,.38); }
        .btn-pay:disabled { opacity: .55; cursor: not-allowed; transform: none; }

        /* ══ SUMMARY ══ */
        .summary-res-info {
            background: rgba(244,166,35,.07);
            border: 1.5px solid rgba(244,166,35,.3);
            border-radius: 10px;
            padding: 12px 14px;
            margin-bottom: 14px;
            font-size: .85rem;
            color: #555;
        }
        .summary-res-info p { margin: 0 0 4px; }
        .summary-res-info p:last-child { margin: 0; }
        .summary-res-info strong { color: var(--brown); }

        .order-item-row {
            display: flex;
            justify-content: space-between;
            font-size: .83rem;
            color: #555;
            padding: 4px 0;
            border-bottom: 1px dashed rgba(59,31,10,.08);
        }
        .order-item-row:last-child { border: none; }
        .order-items-list { margin-bottom: 14px; }

        .bill-breakdown {
            background: rgba(244,166,35,.05);
            border: 1px solid rgba(244,166,35,.2);
            border-radius: 10px;
            padding: 12px 14px;
            margin-top: 10px;
        }
        .bill-row {
            display: flex;
            justify-content: space-between;
            font-size: .85rem;
            color: #666;
            padding: 4px 0;
        }
        .bill-row.discount { color: #2e7d32; font-weight: 600; }
        .bill-row.deposit {
            padding-top: 8px;
            border-top: 1px solid rgba(59,31,10,.1);
            margin-top: 4px;
            font-weight: 700;
            font-size: 1rem;
            color: var(--gold-dk);
        }

        /* ══ NO PAYMENT BOX ══ */
        .no-payment-box {
            display: none;
            text-align: center;
            padding: 4rem 1rem;
            color: #bbb;
        }
        .no-payment-box i { font-size: 3rem; display: block; margin-bottom: 1rem; color: var(--gold); }
        .no-payment-box h3 { font-size: 1.1rem; color: #aaa; margin-bottom: .5rem; }
        .no-payment-box p { font-size: .88rem; color: #bbb; margin-bottom: 1.2rem; }

        /* ══ SUCCESS OVERLAY ══ */
        .success-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.55);
            z-index: 200;
            align-items: center;
            justify-content: center;
        }
        .success-overlay.show { display: flex; }
        .success-box {
            background: var(--white);
            border-radius: 24px;
            padding: 3rem 2rem;
            text-align: center;
            max-width: 420px;
            width: 90%;
            box-shadow: 0 16px 50px rgba(0,0,0,.25);
            animation: popIn .4s ease both;
        }
        @keyframes popIn {
            from { opacity: 0; transform: scale(.9); }
            to   { opacity: 1; transform: scale(1); }
        }
        .success-box .big-icon { font-size: 4rem; color: #2e7d32; display: block; margin-bottom: 1rem; }
        .success-box h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.6rem;
            font-weight: 900;
            color: var(--brown);
            margin-bottom: .5rem;
        }
        .success-box p { font-size: .9rem; color: #666; margin-bottom: 1.5rem; line-height: 1.6; }
        .btn-go {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 28px;
            background: linear-gradient(135deg, var(--gold), var(--gold-dk));
            color: var(--white);
            border: none;
            border-radius: 12px;
            font-family: 'DM Sans', sans-serif;
            font-size: .95rem;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 4px 16px rgba(244,166,35,.3);
            transition: transform .2s;
        }
        .btn-go:hover { transform: translateY(-2px); }

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

        @media (max-width: 900px) { .footer-content { grid-template-columns: 1fr 1fr; } }
        @media (max-width: 620px) {
            .nav-menu { display: none; }
            .form-row { grid-template-columns: 1fr; }
            .footer-content { grid-template-columns: 1fr; gap: 2rem; }
        }
    </style>
</head>

<body>

<!-- ══ NAVBAR ══ -->
<nav class="customer-navbar">
    <div class="navbar-container">
        <a href="home.jsp" class="logo">
            <i class="fas fa-utensils"></i>
            <span>Golden Reech</span>
        </a>
        <ul class="nav-menu">
            <li><a href="home.jsp"        class="nav-link">Home</a></li>
            <li><a href="menu.jsp"        class="nav-link">Menu</a></li>
            <li><a href="offers.jsp"      class="nav-link">Offers</a></li>
            <li><a href="reservation.jsp" class="nav-link">Book a Table</a></li>
            <li><a href="reviews.jsp"     class="nav-link">Reviews</a></li>
        </ul>
        <div class="nav-actions" id="navActions">
            <a href="customer-dashboard.jsp" class="btn btn-outline btn-sm">
                <i class="fas fa-user"></i> Dashboard
            </a>
            <button class="btn btn-primary btn-sm" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>
</nav>

<!-- ══ PAGE BANNER ══ -->
<section class="page-banner">
    <div class="container">
        <h1>Secure <span>Payment</span></h1>
        <p>Pay your 30% deposit to confirm your reservation</p>
    </div>
</section>

<!-- ══ MAIN SECTION ══ -->
<section class="section">
    <div class="container">

        <div class="no-payment-box" id="noPaymentBox">
            <i class="fas fa-receipt"></i>
            <h3>No Pending Payment</h3>
            <p>You don't have a pending payment. Please book a reservation first.</p>
            <a href="reservation.jsp" class="btn btn-primary" style="display:inline-flex;align-items:center;gap:8px;">
                <i class="fas fa-calendar-check"></i> Book a Table
            </a>
        </div>

        <div class="payment-page-layout" id="mainPaymentLayout" style="display:none;">

            <!-- LEFT — FORM -->
            <div class="pay-card">
                <h2><i class="fas fa-credit-card"></i> Complete Your Payment</h2>

                <p class="form-section-label">Customer Info</p>
                <div class="form-group">
                    <label class="form-label">Name</label>
                    <input type="text" id="payCustomerName" class="form-control" readonly>
                </div>
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" id="payCustomerEmail" class="form-control" readonly>
                </div>

                <p class="form-section-label">Offer Code</p>
                <div class="form-group">
                    <div class="offer-row">
                        <input type="text" id="offerCodeInput" class="form-control" placeholder="Enter offer code e.g. SAVE10">
                        <button class="btn-apply" onclick="applyOfferCode()">Apply</button>
                    </div>
                    <div class="offer-result" id="offerResult"></div>
                </div>

                <p class="form-section-label">Payment Method</p>
                <div class="form-group">
                    <select id="paymentMethod" class="form-control" onchange="toggleCardFields()">
                        <option value="">-- Select Method --</option>
                        <option value="CARD">Credit / Debit Card</option>
                        <option value="CASH">Cash</option>
                        <option value="ONLINE">Online Transfer</option>
                    </select>
                </div>

                <div class="card-fields" id="cardFields">
                    <div class="form-group">
                        <label class="form-label">Card Number</label>
                        <input type="text" id="cardNumber" class="form-control"
                               placeholder="1234 5678 9012 3456" maxlength="19" oninput="formatCard(this)">
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Expiry (MM/YY)</label>
                            <input type="text" id="cardExpiry" class="form-control" placeholder="MM/YY" maxlength="5">
                        </div>
                        <div class="form-group">
                            <label class="form-label">CVV</label>
                            <input type="password" id="cardCvv" class="form-control" placeholder="***" maxlength="3">
                        </div>
                    </div>
                </div>

                <p class="form-section-label">Amount Due</p>
                <div class="form-group">
                    <label class="form-label">Deposit to Pay (30%)</label>
                    <input type="text" id="depositDisplay" class="form-control" readonly>
                </div>

                <button class="btn-pay" id="payBtn" onclick="submitPayment()">
                    <i class="fas fa-lock"></i> Pay Deposit &amp; Confirm Reservation
                </button>
            </div>

            <!-- RIGHT — SUMMARY -->
            <div class="summary-card">
                <h3><i class="fas fa-receipt"></i> Order Summary</h3>

                <div class="summary-res-info" id="reservationInfo">
                    <p><strong>Reservation</strong> <span id="sumResId">-</span></p>
                    <p><strong>Name:</strong> <span id="sumName">-</span></p>
                    <p><strong>Email:</strong> <span id="sumEmail">-</span></p>
                </div>

                <div class="order-items-list" id="orderItemsList"></div>

                <div class="bill-breakdown" id="billBreakdown">
                    <div class="bill-row">
                        <span>Menu Total</span>
                        <span id="billTotal">Rs. 0.00</span>
                    </div>
                    <div class="bill-row discount" id="billDiscountRow" style="display:none;">
                        <span>Discount (<span id="discPct">0</span>%)</span>
                        <span id="billDiscount">-Rs. 0.00</span>
                    </div>
                    <div class="bill-row">
                        <span>After Discount</span>
                        <span id="billAfterDiscount">Rs. 0.00</span>
                    </div>
                    <div class="bill-row deposit">
                        <span>Deposit (30%)</span>
                        <span id="billDeposit">Rs. 0.00</span>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- ══ SUCCESS OVERLAY ══ -->
<div class="success-overlay" id="successOverlay">
    <div class="success-box">
        <i class="fas fa-circle-check big-icon"></i>
        <h2>Payment Successful!</h2>
        <p id="successMsg">Your deposit has been received and your reservation is confirmed.</p>
        <a href="my-reservations.jsp" class="btn-go">
            <i class="fas fa-calendar-check"></i> View My Reservations
        </a>
    </div>
</div>

<!-- ══ FOOTER ══ -->
<footer class="customer-footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>About Us</h3>
            <p>Golden Reech is a modern restaurant offering delicious meals, excellent customer service, and a relaxing dining experience.</p>
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
                <li><i class="fas fa-phone"></i> +94 77 568 4650</li>
                <li><i class="fas fa-phone"></i> +94 75 457 6071</li>
                <li><i class="fas fa-envelope"></i> info@goldenreech.com</li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 Golden Reech. All rights reserved.</p>
    </div>
</footer>

<script>
    var API_BASE = "http://localhost:8080/api";
    var pendingPayment  = null;
    var discountPercent = 0;
    var discountAmt     = 0;
    var finalDeposit    = 0;

    document.addEventListener("DOMContentLoaded", function() {
        var raw = sessionStorage.getItem("pendingPayment");
        if (!raw) {
            document.getElementById("noPaymentBox").style.display = "block";
            return;
        }
        try { pendingPayment = JSON.parse(raw); }
        catch (e) { document.getElementById("noPaymentBox").style.display = "block"; return; }

        document.getElementById("mainPaymentLayout").style.display = "grid";
        initPaymentPage();

        var autoCode = sessionStorage.getItem("autoOfferCode");
        if (autoCode) {
            document.getElementById("offerCodeInput").value = autoCode;
            sessionStorage.removeItem("autoOfferCode");
            applyOfferCode();
        }
    });

    function initPaymentPage() {
        document.getElementById("payCustomerName").value  = pendingPayment.customerName  || "";
        document.getElementById("payCustomerEmail").value = pendingPayment.customerEmail || "";
        document.getElementById("sumResId").textContent   = "#" + (pendingPayment.reservationId || "-");
        document.getElementById("sumName").textContent    = pendingPayment.customerName  || "-";
        document.getElementById("sumEmail").textContent   = pendingPayment.customerEmail || "-";

        var items = pendingPayment.orderedItems || [];
        var html  = "";
        for (var i = 0; i < items.length; i++) {
            var it  = items[i];
            var sub = (it.price || 0) * (it.quantity || 1);
            html += '<div class="order-item-row"><span>' + (it.name || "Item") + ' x' + (it.quantity || 1) + '</span><span>Rs. ' + sub.toFixed(2) + '</span></div>';
        }
        document.getElementById("orderItemsList").innerHTML = html;
        recalcBill();
    }

    function recalcBill() {
        var total       = pendingPayment.fullMenuTotal || 0;
        discountAmt     = total * (discountPercent / 100);
        var afterDisc   = total - discountAmt;
        finalDeposit    = afterDisc * 0.30;

        document.getElementById("billTotal").textContent        = "Rs. " + total.toFixed(2);
        document.getElementById("billAfterDiscount").textContent = "Rs. " + afterDisc.toFixed(2);
        document.getElementById("billDeposit").textContent      = "Rs. " + finalDeposit.toFixed(2);
        document.getElementById("depositDisplay").value         = "Rs. " + finalDeposit.toFixed(2);

        if (discountPercent > 0) {
            document.getElementById("billDiscountRow").style.display = "flex";
            document.getElementById("discPct").textContent     = discountPercent;
            document.getElementById("billDiscount").textContent = "-Rs. " + discountAmt.toFixed(2);
        } else {
            document.getElementById("billDiscountRow").style.display = "none";
        }
    }

    function applyOfferCode() {
        var code = document.getElementById("offerCodeInput").value.trim().toUpperCase();
        var el   = document.getElementById("offerResult");
        if (!code) { el.className = "offer-result offer-invalid"; el.textContent = "Please enter an offer code."; return; }

        fetch(API_BASE + "/offers/validate", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ code: code })
        })
            .then(function(r) { if (!r.ok) throw new Error(); return r.json(); })
            .then(function(data) {
                if (data.valid) {
                    discountPercent = Number(data.discountPercent || 0);
                    el.className    = "offer-result offer-valid";
                    el.textContent  = "Code applied! " + (data.description || "") + " (" + discountPercent + "% off)";
                } else {
                    discountPercent = 0;
                    el.className    = "offer-result offer-invalid";
                    el.textContent  = "Invalid or expired offer code.";
                }
                recalcBill();
            })
            .catch(function() {
                discountPercent = 0;
                el.className    = "offer-result offer-invalid";
                el.textContent  = "Could not validate code. Try again.";
                recalcBill();
            });
    }

    function toggleCardFields() {
        var method = document.getElementById("paymentMethod").value;
        document.getElementById("cardFields").style.display = method === "CARD" ? "block" : "none";
    }

    function formatCard(input) {
        var v = input.value.replace(/\D/g, "").substring(0, 16);
        var out = "";
        for (var i = 0; i < v.length; i++) { if (i > 0 && i % 4 === 0) out += " "; out += v[i]; }
        input.value = out;
    }

    function submitPayment() {
        var method = document.getElementById("paymentMethod").value;
        if (!method) { alert("Please select a payment method."); return; }
        if (method === "CARD") {
            var card = document.getElementById("cardNumber").value.replace(/\s/g, "");
            if (card.length !== 16) { alert("Please enter a valid 16-digit card number."); return; }
            if (!document.getElementById("cardExpiry").value.trim() || !document.getElementById("cardCvv").value.trim()) {
                alert("Please enter card expiry and CVV."); return;
            }
        }

        var btn = document.getElementById("payBtn");
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';

        var offerCode    = document.getElementById("offerCodeInput").value.trim().toUpperCase();
        var cardNum      = method === "CARD" ? document.getElementById("cardNumber").value.replace(/\s/g, "") : "";
        var afterDiscount = (pendingPayment.fullMenuTotal || 0) - discountAmt;

        fetch(API_BASE + "/payments/process", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                customerName:  pendingPayment.customerName,
                customerEmail: pendingPayment.customerEmail,
                amount:        afterDiscount,
                paymentMethod: method,
                cardNumber:    cardNum,
                offerCode:     offerCode
            })
        })
            .then(function(r) { if (!r.ok) throw new Error(); return r.json(); })
            .then(function(paymentData) {
                var resId = pendingPayment.reservationId;
                if (resId) {
                    return fetch(API_BASE + "/reservations/" + resId + "/status?status=CONFIRMED", { method: "PUT" })
                        .then(function() { return paymentData; })
                        .catch(function() { return paymentData; });
                }
                return paymentData;
            })
            .then(function() {
                sessionStorage.removeItem("pendingPayment");
                document.getElementById("successMsg").textContent =
                    "Deposit of Rs. " + finalDeposit.toFixed(2) +
                    " paid for Reservation #" + (pendingPayment.reservationId || "-") +
                    ". Your table is confirmed!";
                document.getElementById("successOverlay").classList.add("show");
            })
            .catch(function() {
                alert("Payment failed. Please try again.");
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-lock"></i> Pay Deposit &amp; Confirm Reservation';
            });
    }

    function logout() { localStorage.removeItem("customer"); window.location.href = "home.jsp"; }
</script>

</body>
</html>