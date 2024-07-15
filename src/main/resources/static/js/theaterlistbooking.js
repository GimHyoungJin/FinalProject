$(document).ready(function() {
    // 영화 목록 불러오기
    $.ajax({
        url: '/movies',
        method: 'GET',
        success: function(data) {
            var movieList = $('#movie-list');
            movieList.empty();
            data.forEach(function(movie) {
                movieList.append('<li>' + movie.movieTitle + '</li>');
            });
        }
    });

    // 극장 목록 불러오기
    $.ajax({
        url: '/theaters',
        method: 'GET',
        success: function(data) {
            var theaterList = $('#theater-list');
            theaterList.empty();
            data.forEach(function(theater) {
                theaterList.append('<li>' + theater.theaterName + '</li>');
            });
        }
    });

    var selectedMovie = null;
    var selectedTheater = null;
    var selectedDate = null;

    $('#movie-list').on('click', 'li', function() {
        selectedMovie = $(this).text();
        $('#movie-list li').removeClass('selected');
        $(this).addClass('selected');
    });

    $('#theater-list').on('click', 'li', function() {
        selectedTheater = $(this).text();
        $('#theater-list li').removeClass('selected');
        $(this).addClass('selected');
    });

    $('#date-list').on('click', 'li', function() {
        selectedDate = $(this).text();
        $('#date-list li').removeClass('selected');
        $(this).addClass('selected');
    });

    $('#select-seat-btn').on('click', function() {
        if (selectedMovie && selectedTheater && selectedDate) {
            var queryParams = $.param({
                movie: selectedMovie,
                theater: selectedTheater,
                date: selectedDate
            });
            window.location.href = '/seat-selection?' + queryParams;
        } else {
            alert('영화, 극장, 날짜를 모두 선택해 주세요.');
        }
    });
});
