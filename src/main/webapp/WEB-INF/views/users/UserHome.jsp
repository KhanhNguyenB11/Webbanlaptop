<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:url value="${pageContext.request.contextPath}" var="base" />

<!-- SPRING FORM -->
<%@ taglib prefix="springform"
           uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html >
    <head>
        <title>Trang Chủ</title>
        <meta charset="utf-8">
        <meta name="viewport"
              content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="stylesheet" type="text/css"
              href="${base}/css/users/UserHome.css">
        <link rel="stylesheet" type="text/css"
              href="${base}/css/users/responsive.css">
    </head>
    <body>
        <!-- wrapper -->
        <div class="wrapper">
            <!-- header -->
            <jsp:include page="/WEB-INF/views/users/common/header.jsp"></jsp:include>
                <!-- /header -->
                <!-- main -->
                <div class="main">
                    <!-- adv -->
                    <div class="adv">
                        <div class="slide-show">
                            <a href="#"> <img id="slide-img"
                                              src="${base}/images/users/slide-show-1.jpg">
                        </a>
                        <div id="next" onclick="next();">
                            <img src="${base}/images/users/next.jpg">
                        </div>
                        <div id="prev" onclick="prev();">
                            <img src="${base}/images/users/prev.jpg">
                        </div>
                    </div>
                    <div class="info">
                        <ul>
                            <li><a href="#"><img
                                        src="${base}/images/users/slide-show-4.jpg"></a></li>
                            <li>
                                <ul>
                                    <li><a href="#">
                                            <div>
                                                <img src="${base}/images/users/adv-1.jpg">
                                            </div> <span>Laptop giá rẻ cho dân văn phòng</span>
                                        </a></li>
                                    <li><a href="#">
                                            <div>
                                                <img src="${base}/images/users/adv-1.jpg">
                                            </div> <span> Laptop giá rẻ cho dân văn phòng </span>
                                        </a></li>
                                    <li><a href="#" class="view"> Xem tất cả </a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- /adv -->
                <!-- left -->
                <div class="left">
                    <!-- menu -->
                    <jsp:include page="/WEB-INF/views/users/common/menu.jsp"></jsp:include>
                        <div class="filter">
                            <div class="title">Tìm Kiếm Sản Phẩm</div>
                            <div class="content">
                                <div style="margin-top:20px; margin-left:20px;">
                                    <button onclick="Shop.highTolow('${base}/');" >Cao đến thấp</button>
                                <button onclick="Shop.lowToHight('${base}/');" >Thấp đến cao</button>
                            </div>
                            <br> 
