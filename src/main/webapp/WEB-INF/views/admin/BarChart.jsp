<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:url value="${pageContext.request.contextPath}" var="base" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="ISO-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
<title>Thống kê doanh thu</title>
</head>
<body>
    <div class="wrapper">
            <!-- header -->
            <jsp:include page="/WEB-INF/views/admin/common/Header.jsp"></jsp:include>
            <!-- /header -->
            <div class="content" style="display: flex;">
                    <!-- menu -->
                    <jsp:include page="/WEB-INF/views/admin/common/Menu.jsp"></jsp:include>
                    <!-- /menu -->
                    <div class="content">
                            <div class="quantity" style="width: 1100px; line-height:50px; margin:auto; border:1px solid red;margin-top:20px;margin-bottom:20px; display: flex; text-align: center;border-radius: 5px; background: #ffffff;">
                                    <div style="width: 550px; border-right:1px solid red; font-size:18px; color:red;">
                                            <span>Số lượng sp đã bán trong năm:</span>
                                            <span>${quantity }</span>
                                    </div>
                                    <div style="width: 550px;font-size:18px;color:red;">
                                            <span>Tổng doanh thu trong năm:</span>
                                            <span>${sum }</span>
                                    </div>
                            </div>
                            <div class="quantity" style="width: 1100px; line-height:50px; margin:auto; border:1px solid black;margin-top:20px;margin-bottom:20px; display: flex; text-align: center;border-radius: 5px; background: #ffffff;">
                                    <div style="width: 550px; border-right:1px solid black; font-size:18px; color:blue;">
                                        <div><b><u>TOP 5 khách hàng mua nhiều nhất:</u></b></div>
                                        <div>User: ${userID_0} - Total: ${total_0} - Số lần mua: ${count_0}</div>
                                        <div>User: ${userID_1} - Total: ${total_1} - Số lần mua: ${count_1}</div>
                                        <div>User: ${userID_2} - Total: ${total_2} - Số lần mua: ${count_2}</div>
                                        <div>User: ${userID_3} - Total: ${total_3} - Số lần mua: ${count_3}</div>
                                        <div>User: ${userID_4} - Total: ${total_4} - Số lần mua: ${count_4}</div>
                                    </div>
                                    <div style="width: 550px;font-size:18px;color:blue;">
                                        <div><b><u>TOP 5 nhân viên bán hàng xuất sắc nhất:</u></b></div>
                                        <div>ID Nhân viên: ${idnv_0} - Số hóa đơn bán được: ${counthd_0}</div>
                                        <div>ID Nhân viên: ${idnv_1} - Số hóa đơn bán được: ${counthd_1}</div>
                                        <div>ID Nhân viên: ${idnv_2} - Số hóa đơn bán được: ${counthd_2}</div>
                                        <div>ID Nhân viên: ${idnv_3} - Số hóa đơn bán được: ${counthd_3}</div>
                                        <div>ID Nhân viên: ${idnv_4} - Số hóa đơn bán được: ${counthd_4}</div>
                                    </div>
                            </div>
                            <div class="container">
                                <h3><b>Thống kế doanh thu từng tháng trong năm ${selected_year}</b></h3>
                                <form id="years" method="post" action="/admin/choose-year"
                                    enctype="multipart/form-data">
                                    <input style="width:100px" value="${selected_year}" onchange="submitFormYear()" name="yearSelect" type="number" placeholder="Choose year" min="1999" max="2023">
                                </form>
                                <div id="container"
                                        style="width: 1200px; height: 600px; margin: 0 auto"></div>
                                <div style="height:20px"></div>
                                <h3><b>Thống kế doanh thu các ngày trong tuần (${start} - ${end})</b></h3>
                                <form id="weeks" method="post" action="/admin/choose-week"
                                    enctype="multipart/form-data">
                                    <select name="mySelect" onchange="submitForm()">
                                        <option selected value="">Choose Week</option>
                                        <option value="${startOfWeek}">${startOfWeek} - ${endOfWeek}</option>
                                        <option value="${startOfWeek.minusDays(7)}">${startOfWeek.minusDays(7)} - ${endOfWeek.minusDays(7)}</option>
                                        <option value="${startOfWeek.minusDays(14)}">${startOfWeek.minusDays(14)} - ${endOfWeek.minusDays(14)}</option>
                                        <option value="${startOfWeek.minusDays(21)}">${startOfWeek.minusDays(21)} - ${endOfWeek.minusDays(21)}</option>
                                        <option value="${startOfWeek.minusDays(28)}">${startOfWeek.minusDays(28)} - ${endOfWeek.minusDays(28)}</option>
                                        <option value="${startOfWeek.minusDays(35)}">${startOfWeek.minusDays(35)} - ${endOfWeek.minusDays(35)}</option>
                                        <option value="${startOfWeek.minusDays(42)}">${startOfWeek.minusDays(42)} - ${endOfWeek.minusDays(42)}</option>
                                        <option value="${startOfWeek.minusDays(49)}">${startOfWeek.minusDays(49)} - ${endOfWeek.minusDays(49)}</option>
                                        <option value="${startOfWeek.minusDays(56)}">${startOfWeek.minusDays(56)} - ${endOfWeek.minusDays(56)}</option>
                                    </select>
                                </form>
                                <div id="container_2"
                                        style="width: 1200px; height: 600px; margin: 0 auto"></div>
                            </div>

                    </div>
            </div>
    </div>

    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script type="text/javascript">
        document.querySelector("input[type=number]")
        .oninput = e => console.log(new Date(e.target.valueAsNumber, 0, 1));
        var categorie = ${saleOrder.keySet()}; 
        var data1 = ${saleOrder.values()};
        var categorie2 = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]; 
        var data2 = ${saleOrder_2.values()};
        function submitForm(){
            document.getElementById("weeks").submit();
        }
        function submitFormYear(){
            document.getElementById("years").submit();
        }
        $(function(){

            Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: ''
                },

                xAxis: {
                    categories: categorie,
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    max:100000000,
                    title: {
                        text: 'VND'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f} K</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0
                    }
                },
                series: [{
                    name: 'Tháng',
                    data: data1
                }]

            });

            Highcharts.chart('container_2', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: ''
                },

                xAxis: {
                    categories: categorie2,
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    max:100000000,
                    title: {
                        text: 'VND'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f} K</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0
                    }
                },
                series: [{
                    name: 'Thứ',
                    data: data2
                }]

            });

        });
    </script>
    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>

</body>
</html>
