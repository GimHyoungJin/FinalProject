<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>detail</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/jquery-3.7.1.min.js"></script>
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">

  <script>
    var mem_id = '<%= session.getAttribute("mem_id") %>';

    function product_update() {
      document.productfrm.action = "/product/update";
      document.productfrm.submit();
    }

    function product_delete() {
      if (confirm("첨부된 파일은 영구히 삭제됩니다\n진행할까요?")) {
        document.productfrm.action = "/product/delete";
        document.productfrm.submit();
      }
    }

    $(document).ready(function() {
        // 관리자인 경우 readonly 속성을 제거
        if (mem_id === 'master1004') { // 관리자 ID 확인
            $('input[readonly], textarea[readonly]').removeAttr('readonly').css({
                'pointer-events': 'auto',
                'background-color': '#ffffff',
                'border': '1px solid #ced4da'
            });
            $('.admin-button-container').show(); // 관리자 버튼 표시
        } else {
            // 관리자가 아닌 경우 원래가격과 상품사진 숨김
            $('.non-admin').hide();
        }

        // 모달 창을 열기 위한 코드
        $('#editReviewModal').modal('show');
    });

    // 로그인 확인 후 폼 제출 함수
    function checkLoginAndSubmit() {
        var mem_id = '${sessionScope.mem_id}';
        if (!mem_id) {
            $('#loginModal').modal('show'); // 로그인 모달 표시
        } else {
            // 장바구니에 담을 때 pro_price 값을 cart_price로 설정
            document.getElementById('cart_price').value = document.getElementsByName('pro_price')[0].value;
            document.productfrm.action = "/cart/insert"; // 장바구니 추가 URL로 설정
            document.productfrm.submit();
        }
    }
  </script>
</head>
<body>

<%@ include file="../../header.jsp" %>

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

<div class="container mt-5">
  <div class="row">
    <div class="col-md-6 text-center product-image">
      <c:if test="${product.pro_photo != null}">
        <img src="/storage/${product.pro_photo}" alt="${product.pro_name}" class="img-fluid">
      </c:if>
    </div>
    <div class="col-md-6">
      <form name="productfrm" id="productfrm" method="post" action="/cart/insert" enctype="multipart/form-data">
        <input type="hidden" name="pro_detail_code" value="${product.pro_detail_code}">
        <input type="hidden" name="pro_code" value="${product.pro_code}">
        <table class="table table-hover">
          <tbody style="text-align: left;">
          <tr>
            <td>상품명</td>
            <td><input type="text" name="pro_name" value="${product.pro_name}" class="form-control" required readonly></td>
          </tr>
          <c:if test="${sessionScope.mem_id == 'master1004'}">
          <tr class="non-admin">
             <td>원래가격</td>
             <td>
	             <input type="number" name="original_price" value="${product.original_price}" class="form-control" readonly>
	             <input type="hidden" name="original_price_hidden" value="${product.original_price}">
             </td>          
          </tr>
          </c:if>
          <tr>
            <td>상품가격</td>
            <td><input type="number" name="pro_price" value="${product.pro_price}" class="form-control" required readonly></td>
          </tr>
          <tr>
            <td>상품설명</td>
            <td>
              <textarea rows="5" name="pro_detail" class="form-control" required readonly>${product.pro_detail}</textarea>
            </td>
          </tr>
          <c:if test="${sessionScope.mem_id == 'master1004'}">
          <tr class="non-admin">
            <td>상품사진</td>
            <td>
              <input type="file" name="pro_photo" class="form-control" readonly>
            </td>
          </tr>
          </c:if>
          <tr>
            <td>재고 수량</td>
            <td>
              <input type="number" name="pro_stock" value="${product.pro_stock}" class="form-control" required readonly>
            </td>
          </tr>
          <tr>
 			<td>상품 수량</td>
	        <td>
	          <select name="cart_amount" class="form-control" required>
	            <option value="1">1</option>
	            <option value="2">2</option>
	            <option value="3">3</option>
	            <option value="4">4</option>
	            <option value="5">5</option>
	          </select>
	        </td>
          </tr>
				<tr>
				    <td colspan="2" align="center">
				        <!-- 관리자일 경우에만 상품수정 버튼 표시 -->
				        <div class="admin-button-container" style="display: none; margin-bottom: 10px;">
				            <input type="submit" value="상품수정" onclick="product_update()" class="btn btn-dark">
				            <input type="button" value="상품삭제" onclick="product_delete()" class="btn btn-dark">
				        </div>
				
				        <!-- 모든 사용자가 장바구니 담기 버튼을 볼 수 있음 -->
				        <div>
				            <input type="button" value="장바구니담기" onclick="checkLoginAndSubmit()" class="btn btn-dark">
				        </div>
				    </td>
				</tr>
          </tbody>
        </table>
        <input type="hidden" name="cart_price" id="cart_price" value="${product.pro_price}">
      </form>
     </div>
    </div>
  </div>
</div>

<%@ include file="../../footer.jsp"%>
</body>
</html>