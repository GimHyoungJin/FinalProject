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

<div id="main-container"> <!-- 전체 컨테이너를 감싸는 div -->
    <div class="row" style="display: flex; justify-content: center;"> <!-- 행을 나타내는 div, flexbox를 이용하여 중앙 정렬 -->
        <div id="movie-list-container"> <!-- 영화 리스트를 담는 컨테이너 -->
            <div class="header"> <!-- 영화 리스트의 헤더 -->
                <h5>영화</h5> <!-- 영화 리스트 제목 -->
            </div>
            <ul id="movie-list"> <!-- 영화 리스트를 담는 ul 요소 -->
                <!-- 영화 리스트가 이곳에 추가 -->
                <c:forEach var="movie" items="${movies}"> <!-- movies 컬렉션을 반복하여 각 영화 정보를 출력 -->
                    <li class="movie-item" title="${movie.movie_title}" data-poster="${movie.poster_url}" data-title="${movie.movie_title}" data-movie-id="${movie.movie_id}">
                        <c:choose>
                            <c:when test="${movie.age_rating == '전체이용가'}">
                                <img src="/images/logo/ageall.png" alt="연령 등급" style="width: 20px; height: 20px; margin-right: 5px;">
                            </c:when>
                            <c:when test="${movie.age_rating == '12세 이용가'}">
                                <img src="/images/logo/age12.png" alt="연령 등급" style="width: 20px; height: 20px; margin-right: 5px;">
                            </c:when>
                            <c:when test="${movie.age_rating == '15세 이용가'}">
                                <img src="/images/logo/age15.png" alt="연령 등급" style="width: 20px; height: 20px; margin-right: 5px;">
                            </c:when>
                            <c:when test="${movie.age_rating == '청소년 관람불가'}">
                                <img src="/images/logo/age19.png" alt="연령 등급" style="width: 20px; height: 20px; margin-right: 5px;">
                            </c:when>
                            <c:otherwise>
                                <span>연령 등급 정보 없음</span>
                            </c:otherwise>
                        </c:choose>
                        <span>${movie.movie_title}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div id="region-theater-list-container"> <!-- 지역 및 극장 리스트를 담는 컨테이너 -->
            <div class="header"> <!-- 지역 및 극장 리스트의 헤더 -->
                <h5>극장</h5> <!-- 극장 리스트 제목 -->
            </div>
            <div id="region-theater-lists"> <!-- 지역 및 극장 리스트를 담는 div -->
                <ul id="region-theater-list"> <!-- 지역 리스트를 담는 ul 요소 -->
                    <!-- 지역 부분이 이곳에 추가 -->
                    <c:forEach var="region" items="${regions}"> <!-- regions 컬렉션을 반복하여 각 지역 정보를 출력 -->
                        <c:set var="theaterCount" value="0" /> <!-- 각 지역의 극장 수를 저장할 변수 초기화 -->
                        <c:forEach var="count" items="${regionCounts}"> <!-- regionCounts 컬렉션을 반복하여 각 지역의 극장 수를 확인 -->
                            <c:if test="${region.region_id == count.region_id}"> <!-- 현재 지역과 일치하는 극장 수를 찾음 -->
                                <c:set var="theaterCount" value="${count.theater_count}" /> <!-- 일치하는 극장 수를 theaterCount 변수에 저장 -->
                            </c:if>
                        </c:forEach>
                        <li class="region-item" data-region="${region.region_id}">
                            ${region.region_name} (${theaterCount}) <!-- 지역명과 극장 수를 출력 -->
                        </li>
                    </c:forEach>
                </ul>
                <ul id="theaters"> <!-- 극장 리스트를 담는 ul 요소 -->
                    <!-- 극장 리스트 항목이 이곳에 추가됨 -->
                </ul>
            </div>
        </div>
        <div id="date-list-container"> <!-- 날짜 리스트를 담는 컨테이너 -->
            <div class="header"> <!-- 날짜 리스트의 헤더 -->
                <h5>날짜</h5> <!-- 날짜 리스트 제목 -->
            </div>
            <ul id="date-list"> <!-- 날짜 리스트를 담는 ul 요소 -->
                <!-- 지정한 날짜를 받아옴 -->
                <c:forEach var="date" items="${dates}"> <!-- dates 컬렉션을 반복하여 각 날짜 정보를 출력 -->
                    <li class="date-item" data-date="${date.play_date}">${date.play_date}</li> <!-- 날짜를 출력 -->
                </c:forEach>
            </ul>
        </div>
        <div id="time-list-container"> <!-- 시간 리스트를 담는 컨테이너 -->
            <div class="header"> <!-- 시간 리스트의 헤더 -->
                <h5>시간</h5> <!-- 시간 리스트 제목 -->
                <!-- 상영 시작시간과 종료시간 그리고 선택한 영화명과, 무슨 상영관인지가 출력 -->
            </div>
            <ul id="time-list"> <!-- 시간 리스트를 담는 ul 요소 -->
                <c:forEach var="time" items="${times}"> <!-- times 컬렉션을 반복하여 각 시간 정보를 출력 -->
                    <li>${time.start_time} - ${time.end_time} : ${time.movie_title} (${time.screen_num}관)</li> <!-- 상영 시작시간, 종료시간, 영화 제목, 상영관 번호를 출력 -->
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="footer-panel"> <!-- 하단 패널을 담는 div -->
        <div class="movie-info"> <!-- 영화 정보를 담는 div -->
            <div id="movie-select-message" style="text-align: center; margin-top: 10px;"> <!-- 영화 선택 메시지를 담는 div -->
                영화를 선택하세요. <!-- 영화 선택 안내 메시지 -->
            </div>
            <img id="movie-poster" src="" alt="영화 포스터"> <!-- 영화 포스터 이미지 -->
            <div id="movie-title-container"> <!-- 영화 제목, 극장명, 날짜, 상영관 번호를 담는 컨테이너 -->
                <span>영화: <span id="movie-title"></span></span> <!-- 선택한 영화 제목을 표시 -->
                <span>극장: <span id="theater-name"></span></span> <!-- 선택한 극장명을 표시 -->
                <span>일시: <span id="play-date"></span></span> <!-- 선택한 날짜를 표시 -->
                <span>상영관: <span id="screen-num"></span></span> <!-- 선택한 상영관 번호를 표시 -->
            </div>
        </div>
        <div class="seat-button"> <!-- 좌석 선택 버튼을 담는 div -->
            <button id="seatButton" type="button" disabled> <!-- 좌석 선택 버튼을 비활성화 상태로 초기화 -->
                <div class="button-content"> <!-- 버튼 내용을 담는 div -->
                    <span class="button-icon">➜</span> <!-- 버튼 아이콘 -->
                    <span class="button-text">좌석선택</span> <!-- 버튼 텍스트 -->
                </div>
            </button>
        </div>
    </div>
