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

<link href="${base}/css/users/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${base}/css/users/history.css" rel="stylesheet">

</head>
<body>
	<!-- wrapper -->
	<div class="wrapper">
		<!-- header -->
		<jsp:include page="/WEB-INF/views/users/common/header.jsp"></jsp:include>
		<!-- /header -->
		<!-- main -->
		<div class="main">
            <div class="mid" style="background: #d6dff3; border-radius: 5px;padding: 10px; margin-top: 10px">
				<form:form method="post" action="/saveUser"
							modelAttribute="user" enctype="multipart/form-data">
							<form:input type="hidden" class="form-control" path="id"/>
                                                        <form:input type="hidden" class="form-control" path="status"/>
                                                        <form:input type="hidden" class="form-control" path="roles"/>
					<div class="top" style="margin-top: 20px;">
						<div class="form-row">
								<div class="form-group col-md-6">
									<label>Tên đăng nhập</label>
									<form:input type="text" class="form-control" path="username"
										placeholder="why?" readonly="true"/>
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
										path="password" placeholder="Nhập mật khẩu của bạn" readonly="true"/>
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
								style="width: 200px; line-height: 28px; margin-bottom: 50px;">Lưu</button><br>
					</div>
				</form:form>
			</div>
		</div>
		<!-- /main -->
		<!-- footer -->
		<jsp:include page="/WEB-INF/views/users/common/footer.jsp"></jsp:include>
		<!-- /footer -->
	</div>
	<!-- /wrapper -->

	<!-- js  -->
	<script src="${base}/css/users/bootstrap/js/jquery-3.5.1.min.js"></script>
	<script src="${base}/css/users/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
