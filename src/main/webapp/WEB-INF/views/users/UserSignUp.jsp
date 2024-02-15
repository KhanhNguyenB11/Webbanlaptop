<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:url value="${pageContext.request.contextPath}" var="base" />

<!-- SPRING FORM -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>
<html>
<head>
<title>Sign Up</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css"
	href="${base}/css/users/UserSignUp.css">
<link href="${base}/css/users/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${base}/css/users/bootstrap/js/jquery-3.5.1.min.js"></script>
<script src="${base}/css/users/bootstrap/js/bootstrap.min.js"></script>
<style>
.my-content{
                 width: 100%;
                 height: 170px;
                 border: 2px solid #f7bb70;
                 border-radius: 5px;
                 margin-top: 10px;
                 display: flex;
                 align-items: center;
                 justify-content: center;
                 gap: 10px;
                 flex-direction: column;
                 font-size: 25px;
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
			<!-- top -->
			 <c:if test="${ empty confirmEmail}">
			<div class="top">
				<div class="left">
					<span>Tạo tài khoản</span>
					<c:if test="${not empty message}">
					    <p style="color: red">${message}</p>
					</c:if>
				</div>
				<div class="right">
					<span>Bạn là thành viên? <a href="${base}/login">Đăng
							nhập</a> tại đây
					</span>
				</div>
			</div>
			<!-- /top -->
			<!-- mid -->

			<div class="mid" style="background: #d6dff3; border-radius: 5px;">
				<form:form method="post" action="/save-guestUser"
							modelAttribute="user" enctype="multipart/form-data" onsubmit="return validateForm()">
					<div class="top" style="margin-top: 20px;">
						<div class="form-row">
								<div class="form-group col-md-6">
									<label>Tên đăng nhập</label>
									<form:input type="text" class="form-control" path="username"
										placeholder="Nhập tên đăng nhập của bạn" />
								</div>
								<div class="form-group col-md-6">
									<label>Họ và tên đệm</label>
									<form:input type="text" class="form-control" path="firstName"
										placeholder="Nhập họ và tên đệm của bạn" />
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-6">
									<label>Mật khẩu</label>
									<form:input type="password" class="form-control"
										path="password" placeholder="Nhập mật khẩu của bạn" />
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">Tên</label>
									<form:input type="text" class="form-control" path="name"
										placeholder="Nhập tên của bạn" />
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">Email</label>
									<form:input type="email" class="form-control" path="email"
										placeholder="nguyenvana@gmail.com" />
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">Số điện thoại</label>
									<form:input type="text" class="form-control" path="phone"
										placeholder="Nhập số điện thoại của bạn" />
								</div>
							</div>
							<div class="form-group" style="width: 772px; margin-left: 15px;">
								<label for="inputAddress">Địa chỉ</label>
								<form:input type="text" class="form-control" path="address"
									placeholder="1234 Main St" />
							</div>
							<div class="form-check" style="margin-left: 20px;">
							<label>Giới Tính</label> <br>
								<form:radiobutton path="gender" class="form-check-input"
									value="true" />
								<label class="form-check-label"> Nam </label>
								<form:radiobutton path="gender" class="form-check-input"
									value="false" />
								<label class="form-check-label"> Nữ </label>
							</div>
					</div>
					<div class="mid" style="margin-top: 10px;"></div>
					<div class="bot">

						<button type="submit" value="Lưu" class="btn btn-primary btn-sm"
								style="width: 200px; line-height: 28px; margin-left: -20px; margin-bottom: 50px;">Lưu</button><br>

						<p>
							Khi bạn nhấn Đăng ký, bạn đã đồng ý thực hiện mọi giao dịch mua
							bán theo <a href="#">điều kiện sử dụng và chính sách</a> của
							chúng tôi.
						</p>
					</div>
				</form:form>
			</div>
			</c:if>
			<c:if test="${not empty confirmEmail}">
			    <div class="main">
                                    <div class="sign-in">
                                        <c:if test="${not empty message}">
                                                <div class="alert alert-info" role="alert">
                                                    ${message}
                                                </div>
                                            </c:if>
                                        <div class="title">
                                            <span style="font-size: 25px; margin-left: 50px;">Xin vui lòng xác thực email</span>
                                        </div>
                                        <div class="my-content">
                                            <div>Một email vừa được gửi đến ${email}. Vui lòng kiểm tra Email.</div>
                                    </div>
                                </div>
                            </div>

			</c:if>
			<!-- /mid -->

		</div>
		<!-- /main -->
		<!-- footer -->
		<jsp:include page="/WEB-INF/views/users/common/footer.jsp"></jsp:include>
		<!-- /footer -->
	</div>
	<!-- /wrapper -->
	<script>
	function validateForm() {


                // Validate Tên đăng nhập
                const usernameInput = document.querySelector('[name="username"]');
                if (!usernameInput.value.trim()) {
                    alert('Tên đăng nhập không được để trống.');
                    return false;
                }

                // Validate Họ và tên đệm
                const firstNameInput = document.querySelector('[name="firstName"]');
                if (!firstNameInput.value.trim()) {
                    alert('Họ và tên đệm không được để trống.');
                    return false;

                }

                // Validate Mật khẩu
                const passwordInput = document.querySelector('[name="password"]');
                if (!passwordInput.value.trim()) {

                    alert('Mật khẩu không được để trống.');
                    return false;
                }

                // Validate Tên
                const nameInput = document.querySelector('[name="name"]');
                if (!nameInput.value.trim()) {
                    alert('Tên không được để trống.');
                    return false;
                }

                // Validate Email
                const emailInput = document.querySelector('[name="email"]');
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(emailInput.value.trim())) {
                    alert('Email không hợp lệ.');
                    return false;
                }

                // Validate Số điện thoại
                const phoneInput = document.querySelector('[name="phone"]');
                if (!phoneInput.value.trim()) {
                    alert('Số điện thoại không được để trống.');
                    return false;
                }

                return true;
            }
	</script>
</body>
</html>
