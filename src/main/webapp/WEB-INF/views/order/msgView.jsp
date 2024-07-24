<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>msg View</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/store/list.css' />" rel="stylesheet" type="text/css">
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
 		<p><h3>Store 주문 내역서</h3></p>
    </div><!-- col end -->
  </div><!-- row end -->
   <div class="row">
    <div class="col-sm-12">
 		<p><img src='../images/logo/movio logo.png' width='50'></p>
 		<p>주문이 완료되었습니다</p>
 		<p><a href='/product/list'> [계속쇼핑하기] </a></p>
    </div><!-- col end -->
  </div><!-- row end -->
  

<%@ include file="../../footer.jsp" %>
</body>
</html>
