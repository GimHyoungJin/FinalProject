var selectedMovieId = ''; // 선택한 영화의 ID를 저장할 전역 변수
var selectedTheaterId = ''; // 선택한 극장의 ID를 저장할 전역 변수
var selectedDate = ''; // 선택한 날짜를 저장할 전역 변수
var selectedTime = ''; // 선택한 시간을 저장할 전역 변수

$(document).ready(function() {
    // 초기 상태에서는 영화 정보 숨기기
    $('#movie-poster').hide();
    $('#movie-title-container').hide();
    updateSeatButtonState(); // 초기 상태에서는 좌석 선택 버튼 비활성화
});

function resetSelections(resetMovie, resetTheater, resetDate, resetTime) {
    if (resetMovie) {
        selectedMovieId = ''; // 선택한 영화 ID 초기화
        $('#movie-title').text('');
        $('#movie-poster').hide();
        $('#movie-title-container').hide();
        $('#movie-select-message').show(); // 메시지 다시 표시
        $('#movie-list li').removeClass('selected');
    }
    if (resetTheater) {
        selectedTheaterId = ''; // 선택한 극장 ID 초기화
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
        $('#time-list').empty();
        $('#play-date').text('');
        $('#screen-num').text('');
    }
    updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
}

$('#movie-list').on('click', 'li', function() {
    if ($(this).hasClass('selected')) {
        // 이미 선택된 항목을 다시 클릭한 경우
        resetSelections(true, false, true, true);
    } else {
        resetSelections(true, false, true, true);
        // 현재 선택된 요소에 선택 상태 추가
        $(this).addClass('selected');
        selectedMovieId = $(this).data('movie-id'); // data-movie-id 속성에서 영화 ID 가져오기

        // 영화 제목과 포스터 업데이트
        $('#movie-title').text($(this).data('title'));
        $('#movie-poster').attr('src', $(this).data('poster')).show();

        // 숨겨진 요소들 표시
        $('#movie-title-container').show();
        $('#movie-select-message').hide(); // 메시지 숨기기

        if (selectedTheaterId) {
            getDates(selectedTheaterId, selectedMovieId); // 새로 선택된 영화에 맞는 날짜 목록 불러오기
        }
    }
    updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
});

$('#region-theater-list').on('click', '.region-item', function() {
    resetSelections(false, true, true, true);
    // 클릭된 항목에 selected 클래스 추가
    $(this).addClass('selected');

    // 선택된 지역의 ID를 가져오기
    const regionId = $(this).data('region');
    getTheaters(regionId, selectedMovieId); // 선택된 지역의 극장 목록 가져오기
});

$(document).on('click', '.theater-item', function() {
    resetSelections(false, true, true, true);
    // 클릭된 항목에 selected 클래스 추가
    $(this).addClass('selected');
    selectedTheaterId = $(this).data('theater-id'); // 선택한 극장의 ID 저장
    $('#theater-name').text($(this).text()); // 선택된 극장의 이름 업데이트

    if (selectedMovieId) {
        getDates(selectedTheaterId, selectedMovieId); // 선택된 극장의 상영 날짜 목록 가져오기
    }
    updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
});

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

$(document).on('click', '.time-item', function() {
    // 모든 상영 시간 항목에서 selected 클래스를 제거
    $('.time-item').removeClass('selected');
    // 클릭된 항목에 selected 클래스 추가
    $(this).addClass('selected');

    const startTime = $(this).data('start-time');
    const endTime = $(this).data('end-time');
    selectedTime = startTime + ' - ' + endTime; // 선택된 상영 시간 저장

    // HTML 요소 업데이트
    $('#movie-title').text($(this).data('movie-title'));
    $('#theater-name').text($('#theaters .theater-item.selected').text());
    $('#play-date').text($(this).data('play-date') + ' ' + startTime + ' - ' + endTime);
    $('#screen-num').text($(this).data('screen-num'));

    // 선택된 영화의 포스터를 가져와서 업데이트
    $('#movie-poster').attr('src', $(this).data('poster')).show();

    updateSeatButtonState(); // 좌석 선택 버튼 상태 업데이트
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
                a += '<li class="time-item" title="'+ value.movie_title + '" data-movie-title="' + value.movie_title + '" data-type-name="' + value.type_name + '" data-start-time="' + value.start_time + '" data-end-time="' + value.end_time + '" data-play-date="' + date + '" data-screen-num="' + value.screen_num + '" data-poster="' + value.poster_url + '">' + value.start_time + ' - ' + value.end_time + ' : ' + value.movie_title + ' (' + value.screen_num + ')</li>';
            });
            // 상영 시간 목록 업데이트
            $("#time-list").empty().html(a);
        }
    });
}

function updateSeatButtonState() {
    const seatButton = $('#seatButton');
    if (selectedMovieId && selectedTheaterId && selectedDate && selectedTime) {
        seatButton.prop('disabled', false); // 버튼 활성화
        seatButton.css('background-color', 'red'); // 버튼 배경색을 빨간색으로 변경
    } else {
        seatButton.prop('disabled', true); // 버튼 비활성화
        seatButton.css('background-color', '#343433'); // 버튼 배경색을 원래대로 설정
    }
}
