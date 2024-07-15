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
