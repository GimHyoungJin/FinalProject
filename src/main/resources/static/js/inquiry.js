$(document).ready(function() {
    // 문의 제출 폼 유효성 검사
    $('#submitInquiryForm').on('submit', function(e) {
        if ($('#agree').prop('checked') === false) {
            alert('개인정보수집에 동의해주세요.');
            return false;
        }
        alert('1:1 문의가 등록되었습니다');
    });

    // 삭제 확인 메시지
    $('#deleteInquiryForm').on('submit', function(e) {
        e.preventDefault();
        if (confirm('정말로 삭제하시겠습니까?')) {
            alert('1:1 문의가 삭제되었습니다');
            this.submit();
        }
    });

    // 취소 버튼 처리
    $('#cancelButton').on('click', function() {
        window.location.href = '/customer/inquiryList';
    });

    // 제목이나 작성자로 문의 검색
    $('#searchInquiriesButton').on('click', function() {
        var keyword = $('#searchKeyword').val();
        window.location.href = '/customer/inquiryList?keyword=' + keyword;
    });
});

// 검색 기능
$(document).ready(function() {
    $('#search-button').click(function() {
        const keyword = $('#search-input').val();
        if (keyword) {
            location.href = "/customer/inquiryList?keyword=" + keyword;
        }
    });
});

function validateForm() {
    if ($('#agree').prop('checked') === false) {
        alert('개인정보수집에 동의해주세요.');
        return false;
    }
    return true;
}