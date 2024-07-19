<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>예매</title>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
                    <li class="movie-item" title="${movie.movie_title}" data-poster="${movie.poster_url}" data-title="${movie.movie_title}">${movie.movie_title}</li>
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
                        <c:set var="theaterCount" value="0" />
                        <c:forEach var="count" items="${regionCounts}">
                            <c:if test="${region.region_id == count.region_id}">
                                <c:set var="theaterCount" value="${count.theater_count}" />
                            </c:if>
                        </c:forEach>
                        <li class="region-item" data-region="${region.region_id}">
                            ${region.region_name} (${theaterCount})
                        </li>
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
			    <c:forEach var="date" items="${dates}">
			        <li class="date-item" data-date="${date.play_date}">${date.play_date}</li>
			    </c:forEach>
			</ul>
        </div>
        <div id="time-list-container">
            <div class="header">
                <h5>시간</h5>
                <!-- 상영 시작시간과 종료시간 그리고 선택한 영화명과, 무슨 상영관인지가 출력  -->
            </div>
            <ul id="time-list">
			    <c:forEach var="time" items="${times}">
			        <li>${time.start_time} - ${time.end_time} : ${time.movie_title} (${time.screen_num}관)</li>
			    </c:forEach>
			</ul>
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
                <span>일시: <span id="play-date"></span></span>
                <span>상영관: <span id="screen-num"></span></span>
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
    // 초기 상태에서는 영화 정보 숨기기
    $('#movie-poster').hide();
    $('#movie-title-container').hide();

    // 영화 목록 항목 클릭 이벤트 처리
    $('#movie-list').on('click', 'li', function() {
        if ($(this).hasClass('selected')) {
            // 이미 선택된 항목을 다시 클릭한 경우
            $(this).removeClass('selected');
            $('#movie-title').text('');
            $('#movie-poster').hide();
            $('#movie-title-container').hide();
            $('#movie-select-message').show(); // 메시지 다시 표시
        } else {
            // 이전 선택된 요소의 선택 상태를 제거
            $('#movie-list li').removeClass('selected');

            // 현재 선택된 요소에 선택 상태 추가
            $(this).addClass('selected');

            var movieTitle = $(this).data('title');
            var posterUrl = $(this).data('poster'); // data-poster 속성에서 포스터 URL 가져오기

            // 영화 제목과 포스터 업데이트
            $('#movie-title').text(movieTitle);
            $('#movie-poster').attr('src', posterUrl).show();

            // 숨겨진 요소들 표시
            $('#movie-title-container').show();
            $('#movie-select-message').hide(); // 메시지 숨기기
        }
    });
    
});


$(document).ready(function() {
    // 지역 항목을 클릭했을 때 이벤트 핸들러
    $('#region-theater-list').on('click', '.region-item', function() {
        // 모든 지역 항목에서 selected 클래스를 제거
        $('.region-item').removeClass('selected');
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');

        // 선택된 지역의 ID를 가져오기
        const regionId = $(this).data('region');
        console.log('Region ID:', regionId); // 디버그용 로그
        // 선택된 지역의 극장 목록 가져오기
        getTheaters(regionId);
    });

    // 동적으로 생성된 극장 항목을 클릭했을 때 이벤트 핸들러
    $(document).on('click', '.theater-item', function() {
        // 모든 극장 항목에서 selected 클래스를 제거
        $('.theater-item').removeClass('selected');
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');

        // 선택된 극장의 이름과 ID를 가져오기
        const theaterName = $(this).text();
        const theaterId = $(this).data('theater-id');
        $('#theater-name').text(theaterName); // 선택된 극장의 이름 업데이트
        console.log('Theater ID:', theaterId); // 디버그용 로그
        // 선택된 극장의 상영 날짜 목록 가져오기
        getDates(theaterId);
    });

    // 동적으로 생성된 상영 날짜 항목을 클릭했을 때 이벤트 핸들러
    $(document).on('click', '.date-item', function() {
        // 모든 날짜 항목에서 selected 클래스를 제거
        $('.date-item').removeClass('selected');
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');

        // 선택된 날짜와 현재 선택된 극장의 ID를 가져오기
        const date = $(this).data('date');
        const theaterId = $('#theaters .theater-item.selected').data('theater-id');
        console.log('Selected Date:', date); // 디버그용 로그
        // 선택된 날짜와 극장의 상영 시간 목록 가져오기
        getTimes(theaterId, date);
    });

    // 동적으로 생성된 상영 시간 항목을 클릭했을 때 이벤트 핸들러
    $(document).on('click', '.time-item', function() {
        // 모든 상영 시간 항목에서 selected 클래스를 제거
        $('.time-item').removeClass('selected');
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');

        // 선택된 상영 시간의 데이터를 가져오기
        const movieTitle = $(this).data('movie-title');
        const typeName = $(this).data('type-name');
        const startTime = $(this).data('start-time');
        const endTime = $(this).data('end-time');
        const playDate = $(this).data('play-date'); // 선택된 상영 날짜
        const screenNum = $(this).data('screen-num'); // 상영관 번호 추가

        // HTML 요소 업데이트
        $('#movie-title').text(movieTitle);
        $('#theater-name').text($('#theaters .theater-item.selected').text());
        $('#play-date').text(playDate + ' ' + startTime + ' - ' + endTime);
        $('#screen-num').text(screenNum);

        console.log('Movie Title:', movieTitle);
        console.log('Type Name:', typeName);
        console.log('Start Time:', startTime);
        console.log('End Time:', endTime);
        console.log('Play Date:', playDate);
        console.log('Screen Num:', screenNum);
    });
});

