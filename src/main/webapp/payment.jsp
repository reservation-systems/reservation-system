<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Golden Reech</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/customer.css">
    <link rel="stylesheet" href="./css/responsive.css">

    <style>
        .payment-page-layout {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 28px;
            align-items: start;
        }

        @media (max-width: 960px) {
            .payment-page-layout { grid-template-columns: 1fr; }
        }

        .pay-card {
            background: #fff;
            border-radius: 18px;
            padding: 2rem;
            box-shadow: 0 2px 20px rgba(0,0,0,0.07);
        }

        .pay-card h2 {
            font-size: 1.3rem;
            font-weight: 700;
            color: #1A0A00;
            margin: 0 0 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .pay-card h2 i { color: #F4A100; }

        .form-group { margin-bottom: 1rem; }

        .form-label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #555;
            margin-bottom: 6px;
        }

        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #e8e8e8;
            border-radius: 10px;
            font-size: 0.93rem;
            color: #1A0A00;
            background: #fafafa;
            transition: border-color 0.2s;
            box-sizing: border-box;
            outline: none;
        }

        .form-control:focus {
            border-color: #F4A100;
            box-shadow: 0 0 0 3px rgba(244,161,0,0.12);
            background: #fff;
        }

        .form-control[readonly] {
            background: #FFF3DC;
            border-color: #FFD060;
            color: #F4A100;
            font-weight: 600;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        .form-section-label {
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #bbb;
            margin: 1.2rem 0 0.7rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-section-label::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #f0f0f0;
        }

        .offer-row {
            display: flex;
            gap: 8px;
        }

        .offer-row input { flex: 1; text-transform: uppercase; }

        .btn-apply {
            padding: 10px 18px;
            background: none;
            border: 1.5px solid #F4A100;
            color: #F4A100;
            border-radius: 10px;
            font-size: 0.88rem;
            font-weight: 700;
            cursor: pointer;
            white-space: nowrap;
            transition: 0.18s;
        }

        .btn-apply:hover {
            background: #F4A100;
            color: #fff;
        }

        .offer-result {
            margin-top: 8px;
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 0.83rem;
            font-weight: 600;
            display: none;
        }

        .offer-valid   { background: #e8f5e9; color: #2e7d32; display: block; }
        .offer-invalid { background: #ffebee; color: #c62828; display: block; }

        .card-fields { display: none; }

        .btn-pay {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #F4A100, #C97D00);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            margin-top: 1.2rem;
            box-shadow: 0 4px 16px rgba(244,161,0,0.28);
            transition: transform 0.18s, box-shadow 0.18s;
        }

        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 22px rgba(244,161,0,0.38);
        }

        .btn-pay:disabled {
            opacity: 0.55;
            cursor: not-allowed;
            transform: none;
        }

        .summary-card {
            background: #fff;
            border-radius: 18px;
            padding: 1.6rem;
            box-shadow: 0 2px 20px rgba(0,0,0,0.07);
            position: sticky;
            top: 20px;
        }

        .summary-card h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1A0A00;
            margin: 0 0 1.2rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .summary-card h3 i { color: #F4A100; }

        .summary-res-info {
            background: #FFF3DC;
            border: 1.5px solid #FFD060;
            border-radius: 10px;
            padding: 12px 14px;
            margin-bottom: 14px;
            font-size: 0.85rem;
            color: #555;
        }

        .summary-res-info p { margin: 0 0 4px; }
        .summary-res-info p:last-child { margin: 0; }
        .summary-res-info strong { color: #1A0A00; }

        .order-items-list {
            margin-bottom: 14px;
        }

        .order-item-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.83rem;
            color: #555;
            padding: 4px 0;
            border-bottom: 1px dashed #f0f0f0;
        }

        .order-item-row:last-child { border: none; }

        .bill-breakdown {
            background: #f9f9f9;
            border-radius: 10px;
            padding: 12px 14px;
            margin-top: 10px;
        }

        .bill-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.85rem;
            color: #666;
            padding: 4px 0;
        }

        .bill-row.discount { color: #2e7d32; font-weight: 600; }

        .bill-row.deposit {
            padding-top: 8px;
            border-top: 1px solid #e0e0e0;
            margin-top: 4px;
            font-weight: 700;
            font-size: 1rem;
            color: #F4A100;
        }

        .success-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 200;
            align-items: center;
            justify-content: center;
        }

        .success-overlay.show { display: flex; }

        .success-box {
            background: #fff;
            border-radius: 20px;
            padding: 3rem 2rem;
            text-align: center;
            max-width: 420px;
            width: 90%;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        .success-box .big-icon {
            font-size: 4rem;
            color: #28a745;
            display: block;
            margin-bottom: 1rem;
        }

        .success-box h2 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1A0A00;
            margin: 0 0 0.5rem;
        }

        .success-box p {
            font-size: 0.9rem;
            color: #666;
            margin: 0 0 1.5rem;
            line-height: 1.6;
        }

        .success-box .btn-go {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 28px;
            background: linear-gradient(135deg, #F4A100, #C97D00);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 4px 16px rgba(244,161,0,0.3);
        }

        .no-payment-box {
            display: none;
            text-align: center;
            padding: 3rem 1rem;
            color: #bbb;
        }

        .no-payment-box i {
            font-size: 3rem;
            display: block;
            margin-bottom: 1rem;
            color: #FFD060;
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
            <a href="customer-dashboard.jsp" class="btn btn-outline btn-sm">
                <i class="fas fa-user"></i> Dashboard
            </a>
            <button class="btn btn-primary btn-sm" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>
</nav>

<section class="page-banner">
    <div class="container">
        <h1>Secure Payment</h1>
        <p>Pay your 30% deposit to confirm your reservation</p>
    </div>
</section>

<section class="section">
    <div class="container">

        <div class="no-payment-box" id="noPaymentBox">
            <i class="fas fa-receipt"></i>
            <h3 style="font-size:1.1rem;color:#aaa;margin:0 0 0.5rem;">No Pending Payment</h3>
            <p style="font-size:0.88rem;color:#bbb;">
                You don't have a pending payment. Please book a reservation first.
            </p>
            <a href="reservation.jsp" class="btn btn-primary" style="margin-top:1rem;display:inline-flex;align-items:center;gap:8px;">
                <i class="fas fa-calendar-check"></i> Book a Table
            </a>
        </div>

        <div class="payment-page-layout" id="mainPaymentLayout" style="display:none;">

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
                        <input type="text" id="offerCodeInput" class="form-control"
                               placeholder="Enter offer code e.g. SAVE10">
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
                               placeholder="1234 5678 9012 3456" maxlength="19"
                               oninput="formatCard(this)">
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Expiry (MM/YY)</label>
                            <input type="text" id="cardExpiry" class="form-control"
                                   placeholder="MM/YY" maxlength="5">
                        </div>
                        <div class="form-group">
                            <label class="form-label">CVV</label>
                            <input type="password" id="cardCvv" class="form-control"
                                   placeholder="***" maxlength="3">
                        </div>
                    </div>
                </div>

                <p class="form-section-label">Amount Due</p>

                <div class="form-group">
                    <label class="form-label">Deposit to Pay (30%)</label>
                    <input type="text" id="depositDisplay" class="form-control" readonly>
                </div>

                <button class="btn-pay" id="payBtn" onclick="submitPayment()">
                    <i class="fas fa-lock"></i>
                    Pay Deposit &amp; Confirm Reservation
                </button>

            </div>

            <div class="summary-card">

                <h3><i class="fas fa-receipt"></i> Order Summary</h3>

                <div class="summary-res-info" id="reservationInfo">
                    <p><strong>Reservation #</strong> <span id="sumResId">-</span></p>
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

<footer class="customer-footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3>About Us</h3>
            <p>Golden Reech is a modern restaurant offering delicious meals,
                excellent customer service, and a relaxing dining experience.</p>
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

    var pendingPayment = null;
    var discountPercent = 0;
    var discountAmt = 0;
    var finalDeposit = 0;

    document.addEventListener("DOMContentLoaded", function() {
        var raw = sessionStorage.getItem("pendingPayment");

        if (!raw) {
            document.getElementById("noPaymentBox").style.display = "block";
            document.getElementById("mainPaymentLayout").style.display = "none";
            return;
        }

        try {
            pendingPayment = JSON.parse(raw);
        } catch (e) {
            document.getElementById("noPaymentBox").style.display = "block";
            document.getElementById("mainPaymentLayout").style.display = "none";
            return;
        }

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
        document.getElementById("payCustomerName").value = pendingPayment.customerName || "";
        document.getElementById("payCustomerEmail").value = pendingPayment.customerEmail || "";

        document.getElementById("sumResId").textContent = "#" + (pendingPayment.reservationId || "-");
        document.getElementById("sumName").textContent = pendingPayment.customerName || "-";
        document.getElementById("sumEmail").textContent = pendingPayment.customerEmail || "-";

        var items = pendingPayment.orderedItems || [];
        var itemsHtml = "";

        for (var i = 0; i < items.length; i++) {
            var it = items[i];
            var sub = (it.price || 0) * (it.quantity || 1);

            itemsHtml +=
                '<div class="order-item-row">' +
                '<span>' + (it.name || "Item") + ' x' + (it.quantity || 1) + '</span>' +
                '<span>Rs. ' + sub.toFixed(2) + '</span>' +
                '</div>';
        }

        document.getElementById("orderItemsList").innerHTML = itemsHtml;

        recalcBill();
    }

    function recalcBill() {
        var total = pendingPayment.fullMenuTotal || 0;
        discountAmt = total * (discountPercent / 100);

        var afterDiscount = total - discountAmt;
        finalDeposit = afterDiscount * 0.30;

        document.getElementById("billTotal").textContent = "Rs. " + total.toFixed(2);
        document.getElementById("billAfterDiscount").textContent = "Rs. " + afterDiscount.toFixed(2);
        document.getElementById("billDeposit").textContent = "Rs. " + finalDeposit.toFixed(2);
        document.getElementById("depositDisplay").value = "Rs. " + finalDeposit.toFixed(2);

        if (discountPercent > 0) {
            document.getElementById("billDiscountRow").style.display = "flex";
            document.getElementById("discPct").textContent = discountPercent;
            document.getElementById("billDiscount").textContent = "-Rs. " + discountAmt.toFixed(2);
        } else {
            document.getElementById("billDiscountRow").style.display = "none";
        }
    }

    function applyOfferCode() {
        var code = document.getElementById("offerCodeInput").value.trim().toUpperCase();
        var el = document.getElementById("offerResult");

        if (!code) {
            el.className = "offer-result offer-invalid";
            el.textContent = "Please enter an offer code.";
            return;
        }

        fetch(API_BASE + "/offers/validate", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ code: code })
        })
            .then(function(r) {
                if (!r.ok) {
                    throw new Error("Offer validation failed");
                }
                return r.json();
            })
            .then(function(data) {
                if (data.valid) {
                    discountPercent = Number(data.discountPercent || 0);

                    el.className = "offer-result offer-valid";
                    el.textContent =
                        "Code applied! " +
                        (data.description || "Offer applied") +
                        " (" + discountPercent + "% off)";

                    recalcBill();
                } else {
                    discountPercent = 0;

                    el.className = "offer-result offer-invalid";
                    el.textContent = "Invalid or expired offer code.";

                    recalcBill();
                }
            })
            .catch(function(error) {
                console.error(error);

                discountPercent = 0;

                el.className = "offer-result offer-invalid";
                el.textContent = "Could not validate code. Try again.";

                recalcBill();
            });
    }

    function toggleCardFields() {
        var method = document.getElementById("paymentMethod").value;
        document.getElementById("cardFields").style.display = (method === "CARD") ? "block" : "none";
    }

    function formatCard(input) {
        var v = input.value.replace(/\D/g, "").substring(0, 16);
        var out = "";

        for (var i = 0; i < v.length; i++) {
            if (i > 0 && i % 4 === 0) {
                out += " ";
            }
            out += v[i];
        }

        input.value = out;
    }

    function submitPayment() {
        var method = document.getElementById("paymentMethod").value;

        if (!method) {
            alert("Please select a payment method.");
            return;
        }

        if (method === "CARD") {
            var card = document.getElementById("cardNumber").value.replace(/\s/g, "");

            if (card.length !== 16) {
                alert("Please enter a valid 16-digit card number.");
                return;
            }

            var expiry = document.getElementById("cardExpiry").value.trim();
            var cvv = document.getElementById("cardCvv").value.trim();

            if (!expiry || !cvv) {
                alert("Please enter card expiry and CVV.");
                return;
            }
        }

        var btn = document.getElementById("payBtn");
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';

        var offerCode = document.getElementById("offerCodeInput").value.trim().toUpperCase();

        var cardNum = "";
        if (method === "CARD") {
            cardNum = document.getElementById("cardNumber").value.replace(/\s/g, "");
        }

        var fullMenuTotal = pendingPayment.fullMenuTotal || 0;
        var afterDiscount = fullMenuTotal - discountAmt;

        var payload = {
            customerName: pendingPayment.customerName,
            customerEmail: pendingPayment.customerEmail,
            amount: afterDiscount,
            paymentMethod: method,
            cardNumber: cardNum,
            offerCode: offerCode
        };

        fetch(API_BASE + "/payments/process", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        })
            .then(function(r) {
                if (!r.ok) {
                    throw new Error("Payment failed");
                }
                return r.json();
            })
            .then(function(paymentData) {
                var resId = pendingPayment.reservationId;

                if (resId) {
                    return fetch(API_BASE + "/reservations/" + resId + "/status?status=CONFIRMED", {
                        method: "PUT"
                    })
                        .then(function() {
                            return paymentData;
                        })
                        .catch(function() {
                            return paymentData;
                        });
                }

                return paymentData;
            })
            .then(function(paymentData) {
                sessionStorage.removeItem("pendingPayment");

                document.getElementById("successMsg").textContent =
                    "Deposit of Rs. " + finalDeposit.toFixed(2) +
                    " paid for Reservation #" + (pendingPayment.reservationId || "-") +
                    ". Your table is confirmed!";

                document.getElementById("successOverlay").classList.add("show");
            })
            .catch(function(error) {
                console.error(error);

                alert("Payment failed. Please try again.");

                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-lock"></i> Pay Deposit &amp; Confirm Reservation';
            });
    }

    function logout() {
        localStorage.removeItem("customer");
        window.location.href = "home.jsp";
    }
</script>

</body>
</html>