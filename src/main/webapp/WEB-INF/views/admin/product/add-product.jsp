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
        <title>Tạo Sản Phẩm Mới</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <link href="${base}/css/users/bootstrap/css/bootstrap.min.css"
              rel="stylesheet">
        <script src="${base}/css/users/bootstrap/js/jquery-3.5.1.min.js"></script>
        <script src="${base}/css/users/bootstrap/js/bootstrap.min.js"></script>

        <link href="${base}/summernote/summernote.min.css" rel="stylesheet">
        <script src="${base}/summernote/summernote.min.js"></script>

        <link rel="stylesheet" type="text/css"
              href="${base}/css/admin/add-product.css">
    </head>
    <body>
        <div class="wrapper">
            <!-- header -->
            <jsp:include page="/WEB-INF/views/admin/common/Header.jsp"></jsp:include>
                <!-- /header -->
                <!-- content -->
                <div class="content">
                    <!-- menu -->
                <jsp:include page="/WEB-INF/views/admin/common/Menu.jsp"></jsp:include>
                    <!-- /menu -->
                    <!-- content-right -->
                    <div class="content-right">
                        <div class="create-product">
                            <div class="title">
                            <c:if test="${not empty action}">
                                <span>Tạo Sản Phẩm Mới</span>
                            </c:if>
                            <c:if test="${ empty action}">
                                <span>Sửa Thông Tin Sản Phẩm</span>
                            </c:if>

                        </div>
                        <div class="content-create-product">
                            <form:form method="post" action="/admin/save-product"
                                       modelAttribute="product" enctype="multipart/form-data" onsubmit="return validateForm()">

                                <form:hidden path="id" />
                                <input type="hidden" name="deletedImages" id="deletedImagesInput"/>
                                <label>Tên sản phẩm</label>
                                <br>
                                <form:input type="text" path="title" />
                                <br>
                                <label>Giá sản phẩm</label>
                                <br>
                                <form:input type="text" path="price" />
                                <br>
                                <label>CPU</label>
                                <br>
                                <form:input type="text" path="CPU" />
                                <br>
                                <label>RAM</label>
                                <br>
                                <form:input type="text" path="Ram" />
                                <br>
                                <label>Display</label>
                                <br>
                                <form:input type="text" path="Display" />
                                <br>
                                <label>Storage</label>
                                <br>
                                <form:input type="text" path="Storage" />
                                <br>
                                <label>VGA</label>
                                <br>
                                <form:input type="text" path="Vga"/>
                                <br>
                                <label>Mô tả sản phẩm(tối 3000 chữ)</label>
                                <br>
                                <form:textarea id="txtshortDescription1" path="shortDes" />
                                <br>
                                <br>
                                <label>Mô tả chi tiết</label>
                                <br>
                                <div style="width: 500px; margin-left: 250px;">
                                    <form:textarea id="txtDetailDescription" path="shortDetails" />
                                </div>
                                <div class="form-group">
                                    <label>Category</label><br>
                                    <form:select path="category.id"
                                                 style="width: 500px; height: 40px; margin-left: 250px;	border-radius: 5px; border: 1px solid #dcdbdb;">
                                        <form:options items="${categories}" itemValue="id"
                                                      itemLabel="name" style="height: 40px;" />
                                    </form:select>
                                </div>
                                <br>
                                <c:if test="${ empty action}">
                                    <label>Ảnh của sản phẩm</label>
                                    <div style="display:flex; justify-content: center; align-items: center; padding-bottom: 1rem; flex-wrap: wrap; position: relative" >
                                        <br>

                                        <c:forEach items="${product.productImages}" var="image" varStatus="loop">
                                            <div id="${image.path}">
                                                <button type="button" style="position:absolute;" id="removeImageBtn" onclick="handleDeleteImg('${image.path}')">X</button>
                                                <img src="/upload/${image.path}" height="150px" width="150px" style="margin: 15px" id="${image.path}_img">
                                            </div>
                                        </c:forEach>

                                    </div>
                                </c:if>
                                <label>Chọn ảnh mới cho sản phẩm:</label>
                                <div style="display:flex; justify-content: center; align-items: center; padding-bottom: 1rem; flex-wrap: wrap;flex-direction: column"  >
                                    <input type="file" name="images" multiple="multiple" id="imageInput"
                                           style="border: 0px solid #dcdbdb;">

                                    <div id="imagePreviewContainer" style="display:flex; justify-content: center; align-items: center; padding-bottom: 1rem; flex-wrap: wrap; position: relative">                                      

                                    </div>
                                    <button type="button" onclick="handleDeleteNewImage()" >Delete Image</button>
                                </div>
                                <br>
                                <label>Discount (%)</label>
                                <br>
                                <form:input type="number" path="discount"/>
                                <label>Status</label>
                                <form:checkbox path="status" style="margin:0px; width:15px; height:15px; margin-left:20px;"/>
                                <br>
                                <button type="submit" value="Lưu Sản Phẩm" class="btn btn-primary btn-sm"
                                        style="width:200px; line-height: 28px; margin-left: 260px; margin-bottom:50px;">Lưu</button>
                                <a href="${base }/admin/list-product"
                                   class="btn btn-primary btn-sm" style="width:200px; line-height: 28px; margin-left:20px;margin-bottom:50px;">Quay lại</a>
                            </form:form>
                        </div>
                    </div>
                </div>
                <!-- /content-right -->
            </div>
            <!-- /content -->
        </div>
        <script>
            $(document).ready(function () {
                $('#txtDetailDescription').summernote();
            });
            document.getElementById('imageInput').addEventListener('change', function (event) {
                displaySelectedImages(event.target.files);
                for (var i = 0; i < event.target.files.length; i++) {
                    console.log('File ' + (i + 1) + ':', event.target.files[i]);
                }
            });
            function handleDeleteNewImage() {
                let previewContainer = document.getElementById('imagePreviewContainer');
                const input = document.getElementById("imageInput");
                //remove selected img from DOM

                for (let i = 0; i < input.files.length; i++) {
                    previewContainer.remove(input.files[i].name);
                }
                input.value = "";
            }
            function displaySelectedImages(files) {
                let previewContainer = document.getElementById('imagePreviewContainer');
                for (var i = 0; i < files.length; i++) {
                    var file = files[i];
                    // Check if the selected file is an image
                    if (file.type.match('image.*')) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            // Create an image element and set its source to the data URL
                            var img = document.createElement('img');
                            img.src = e.target.result;
                            img.height = 150;
                            img.width = 150;
                            img.id = file.name;
                            img.style.margin = '15px';
                            // Append the image to the preview container
                            previewContainer.appendChild(img);
                        };
                        // Read the selected file as a data URL
                        reader.readAsDataURL(file);
                    }
                }
            }
            let deletedImages = [];
            function handleDeleteImg(imageId) {
                if (!deletedImages.includes(imageId))
                    deletedImages.push(imageId);
                console.log(deletedImages);
                document.getElementById(imageId).remove();
                event.stopPropagation();
            }
            function validateForm() {
                //Update the deleted img to the form
                //document.getElementById('deletedImagesInput').value = JSON.stringify(deletedImages);
                document.getElementById('deletedImagesInput').value = deletedImages;
                // Validate Tên sản phẩm
                var title = document.getElementById('title').value.trim();
                if (title === '') {
                    alert('Vui lòng nhập Tên sản phẩm');
                    return false;
                }
                // Validate Giá sản phẩm
                var price = document.getElementById('price').value.trim();
                if (price === '' || isNaN(price) || parseFloat(price) <= 0) {
                    alert('Vui lòng nhập giá hợp lệ');
                    return false;
                }
                // Validate Discount (%)
                var discount = document.getElementById('discount').value.trim();
                if (discount !== '' && (isNaN(discount) || parseFloat(discount) < 0 || parseFloat(discount) > 100)) {
                    alert('Vui lòng nhập giảm giá hợp lệ (từ 0 đến 100)');
                    return false;
                }
                return true; // Form is valid, proceed with submission
            }
        </script>
    </body>
</html>