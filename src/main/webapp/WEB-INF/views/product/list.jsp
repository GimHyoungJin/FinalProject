<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Product List</title>
    <meta charset="utf-8">
    <!-- jQuery 라이브러리 추가 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- Bootstrap JS 및 CSS 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 사용자 정의 CSS 추가 -->
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/store/list.css' />" rel="stylesheet" type="text/css">
</head>
<body>
<!-- 헤더 포함 -->
<%@ include file="../../header.jsp" %>

<!-- 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div id="custom-tabs" class="container mt-3 d-flex justify-content-center">
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link <c:if test="${selectedProCode == 'package'}">active</c:if>" id="package-tab" href="<c:url value='/product/listByProCode?pro_code=package' />">세트</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <c:if test="${selectedProCode == 'snack'}">active</c:if>" id="snack-tab" href="<c:url value='/product/listByProCode?pro_code=snack' />">팝콘</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <c:if test="${selectedProCode == 'drink'}">active</c:if>" id="drink-tab" href="<c:url value='/product/listByProCode?pro_code=drink' />">음료</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <c:if test="${selectedProCode == 'ticket'}">active</c:if>" id="ticket-tab" href="<c:url value='/product/listByProCode?pro_code=ticket' />">관람권</a>
            </li>
        </ul>
    </div>
</nav>

<!-- 상품 목록 및 검색 영역 -->
<div class="container text-center">
  <div class="row">
    <div class="col-sm-12">
        <p><h3>상품목록</h3></p>
        <p>
            <button type="button" class="btn btn-dark" onclick="location.href='write'">상품등록</button>
            <button type="button" class="btn btn-dark" onclick="location.href='list'">상품전체목록</button>
        </p>
    </div>
  </div>
  
  <div class="row">
    <div class="col-sm-12">
        <form method="get" action="search">
            상품명 : <input type="text" name="product_name" value="${product_name}">
                   <input type="submit" value="검색" class="btn btn-secondary">
        </form>
        <hr>
    </div>
  </div>
</div>

<!-- 상품 목록 출력 -->
<div class="container mt-3">
    <div class="row">
		<c:forEach var="product" items="${products}">
		    <div class="col-sm-4 mb-3">
		        <c:choose>
		            <c:when test="${product.pro_photo != null && product.pro_photo != '-'}">
		                <a href="detail?pro_detail_code=${product.pro_detail_code}">
		                    <img src="${pageContext.request.contextPath}/storage/${product.pro_photo}" class="img-responsive margin" style="width:100%">
		                </a>
		            </c:when>
		            <c:otherwise>
		                등록된 사진 없음!!<br>
		            </c:otherwise>
		        </c:choose>
		        <br>상품명 : 
		        <a href="detail?pro_detail_code=${product.pro_detail_code}">${product.pro_name}</a>
		        <br>상품가격 : ${product.pro_price}원
		    </div>
		</c:forEach>

    </div>
</div>

 
<!-- 푸터 포함 -->
<%@ include file="../../footer.jsp" %>
</body>
</html>
