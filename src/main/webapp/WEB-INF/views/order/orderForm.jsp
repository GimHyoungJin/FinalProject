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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  
  <script>
  	function orderCheck() {
		let deliverynm = $("#deliverynm").val().trim();
		if(deliverynm.length<=2) {
			alert("받는사람 입력해주세요");
			$("#deliverynm").focus();
			return false;
		}//if end
		
		let deliveryaddr = $("#deliveryaddr").val().trim();
		if(deliveryaddr.length<=2) {
			alert("받는주소 입력해주세요");
			$("#deliveryaddr").focus();
			return false;
		}//if end
		
		if(confirm("결제할까요?")){
			return true;
		}else{
			return false;
		}//if end
		
	}//orderCheck() end
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
  <!-- 본문 시작 -->
  <div class="row">
    <div class="col-sm-12">
 		<p><h3>주문서 작성</h3></p>
    </div><!-- col end -->
  </div><!-- row end -->
  
    <div class="row">
    <div class="col-sm-12">
 		<form method="post" action="insert" onsubmit="return orderCheck()">
 		    <input type="hidden" name="proDetailCode" value="${product.proDetailCode}">
	 		<table class="table table-hover">
			<tbody style="text-align: left;">
			<tr>
				<th>받는사람</th>
				<td><input type="text" name="deliverynm" id="deliverynm" class="form-control" required></td>
			</tr>
			<tr>
				<th>받는번호</th>
				<td><input type="text" name="deliveryaddr" id="deliveryaddr" class="form-control" required></td>
			</tr>
			<tr>
				<th>결제구분</th>
				<td>
					<select name="payment" class="form-control">
						<option value="cash">현금결제</option>
						<option value="card">카드</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="결제하기" class="btn btn-warning">
				</td>
			</tr>
			</tbody>
			</table>
 		</form>
    </div><!-- col end -->
  </div><!-- row end -->
  <!-- 본문 끝 -->
</div><!-- container end -->


 <%@ include file="../../footer.jsp" %>
</body>
</html>