</div>

<script>
var selectedMovieId = ''; // 선택한 영화의 ID를 저장할 전역 변수
var selectedTheaterId = ''; // 선택한 극장의 ID를 저장할 전역 변수
var selectedDate = ''; // 선택한 날짜를 저장할 전역 변수
var selectedTime = ''; // 선택한 시간을 저장할 전역 변수
var selectedPosterUrl = ''; // 선택한 영화의 포스터 URL을 저장할 전역 변수
var selectedMovieTitle = ''; // 선택한 영화의 제목을 저장할 전역 변수
var selectedTheaterName = ''; // 선택한 극장의 이름을 저장할 전역 변수
var selectedScreenNum = ''; // 선택한 상영관 번호를 저장할 전역 변수
var selectedScreenMovieId = '';

$(document).ready(function() {
    // 초기 상태에서는 영화 정보 숨기기
    $('#movie-poster').hide();
    $('#movie-title-container').hide();
    updateSeatButtonState(); // 초기 상태에서는 좌석 선택 버튼 비활성화

    // 좌석 선택 버튼 클릭 이벤트 처리
    $('#seatButton').on('click', function() {
        if (selectedMovieId && selectedTheaterId && selectedDate && selectedTime && selectedScreenMovieId) {
            const bookingData = {
                movieId: selectedMovieId.toString(),
                theaterId: selectedTheaterId.toString(),
                date: selectedDate.toString(),
                time: selectedTime.toString(),
                posterUrl: selectedPosterUrl,
                movieTitle: selectedMovieTitle,
                theaterName: selectedTheaterName,
                screenNum: selectedScreenNum,
                screenMovieId: selectedScreenMovieId
            };

            $.ajax({
                url: '/reservation/moviebooking',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(bookingData),
                success: function(response) {
                    window.location.href = '/reservation/moviebooking';
                },
                error: function(xhr, status, error) {
                    alert('Error: ' + error);
                }
            });
        }
    });

    // 영화 목록 항목 클릭 이벤트 처리
    $('#movie-list').on('click', 'li', function() {
        if ($(this).hasClass('selected')) {
            // 이미 선택된 항목을 다시 클릭한 경우
            resetSelections(true, false, true, true);
        } else {
            resetSelections(true, false, true, true);
            // 현재 선택된 요소에 선택 상태 추가
            $(this).addClass('selected');
            selectedMovieId = $(this).data('movie-id'); // data-movie-id 속성에서 영화 ID 가져오기
            selectedPosterUrl = $(this).data('poster'); // data-poster 속성에서 포스터 URL 가져오기
            selectedMovieTitle = $(this).data('title'); // data-title 속성에서 영화 제목 가져오기

            // 영화 제목과 포스터 업데이트
            $('#movie-title').text(selectedMovieTitle);
            $('#movie-poster').attr('src', selectedPosterUrl).show();

            // 숨겨진 요소들 표시
            $('#movie-title-container').show();
            $('#movie-select-message').hide(); // 메시지 숨기기

            if (selectedTheaterId) {
                getDates(selectedTheaterId, selectedMovieId); // 새로 선택된 영화에 맞는 날짜 목록 불러오기
            }
        }
        updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
    });

    // 지역 항목을 클릭했을 때 이벤트 핸들러
    $('#region-theater-list').on('click', '.region-item', function() {
        resetSelections(false, true, true, true);
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');

        // 선택된 지역의 ID를 가져오기
        const regionId = $(this).data('region');
        getTheaters(regionId, selectedMovieId); // 선택된 지역의 극장 목록 가져오기
    });

    // 동적으로 생성된 극장 항목을 클릭했을 때 이벤트 핸들러
    $(document).on('click', '.theater-item', function() {
        resetSelections(false, true, true, true);
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');
        selectedTheaterId = $(this).data('theater-id'); // 선택한 극장의 ID 저장
        selectedTheaterName = $(this).text(); // 선택한 극장의 이름 저장
        $('#theater-name').text(selectedTheaterName); // 선택된 극장의 이름 업데이트

        if (selectedMovieId) {
            getDates(selectedTheaterId, selectedMovieId); // 선택된 극장의 상영 날짜 목록 가져오기
        }
        updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
    });

    // 동적으로 생성된 상영 날짜 항목을 클릭했을 때 이벤트 핸들러
    $(document).on('click', '.date-item', function() {
        // 모든 날짜 항목에서 selected 클래스를 제거
        $('.date-item').removeClass('selected');
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');
        selectedDate = $(this).data('date'); // 선택한 날짜 저장

        const theaterId = $('#theaters .theater-item.selected').data('theater-id');
        if (theaterId && selectedMovieId) {
            getTimes(theaterId, selectedDate, selectedMovieId); // 선택된 날짜와 극장의 상영 시간 목록 가져오기
        }
        updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
    });

    // 동적으로 생성된 상영 시간 항목을 클릭했을 때 이벤트 핸들러
    $(document).on('click', '.time-item', function() {
        // 모든 상영 시간 항목에서 selected 클래스를 제거
        $('.time-item').removeClass('selected');
        // 클릭된 항목에 selected 클래스 추가
        $(this).addClass('selected');

        selectedTime = $(this).data('start-time') + ' - ' + $(this).data('end-time'); // 선택된 상영 시간 저장
        selectedScreenNum = $(this).data('screen-num'); // 선택한 상영관 번호 저장
        selectedScreenMovieId = $(this).data('screen-movie-id'); // 선택한 상영관 영화 ID 저장

        // HTML 요소 업데이트
        $('#movie-title').text($(this).data('movie-title'));
        $('#theater-name').text($('#theaters .theater-item.selected').text());
        $('#play-date').text($(this).data('play-date') + ' ' + $(this).data('start-time') + ' - ' + $(this).data('end-time'));
        $('#screen-num').text(selectedScreenNum);

        // 선택된 영화의 포스터를 가져와서 업데이트
        $('#movie-poster').attr('src', $(this).data('poster')).show();

        updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
    });
});

