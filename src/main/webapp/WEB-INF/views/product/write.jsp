<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>write</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script>
    $(document).ready(function() {
      $("select[name='pro_code']").on("change", function() {
        var pro_code = $(this).val();
        if (pro_code) {
          $.ajax({
            url: '<c:url value="/product/getCategoryName" />',
            type: 'GET',
            data: { pro_code: pro_code },
            success: function(data) {
              $("input[name='category_name']").val(data.categoryName);
            }
          });
        }
      });
    });
  </script>
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
    <ul class="navbar-nav">    	
      <li class="nav-item">
        <a class="nav-link active" href="/product/list">상품</a>
      </li>      
      <li class="nav-item">
        <a class="nav-link active" href="/cart/list">장바구니</a>
      </li>
    </ul>
  </div>
</nav>

<div class="container text-center">
  <!-- 본문 시작 -->
  <div class="row">
    <div class="col-sm-12">
    	<p><h3>상품등록</h3></p>
    	<p>
    		<button type="button" class="btn btn-dark" onclick="location.href='list'">상품전체목록</button>
    	</p>
    </div><!-- col end -->
  </div><!-- row end -->
  <!-- 본문 끝 -->
    <div class="row">
    <div class="col-sm-12">
		<form name="productfrm" id="productfrm" method="post" action="/product/insert" enctype="multipart/form-data">
			<table class="table table-hover">
				    <tbody style="text-align: left;">
				    <tr>
		            <td>카테고리</td>
		            <td>
		              <select name="pro_code" class="form-control" required>
		                <option value="package">package</option>
		                <option value="snack">snack</option>
		                <option value="drink">drink</option>
		                <option value="ticket">ticket</option>
		              </select>
		            </td>
				    </tr>
				    <tr>
						<td>상품명</td>
						<td> <input type="text" name="pro_name" class="form-control" required> </td>
				    </tr>
				    <tr>
						<td>상품가격</td>
						<td> <input type="number" name="pro_price" class="form-control" required> </td>
				    </tr>
					<tr>
						<td>상품설명</td>
						<td> 
						    <textarea rows="5" name="pro_detail" class="form-control" required></textarea>     
						 </td>
				    </tr>
				    <tr>
						<td>상품사진</td>
						<td> <input type="file" name="img" class="form-control" required> </td>
				    </tr>
				    <tr>
						<td>재고수량</td>
						<td> <input type="number" name="pro_stock" class="form-control" required> </td>
				    </tr>
				    <tr>
						<td colspan="2" align="center">
						    <input type="submit" value="상품등록" class="btn btn-dark"> 
						</td>
				    </tr>   
				    </tbody> 
			 </table>
		</form>
    </div><!-- col end -->
  </div><!-- row end -->
</div><!-- container end -->

  <%@ include file="../../footer.jsp" %>
</body>
</html>
