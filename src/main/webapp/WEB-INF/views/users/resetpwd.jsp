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
                        <div class="title">
                            <span style="font-size: 25px; margin-left: 50px;">Đăng nhập
                                ngay!</span> <span style="margin-left: 300px;">Thành viên mới?<a
                                    href="${base }/signup"> Đăng ký </a> tại đây
                        </span>
                    </div>
                    <div class="content">
                        <form method="POST" action="/resetpwd" class="form-signin">
                            <label>email</label>
                            <input id="email" name="email" type="email" value="" />
                            <button type="submit" onclick="">reset</button>
                        </form>
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