function getTheaters(region_id, movie_id) { // movie_id 파라미터 추가
    $.ajax({
        url: '/reservation/booking/theater', // 서버의 극장 목록 엔드포인트
        type: 'get',
        data: { region_id: region_id, movie_id: movie_id }, // 요청에 지역 ID와 영화 ID를 포함
        error: function(error) {
            alert("!"+error); // 오류 발생 시 경고창 표시
            console.error('Error:', error); // 디버그용 로그
        },
        success: function(result) {
            let a = '';
            // 서버로부터 받은 극장 목록을 반복하여 HTML 요소 생성
            $.each(result, function(key, value) {
                a += '<li class="theater-item" data-theater-id="' + value.theater_id + '">' + value.theater_name + '</li>';
            });
            // 극장 목록 업데이트
            $("#theaters").empty().html(a);
        }
    });
}

function getDates(theater_id, movie_id) { // movie_id 파라미터 추가
    $.ajax({
        url: '/reservation/booking/dates', // 서버의 상영 날짜 엔드포인트
        type: 'get',
        data: { theater_id: theater_id, movie_id: movie_id }, // 요청에 극장 ID와 영화 ID를 포함
        error: function(error) {
            alert("?"+error); // 오류 발생 시 경고창 표시
            console.error('Error:', error); // 디버그용 로그
        },
        success: function(result) {
            let a = '';
            // 서버로부터 받은 상영 날짜 목록을 반복하여 HTML 요소 생성
            $.each(result, function(key, value) {
                a += '<li class="date-item" data-date="' + value.play_date + '">' + value.play_date + '</li>';
            });
            // 상영 날짜 목록 업데이트
            $("#date-list").empty().html(a);
        }
    });
}

