<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>접근 불가</title>
    <!-- 공통 시작 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
    <style>
        .center-content {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
    </style>
    <!-- 공통 끝 -->
</head>
<body>
    <%@ include file="../../header.jsp" %>
    <!-- 메인 콘텐츠 시작 -->
    <div class="container center-content">
        <div>
            <h2>접근 불가</h2>
            <p>이 페이지에 접근할 권한이 없습니다.</p>
            <a href="<c:url value='/' />" class="btn btn-primary">홈으로 이동</a>
        </div>
    </div>
    <!-- 메인 콘텐츠 끝 -->
    <%@ include file="../../footer.jsp" %>
</body>
</html>
