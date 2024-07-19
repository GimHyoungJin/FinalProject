<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>cart list</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/jquery-3.7.1.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  
  <script>
  	function cartDelete(cartno) {
		if(confirm("장바구니에서 해당 상품을 삭제할까요?")) {
			location.href='/cart/delete?cartno=' + cartno;
		}//if end
	}//cartDelete() end  
	
	function checkLoginAndOrder() {
        var mem_id = '<c:out value="${sessionScope.mem_id}" />';
        if (!mem_id) {
            $('#loginModal').modal('show'); // 로그인 모달 표시
        } else {
            if(confirm("주문할까요?")){
			    location.href='/order/orderform';
		    }//if end
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
  <!-- 본문 시작 -->
  <div class="row">
    <div class="col-sm-12">
    	<p><h3>장바구니 목록</h3></p>
    </div><!-- col end -->
  </div><!-- row end -->
  
  <div class="row">
    <div class="col-sm-12">
   	   	<table class="table table-hover">
	    	<thead class="table-active">
				<th>아이디</th>
		    	<th>번호</th>
		    	<th>상품명</th>
		    	<th>단가</th>
		    	<th>상품수량</th>
		    	<th>가격</th>
		    	<th>삭제</th>
	    	</thead>
	   		<tbody>
	   			<c:forEach items="${list}" var="row">
   					<tr>
			    		<td>${row.mem_id}</td>
			    		<td>${row.cart_no}</td>
			    		<td>${row.pro_name}</td>
			    		<td>${row.cart_price}</td>
			    		<td>${row.cart_amount}</td>
			    		<td>${row.cart_price * row.cart_amount}</td>
			    		<td>
			    			<input type="button" value="삭제" onclick="cartDelete(${row.cart_no})">
			    		</td>
			    	</tr>
	   			</c:forEach>	   		
	   		</tbody>
    	</table>
    	<p><h3>총 금액: ${totalPrice}원</h3></p>
  	    <br>
    	<input type="button" class="btn btn-dark" value="계속쇼핑하기" onclick="location.href='/product/list'">
	    <input type="button" class="btn btn-dark" value="주문하기" onclick="checkLoginAndOrder()"> 
    	
  </div><!-- row end -->
  <!-- 본문 끝 -->
</div><!-- container end -->

 <%@ include file="../../footer.jsp" %>
</body>
</html>