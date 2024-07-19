<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>좌석 예매</title>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/reservation/movieBooking.css' />" rel="stylesheet" type="text/css">
    <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
    <script src="<c:url value='/js/movieBooking.js'/>"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>

<div id="seatCont">
    <div class="header-panel">
        <h3>인원/좌석</h3>
    </div>
    <div class="top-panel">
        <div class="person-select">
            <h6>※인원 선택 (최대 6명)</h6>
            <div>
                <span>성인</span>
                <button type="button" data-category="adult">0</button>
                <button type="button" data-category="adult">1</button>
                <button type="button" data-category="adult">2</button>
                <button type="button" data-category="adult">3</button>
                <button type="button" data-category="adult">4</button>
                <button type="button" data-category="adult">5</button>
                <button type="button" data-category="adult">6</button>
            </div>
            <div>
                <span>청소년</span>
                <button type="button" data-category="teen">0</button>
                <button type="button" data-category="teen">1</button>
                <button type="button" data-category="teen">2</button>
                <button type="button" data-category="teen">3</button>
                <button type="button" data-category="teen">4</button>
                <button type="button" data-category="teen">5</button>
                <button type="button" data-category="teen">6</button>
            </div>
            <div>
                <span>아동</span>
                <button type="button" data-category="child">0</button>
                <button type="button" data-category="child">1</button>
                <button type="button" data-category="child">2</button>
                <button type="button" data-category="child">3</button>
                <button type="button" data-category="child">4</button>
                <button type="button" data-category="child">5</button>
                <button type="button" data-category="child">6</button>
            </div>
            <div>총 인원 <span id="totalPersons">0명</span></div>
        </div>
        <div class="info-panel">
            <p>${theaterName} | ${screenNum} | 남은 좌석: 179/183</p>
            <h3>${date} ${time}</h3>
        </div>
    </div>
    <div class="screen">SCREEN</div>
    <div class="seating">
        <% 
            String[] rows = {"A", "B", "C", "D", "E", "F"};
            int cols = 10;
            for (String row : rows) {
                out.println("<div class='row'>");
                for (int col = 1; col <= cols; col++) {
                    String seat = row + col;
                    out.println("<div class='seat' data-seat='" + seat + "'>" + seat + "</div>");
                }
                out.println("</div>");
            }
        %>
    </div>
    <div class="footer-panel">
        <div class="movie-info">
            <img src="${posterUrl}" alt="영화 포스터">
            <div>
                <span>영화: ${movieTitle}</span>
                <span>극장: ${theaterName}</span>
                <span>일시: ${date} ${time}</span>
                <span>상영관: ${screenNum}</span>
                <span>좌석: <span id="selectedSeatsDisplay">선택된 좌석 표시</span></span>
                <span>총 금액: <span id="totalPrice">0원</span></span>
            </div>
        </div>
        <div class="payment-button">
            <button id="paymentButton" type="button">
                <div class="button-content">
                    <span class="button-icon">➜</span>
                    <span class="button-text">결제선택</span>
                </div>
            </button>
        </div>
    </div>
</div>
<%@ include file="../../footer.jsp" %>
</body>
</html>
