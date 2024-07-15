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

    function product_cart() {
      if (mem_id == null || mem_id === '') {
        alert("로그인이 필요합니다.");
      } else {
        document.productfrm.action = "/cart/insert";
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

<div class="container text-center">
  <div class="row">
    <div class="col-sm-12">
      <p><h3>상품 상세보기 / 상품수정 / 상품삭제</h3></p>
      <p>
        <button type="button" onclick="location.href='/product/listByProCode?pro_code=${product.pro_code}'" class="btn btn-primary">상품전체목록</button>
      </p>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12">
      <form name="productfrm" id="productfrm" method="post" action="/product/update" enctype="multipart/form-data">
        <input type="hidden" name="pro_detail_code" value="${product.pro_detail_code}">
        <input type="hidden" name="pro_code" value="${product.pro_code}">
        <table class="table table-hover">
          <tbody style="text-align: left;">
          <tr>
            <td>상품명</td>
            <td><input type="text" name="pro_name" value="${product.pro_name}" class="form-control" required></td>
          </tr>
          <tr>
            <td>상품가격</td>
            <td><input type="number" name="pro_price" value="${product.pro_price}" class="form-control" required></td>
          </tr>
          <tr>
            <td>상품설명</td>
            <td>
              <textarea rows="5" name="pro_detail" class="form-control" required>${product.pro_detail}</textarea>
            </td>
          </tr>
          <tr>
            <td>상품사진</td>
            <td>
              <c:if test="${product.pro_photo != null}">
                <img src="/storage/${product.pro_photo}" width="100px">
              </c:if>
              <input type="file" name="pro_photo" class="form-control">
            </td>
          </tr>
          <tr>
            <td>재고 수량</td>
            <td>
              <input type="number" name="pro_stock" value="${product.pro_stock}" class="form-control" required>
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
              <input type="submit" value="상품수정" onclick="product_update()" class="btn btn-success">
              <input type="button" value="상품삭제" onclick="product_delete()" class="btn btn-danger">
              <input type="button" value="장바구니담기" onclick="product_cart()" class="btn btn-info">
            </td>
          </tr>
          </tbody>
        </table>
        <input type="hidden" name="cart_price" value="${product.pro_price}">
      </form>
    </div>
  </div>
</div>

<%@ include file="../../footer.jsp"%>
</body>
</html>
