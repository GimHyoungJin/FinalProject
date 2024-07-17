<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <p>
			<!-- 관리자일 경우에만 상품등록 버튼 표시 -->
       		<div class="admin-button-container" style="display: none;">
			<button type="button" class="btn btn-dark" onclick="location.href='write'">상품등록</button>
        </p>
    </div>
  </div>
</div>

<div class="container mt-3">
    <div class="row">
        <c:forEach var="product" items="${products}">
            <div class="col-lg-3 col-md-4 col-sm-6 mb-3">
                <div class="product-item">
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
					<div class="product-info">
					    <div class="product-name">
					        ${product.pro_name}
					    </div>
					    <div class="product-price">
					        <c:choose>
					            <c:when test="${product.original_price != product.pro_price}">
					                <span style="text-decoration: line-through; color: grey;">${product.original_price}원</span> 
					                <span style="color: red;">${product.pro_price}원</span>
					            </c:when>
					            <c:otherwise>
					                ${product.pro_price}원
					            </c:otherwise>
					        </c:choose>
					    </div>
					</div>
					<div class="product-stock">
					    ${product.pro_stock}개 남음
					</div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<!-- 푸터 포함 -->
<%@ include file="../../footer.jsp" %>
</body>
</html>
