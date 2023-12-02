<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLDecoder" %>

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
        <%
        // Get the raw query string from the request
        String queryString = request.getQueryString();

        // Decode the query string to handle URL-encoded characters
        String decodedQueryString = URLDecoder.decode(queryString, "UTF-8");

        // Extract the token directly if there is only one query parameter
        String token = null;
        if (decodedQueryString.startsWith("token=")) {
            token = decodedQueryString.substring("token=".length());
        }
        %>
        <!-- wrapper -->
        <div class="wrapper">
            <!-- header -->
            <jsp:include page="/WEB-INF/views/users/common/header.jsp"></jsp:include>
                <!-- /header -->
                <!-- main -->
                <div class="main">
                    <div class="sign-in">
                        <div class="title">

                        </div>
                        <div class="my-content">
                            <form method="POST" action="/savePassword/" class="form-fpwd" id="myform">
                                <input type="hidden" name="token" value="<%= token %>" />
                            <div>
                                <label for="newp">New Password</label><br> 
                                <input type="password" name="newp"placeholder="New Password"><br> 
                                <label for="confirmpassword">Confirm Password</label><br> 
                                <input type="password" name="confirmpassword" placeholder="Confirm Password"><br> 
                                <button class="btn btn-md btn-primary btn-block" type="submit">Save</button>
                            </div>


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
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Get references to the password and confirm password input fields
                var newPasswordInput = document.querySelector('input[name="newp"]');
                var confirmPasswordInput = document.querySelector('input[name="confirmpassword"]');

                // Get reference to the form
                var form = document.getElementById("myform");

                // Add event listener to the form on submit
                form.addEventListener('submit', function (event) {
                    // Check if passwords match
                    if (newPasswordInput.value !== confirmPasswordInput.value) {
                        // Prevent the form submission if passwords don't match
                        event.preventDefault();

                        // Display an alert or handle the mismatch in your preferred way
                        alert('Passwords do not match. Please try again.');
                    }
                });
            });
        </script>
    </body>
</html>