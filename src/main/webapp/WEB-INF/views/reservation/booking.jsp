<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>예매</title>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<c:url value='/js/theaterlistbooking.js'/>"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/reservation/booking.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="../../header.jsp" %>

<div id="main-container">
    <div class="row" style="display: flex; justify-content: center;">
        <div id="movie-list-container">
            <div class="header">
                <h5>영화</h5>
            </div>
            <ul id="movie-list">
            <!-- 영화 리스트 받아옴 -->
                <c:forEach var="movie" items="${movies}">
                    <li data-poster="${movie.poster_url}" data-title="${movie.movie_title}">${movie.movie_title}</li>
                </c:forEach>
            </ul>
        </div>
        <div id="theater-list-container">
            <div class="header">
                <h5>극장</h5>
            </div>
            <ul id="theater-list">
                <!-- 극장목록은 여기서 받아옴 -->
                
            </ul>
        </div>
        <div id="date-list-container">
            <div class="header">
                <h5>날짜</h5>
            </div>
            <ul id="date-list">
                <!-- 지정한 날짜를 받아옴 -->
            </ul>
        </div>
        <div id="time-list-container">
            <div class="header">
                <h5>시간</h5>
            </div>
        </div>
    </div>
    <div class="footer-panel">
        <div class="movie-info">
            <div id="movie-select-message" style="text-align: center; margin-top: 10px;">
                영화를 선택하세요.
            </div>
            <img id="movie-poster" src="" alt="영화 포스터">
            <div id="movie-title-container">
                <span>영화: <span id="movie-title"></span></span>
                <span>상영관: <span id="theater-name"></span></span>
            </div>
        </div>
        <div class="seat-button">
            <button id="seatButton" type="button">
                <div class="button-content">
                    <span class="button-icon">➜</span>
                    <span class="button-text">좌석선택</span>
                </div>
            </button>
        </div>
    </div>
</div>

<%@ include file="../../footer.jsp" %>

</body>
</html>
