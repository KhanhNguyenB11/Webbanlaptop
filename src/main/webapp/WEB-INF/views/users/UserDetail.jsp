<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="${pageContext.request.contextPath}" var="base" />

<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết sản phẩm</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" type="text/css"
              href="${base}/css/users/UserDetail.css">
        <link rel="stylesheet" type="text/css"
              href="${base}/css/users/responsive.css">
        <script type="text/javascript" src="${base}/js/users/jquery-3.5.1.js"></script>
        <script type="text/javascript" src="${base}/js/users/UserDetail.js"></script>
    </head>
    <body>
        <!-- wrapper -->
        <div class="wrapper">
            <!-- header -->
            <jsp:include page="/WEB-INF/views/users/common/header.jsp"></jsp:include>
                <!-- /header -->
                <!-- main -->
                <div class="main">
                    <div class="title">
                        <br> <span> ${product.title } </span>
                </div>
                <div class="main-top">
                    <div class="left">
                        <div class="slide-img">
                            <a href="#"><img
                                    src="${base}/upload/${product.productImages[0].path}"
                                    id="place-img"></a>
                        </div>

                    </div>
                    <div class="right">
                        <div class="top">
                            
                            <c:if test = "${not empty priceAfterDiscount}">
                                <br>
                                <span class="span1"> ${priceAfterDiscount} </span><br>
                                <br> <span class="span2">Giá gốc:</span>
                                <del>${product.priceVN}</del>
                            </c:if>
                            <c:if test = "${empty priceAfterDiscount}">
                                <br>
                                <br>
                                <br> Giá<span class="span1"> ${product.priceVN} </span>
                            </c:if>
                            <br> <br> <br> <span class="span3">CPU:</span><span
                                class="span4">${product.CPU}</span><br> <br>
                            <span class="span3">RAM:</span><span class="span4">${product.ram}</span><br> <br> <span class="span3">Ổ cứng:</span><span
                                class="span4">${product.storage}</span><br> <br> <span
                                class="span3">Card đồ họa:</span><span class="span4">${product.vga}</span><br> <br> <span
                                class="span3">Màn hình:</span><span class="span4">${product.display}</span><br> <br> <br> <br>
                            <span>Bảo hành chính hãng ${product.category.name} Việt Nam 12 tháng</span><br>
                            <span>Giá ở trên đã bao gồm 10% VAT</span><br> <span>MIỄN
                                PHÍ GIAO HÀNG toàn địa bàn TP.HCM</span><br>
                        </div>
                        <div class="bottom">
                            <button type="button"
                                    onclick="Shop.addItemToCart(${product.id}, 1)" style="cursor: pointer">
                                <span>THÊM VÀO GIỎ HÀNG</span>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="main-bot">
                    <div class="description">
                        <div class="title">Mô tả chi tiết sản phẩm</div>
                        <div class="content">
                            <div style="padding: 1rem ;display: flex; align-items: center">

                                <span>${product.shortDetails }</span>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- /main -->

            <!-- footer -->
            <jsp:include page="/WEB-INF/views/users/common/footer.jsp"></jsp:include>
                <!-- /footer -->
            </div>
            <!-- wrapper -->

            <!-- js  -->
            <script type="text/javascript" src="${base}/js/users/jquery-3.5.1.js"></script>
        <script type="text/javascript" src="${base}/js/users/script.js"></script>
        <script type="text/javascript" src="${base}/js/users/shop.js"></script>
    </body>
</html>