<!--							<a href="${base }/?price=1" onclick="">Dưới 5.000.000đ</a> <br><br>
                                    <a href="${base }/?price=2" onclick="">5.000.000đ - 10.000.000đ</a><br><br>
                                    <a href="${base }/?price=3" onclick="">10.000.000đ - 15.000.000đ</a><br><br>
                                    <a href="${base }/?price=4" onclick="">15.000.000đ - 20.000.000đ</a><br><br>
                                    <a href="${base }/?price=5" onclick="">Lớn hơn 20.000.000đ</a>-->
                            <form action="">
                                <label for="minprice">Min:</label>
                                <input type="number" name="minprice" id="minprice"><br>
                                <label for="maxprice">Max:</label>
                                <input type="number" name="maxprice" id="maxprice"><br>
                                <button>Search</button>

                            </form>
                        </div>
                    </div>
                    <!-- /menu -->
                </div>
                <!-- /left -->
                <!-- middle -->
                <div class="middle">
                    <div class="top">
                        <div class="title">
                            <div class="left">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FLASH SALE</div>
                            <div class="right"></div>
                        </div>
                        <div class="content">
                            <div id="next-2" onclick="next2();">
                                <img src="${base}/images/users/next.jpg">
                            </div>
                            <div id="prev-2" onclick="prev2();">
                                <img src="${base}/images/users/prev.jpg">
                            </div>
                            <div class="slide-flash">
                                <ul id="slide-show-2">
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-1.jpg"><br> <span>SSD
                                                2.5 Inch SanDisk X400 - 128GB - Hàng Chính Hãng</span>
                                        </a><br> <br> <span>425.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>550.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-2.jpg"><br> <span>RAM
                                                Laptop Kingmax DDR4 bus 2666MHz - 4GB - Hàng chính hãng</span>
                                        </a><br> <span>369.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>435.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-3.jpg"><br> <span>Laptop
                                                HP 15s-fq1106TU 193Q2PA - intel core i3</span>
                                        </a><br> <br> <span>9.490.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>9.890.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-4.jpg"><br> <span>Laptop
                                                Asus Pro P1440FA-FQ0934 - Intel Core</span>
                                        </a><br> <br> <span>8.490.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>8.990.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-5.jpg"><br> <span>Laptop
                                                MSI Modern 14 A10M 1028VN-Intel</span>
                                        </a><br> <br> <span>16.790.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>16.990.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-6.jpg"><br> <span>Pin
                                                tiểu AA/ AAA Tự Sạc - Đầu Micro USB</span>
                                        </a><br> <br> <span>29.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>45.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-7.jpg"><br> <span>SSD
                                                2.5 Inch SanDisk X400 - 128GB - Hàng Chính Hãng</span>
                                        </a><br> <br> <span>425.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>550.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-8.jpg"><br> <span>SSD
                                                2.5 Inch SanDisk X400 - 128GB - Hàng Chính Hãng</span>
                                        </a><br> <br> <span>425.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>550.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-9.jpg"><br> <span>SSD
                                                2.5 Inch SanDisk X400 - 128GB - Hàng Chính Hãng</span>
                                        </a><br> <br> <span>425.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>550.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                    <li><a href="#"> <img id="slide-fl"
                                                          src="${base}/images/users/sanpham-10.jpg"><br> <span>SSD
                                                2.5 Inch SanDisk X400 - 128GB - Hàng Chính Hãng</span>
                                        </a><br> <br> <span>425.000đ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<del>550.000đ</del><br>
                                        <p>Giao hàng từ Hà Nội, ship toàn quốc</p></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /middle -->
                <!-- bottom -->
                <div class="bottom">
                    <div class="title">
                        <div class="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CÁC
                            MẶT HÀNG</div>
                        <div class="right"></div>
                    </div>
                    <div class="content">
                        <ul>
                            <c:forEach var="product" items="${products }">
                                <div>
                                    <li><a href="${base}/detail-product/${product.seo }"> <c:choose>
                                                <c:when test="${empty product.productImages }">
                                                    <img class="card-img-top"
                                                         src="${base}/images/users/700x400.png" alt="">
                                                </c:when>
                                                <c:otherwise>
                                                    <img style="width: 180px;"
                                                         src="${base}/upload/${product.productImages[0].path}">

                                                </c:otherwise>
                                            </c:choose> <span>${product.title }</span></a><br> <br> <span style="padding-top: 0.3rem;padding-bottom: 0.3rem">&nbsp;&nbsp;&nbsp;${product.priceVN }&nbsp;&nbsp;&nbsp;
                                        </span>
                                        <button type="button" class="add-to-cart-btn"
                                                onclick="Shop.addItemToCart(${product.id}, 1)" style="">Thêm
                                            vào giỏ</button></li>
                                </div>
                            </c:forEach>


                        </ul>
                        <div class="pagination">
                            <ul>
                                <li><a class="page-link" href="#" id="previous"
                                       onclick="Shop.homePrevious('${base}/')"><<</a></li>
                                    <c:forEach var="numberOPs" items="${numberOP }">
                                    <li><a href="#"
                                           onclick="Shop.homePage('${base}/', '${numberOPs }')">${numberOPs }</a></li>
                                    </c:forEach>
                                <li><a class="page-link" href="#" id="next"
                                       onclick="Shop.homeNext('${base}/', '${numberOfPage }')">>></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /bottom -->

               

                <div style="clear: both;"></div>
            </div>
            <!-- main -->
            <!-- footer -->
            <jsp:include page="/WEB-INF/views/users/common/footer.jsp"></jsp:include>
                <!-- /footer -->
            </div>
            <!-- /wrapper -->

            <!-- js -->
            <script type="text/javascript" src="${base}/js/users/jquery-3.5.1.js"></script>
        <script type="text/javascript" src="${base}/js/users/script.js"></script>
        <script type="text/javascript" src="${base}/js/users/shop.js"></script>
       
    </body>
</html>