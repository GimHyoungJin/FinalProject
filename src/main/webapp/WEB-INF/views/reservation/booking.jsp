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
            	<!-- 영화 리스트가 이곳에 추가 -->
                <c:forEach var="movie" items="${movies}">
                    <li data-poster="${movie.poster_url}" data-title="${movie.movie_title}">${movie.movie_title}</li>
                </c:forEach>
            </ul>
        </div>
     	<div id="region-theater-list-container">
		    <div class="header">
		        <h5>극장</h5>
		    </div>
		    <div id="region-theater-lists">
		        <ul id="region-theater-list">
		        	<!-- 지역 부분이 이곳에 추가 -->
		            <c:forEach var="region" items="${regions}">
		                <li class="region-item" data-region="${region.region_id}">${region.region_name}</li>
		            </c:forEach>
		        </ul>
		        <ul id="theaters">
		            <!-- 극장 리스트 항목이 이곳에 추가됨 -->
		        </ul>
		    </div>
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
                <span>극장: <span id="theater-name"></span></span>
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
<script>
$(document).ready(function() {
    $('#region-theater-list').on('click', '.region-item', function() {
        // 모든 지역 항목에서 selected 클래스를 제거
        $('.region-item').removeClass('selected');
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');

        // 지역 ID 가져오기
        const regionId = $(this).data('region');
        console.log('Region ID:', regionId); // 디버그용 로그
        // 극장 목록 가져오기
        getTheaters(regionId);
    });
});

function getTheaters(region_id) {
    $.ajax({
        url: '/reservation/booking/theater',
        type: 'get',
        data: {region_id: region_id},
        error: function(error) {
            alert(error);
            console.error('Error:', error); // 디버그용 로그
        },
        success: function(result) {
            console.log('Result:', result); // 디버그용 로그
            let a = '';
            $.each(result, function(key, value){
                a += '<li class="theater-item">' + value.theater_name + '</li>';
            });
            $("#theaters").empty();
            $("#theaters").html(a);

            // 극장 리스트에서 극장 선택 시 스타일 적용
            $('.theater-item').on('click', function() {
                $('.theater-item').removeClass('selected');
                $(this).addClass('selected');

                // 극장 이름 업데이트
                $('#theater-name').text($(this).text());
            });
        }
    }); // ajax end
}
</script>
<%@ include file="../../footer.jsp" %>

</body>
</html>