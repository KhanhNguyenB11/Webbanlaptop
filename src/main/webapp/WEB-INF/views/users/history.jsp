<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="org.springframework.security.oauth2.core.oidc.user.OidcUser" %>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:url value="${pageContext.request.contextPath}" var="base" />

<!-- SPRING FORM -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="com.devpro.entities.User"%>

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
			<div class="inner">
				<table>
					<thead>
						<tr>
							<th>Mã đơn hàng</th>
							<th>Ngày đặt</th>
							<th>Tổng tiền</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach var="saleOrder" items="${saleOrders }">
							<tr>
								<td><a href="/order/view/${saleOrder.code }">${saleOrder.code }</a></td>
								<td>${saleOrder.createdDate }</td>
								<td>${saleOrder.totalVN }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
                    <%
                                String id = " ";
                                Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication()
                                                .getPrincipal();
                                if (principal instanceof org.springframework.security.core.userdetails.UserDetails) {
                                        id = String.valueOf(((User)principal).getId());

                                }
                                else{
                                   OidcUser oidcUser = (OidcUser) principal;
                                   String email = oidcUser.getEmail();
                                   id= email;

                                    }

                                %>
                                <a class="nav-link" style="padding: 10px; color: white; border: none; border-radius: 5px; cursor: pointer;font-size: 12px;font-weight: bold; font-size: large;background-color: #b72222;text-decoration: none" href="${base}/user/<%=id%>">Thông tin tài khoản</a>
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
