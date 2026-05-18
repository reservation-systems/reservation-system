<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="2; url=home.jsp">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Golden Reech</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="./css/style.css">

    <style>
        body{
            margin:0;
            padding:0;
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
            background:linear-gradient(135deg,#111,#222);
            font-family:Arial,sans-serif;
            color:white;
            overflow:hidden;
        }

        .splash-container{
            text-align:center;
            animation:fadeIn 1.2s ease;
        }

        .logo{
            width:120px;
            height:120px;
            margin:auto;
            border-radius:50%;
            background:linear-gradient(135deg,#ff6b35,#ff8c42);
            display:flex;
            justify-content:center;
            align-items:center;
            font-size:50px;
            color:white;
            box-shadow:0 10px 30px rgba(0,0,0,0.4);
            margin-bottom:20px;
        }

        h1{
            font-size:42px;
            margin-bottom:10px;
            font-weight:700;
        }

        p{
            color:#ccc;
            font-size:18px;
        }

        .loader{
            margin:30px auto 0;
            width:50px;
            height:50px;
            border:5px solid rgba(255,255,255,0.2);
            border-top:5px solid #ff6b35;
            border-radius:50%;
            animation:spin 1s linear infinite;
        }

        @keyframes spin{
            100%{
                transform:rotate(360deg);
            }
        }

        @keyframes fadeIn{
            from{
                opacity:0;
                transform:translateY(20px);
            }
            to{
                opacity:1;
                transform:translateY(0);
            }
        }
    </style>
</head>

<body>

<div class="splash-container">

    <div class="logo">
        <i class="fas fa-utensils"></i>
    </div>

    <h1>Golden Reech</h1>

    <p>Restaurant Reservation & Management System</p>

    <div class="loader"></div>

</div>

<script>
    console.log("Restaurant System Loading...");

    setTimeout(() => {
        window.location.href = "home.jsp";
    }, 2000);
</script>

</body>
</html>