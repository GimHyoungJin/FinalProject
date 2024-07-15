$(document).ready(function () {
    $('#submit-btn').on('click', function (event) {
        // 예시: 폼 유효성 검사
        var isValid = true;

        if ($('#name').val().trim() === '') {
            alert('이름을 입력해주세요.');
            isValid = false;
        }

        if ($('#email').val().trim() === '') {
            alert('이메일을 입력해주세요.');
            isValid = false;
        }

        if (!isValid) {
            event.preventDefault();
        }
    });
});