function getTimes(theater_id, date, movie_id) {
    $.ajax({
        url: '/reservation/booking/times', // 서버의 상영 시간 엔드포인트
        type: 'get',
        data: { theater_id: theater_id, date: date, movie_id: movie_id }, // 요청에 극장 ID, 날짜, 영화 ID를 포함
        error: function(error) {
            alert("#"+error); // 오류 발생 시 경고창 표시
            console.error('Error:', error); // 디버그용 로그
        },
        success: function(result) {
            let a = '';
            // 서버로부터 받은 상영 시간 목록을 반복하여 HTML 요소 생성
            $.each(result, function(key, value) {
                a += '<li class="time-item" title="'+ value.movie_title + '" data-movie-title="' + value.movie_title + '" data-type-name="' + value.type_name + '" data-start-time="' + value.start_time + '" data-end-time="' + value.end_time + '" data-play-date="' + date + '" data-screen-num="' + value.screen_num + '" data-screen-movie-id="' + value.screen_movie_id + '" data-poster="' + value.poster_url + '">' + value.start_time + ' - ' + value.end_time + ' : ' + value.movie_title + ' (' + value.screen_num + ')</li>';
            });
            // 상영 시간 목록 업데이트
            $("#time-list").empty().html(a);
        }
    });
}

function updateSeatButtonState() {
    const seatButton = $('#seatButton');
    if (selectedMovieId && selectedTheaterId && selectedDate && selectedTime && selectedScreenMovieId) {
        seatButton.prop('disabled', false); // 버튼 활성화
        seatButton.css('background-color', 'red'); // 버튼 배경색을 빨간색으로 변경
    } else {
        seatButton.prop('disabled', true); // 버튼 비활성화
        seatButton.css('background-color', '#343433'); // 버튼 배경색을 원래대로 설정
    }
}

function resetSelections(resetMovie, resetTheater, resetDate, resetTime) {
    if (resetMovie) {
        selectedMovieId = ''; // 선택한 영화 ID 초기화
        selectedPosterUrl = ''; // 선택한 영화 포스터 URL 초기화
        selectedMovieTitle = ''; // 선택한 영화 제목 초기화
        $('#movie-title').text('');
        $('#movie-poster').hide();
        $('#movie-title-container').hide();
        $('#movie-select-message').show(); // 메시지 다시 표시
        $('#movie-list li').removeClass('selected');
    }
    if (resetTheater) {
        selectedTheaterId = ''; // 선택한 극장 ID 초기화
        selectedTheaterName = ''; // 선택한 극장 이름 초기화
        $('#theater-name').text('');
        $('#region-theater-list .region-item').removeClass('selected');
        $('#theaters .theater-item').removeClass('selected');
    }
    if (resetDate) {
        selectedDate = ''; // 선택한 날짜 초기화
        $('#date-list').empty();
    }
    if (resetTime) {
        selectedTime = ''; // 선택한 시간 초기화
        selectedScreenNum = ''; // 선택한 상영관 번호 초기화
        selectedScreenMovieId = ''; // 선택한 상영 영화 ID 초기화
        $('#time-list').empty();
        $('#play-date').text('');
        $('#screen-num').text('');
    }
    updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
}
</script>
<%@ include file="../../footer.jsp" %>

</body>
</html>
