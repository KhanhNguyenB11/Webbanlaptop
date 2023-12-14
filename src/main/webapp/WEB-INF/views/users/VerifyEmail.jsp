<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:url value="${pageContext.request.contextPath}" var="base" />

<!DOCTYPE html>
<html>
    <head>
        <title>Sign in</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" type="text/css"
              href="${base}/css/users/UserSignIn.css">
        <link href="${base}/css/users/bootstrap/css/bootstrap.min.css"
              rel="stylesheet">
        <style>

            .form-fpwd button{
                margin-top: 10px;
                width: 300px;
            }
            .form-fpwd input{
                width: 300px;
            }
            .form-fpwd{
                width: 45%;
                 display: flex;
                align-items: center;
                justify-content: center;
            }
            .my-content{
                width: 800px;
                height: 170px;
                border: 2px solid #f7bb70;
                border-radius: 5px;
                margin-top: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

        </style>
    </head>
    <body>
        <!-- wrapper -->
        <div class="wrapper">
            <!-- header -->
            <jsp:include page="/WEB-INF/views/users/common/header.jsp"></jsp:include>
                <!-- /header -->
                <!-- main -->
                <div class="main">
                    <div class="sign-in">
                        <c:if test="${not empty message}">
                                <div class="alert alert-info" role="alert">
                                    ${message}
                                </div>
                            </c:if>
                        <div class="title">
                            <span style="font-size: 25px; margin-left: 50px;">Confirm email</span>

                        </div>
                        <div class="my-content" style="flex-direction: column;font-size: 20px">
                            <div>Email xác thực thành công</div>
                            <br>
                            <div>
                            <a href="/login">Bấm vào đây để về trang đăng nhập</a>

                            </div>
                    </div>
                </div>
            </div>
            <!-- /main -->
            <!-- footer -->
            <jsp:include page="/WEB-INF/views/users/common/footer.jsp"></jsp:include>
                <!-- /footer -->
            </div>
            <!-- /wrapper -->

            <!-- js -->
            <script src="${base}/css/users/bootstrap/js/jquery-3.5.1.min.js"></script>
        <script src="${base}/css/users/bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>