// 선택된 지역의 극장 목록을 가져오는 함수
function getTheaters(region_id) {
    $.ajax({
        url: '/reservation/booking/theater', // 서버의 극장 목록 엔드포인트
        type: 'get',
        data: { region_id: region_id }, // 요청에 지역 ID를 포함
        error: function(error) {
            alert(error); // 오류 발생 시 경고창 표시
            console.error('Error:', error); // 디버그용 로그
        },
        success: function(result) {
            console.log('Result:', result); // 디버그용 로그
            let a = '';
            // 서버로부터 받은 극장 목록을 반복하여 HTML 요소 생성
            $.each(result, function(key, value) {
                a += '<li class="theater-item" data-theater-id="' + value.theater_id + '">' + value.theater_name + '</li>';
            });
            // 극장 목록 업데이트
            $("#theaters").empty();
            $("#theaters").html(a);
        }
    });
}

// 선택된 극장의 상영 날짜 목록을 가져오는 함수
function getDates(theater_id) {
    $.ajax({
        url: '/reservation/booking/dates', // 서버의 상영 날짜 엔드포인트
        type: 'get',
        data: { theater_id: theater_id }, // 요청에 극장 ID를 포함
        error: function(error) {
            alert(error); // 오류 발생 시 경고창 표시
            console.error('Error:', error); // 디버그용 로그
        },
        success: function(result) {
            console.log('Result:', result); // 디버그용 로그
            let a = '';
            // 서버로부터 받은 상영 날짜 목록을 반복하여 HTML 요소 생성
            $.each(result, function(key, value) {
                a += '<li class="date-item" data-date="' + value.play_date + '">' + value.play_date + '</li>';
            });
            // 상영 날짜 목록 업데이트
            $("#date-list").empty();
            $("#date-list").html(a);
        }
    });
}

// 선택된 날짜와 극장의 상영 시간 목록을 가져오는 함수
function getTimes(theater_id, date) {
    $.ajax({
        url: '/reservation/booking/times', // 서버의 상영 시간 엔드포인트
        type: 'get',
        data: { theater_id: theater_id, date: date }, // 요청에 극장 ID와 날짜를 포함
        error: function(error) {
            alert(error); // 오류 발생 시 경고창 표시
            console.error('Error:', error); // 디버그용 로그
        },
        success: function(result) {
            console.log('Result:', result); // 디버그용 로그
            let a = '';
            // 서버로부터 받은 상영 시간 목록을 반복하여 HTML 요소 생성
            $.each(result, function(key, value) {
                a += '<li class="time-item" title="'+ value.movie_title + '" data-movie-title="' + value.movie_title + '" data-type-name="' + value.type_name + '" data-start-time="' + value.start_time + '" data-end-time="' + value.end_time + '" data-play-date="' + date + '" data-screen-num="' + value.screen_num + '">' + value.start_time + ' - ' + value.end_time + ' : ' + value.movie_title + ' (' + value.screen_num + ')</li>';
            });
            // 상영 시간 목록 업데이트
            $("#time-list").empty();
            $("#time-list").html(a);
        }
    });
}
</script>
<%@ include file="../../footer.jsp" %>

</body>
</html>