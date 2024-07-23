$(document).ready(function() {
    var oEditors = [];

    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "content",
        sSkinURI: "/smarteditor2/SmartEditor2Skin.html",
        fCreator: "createSEditor2",
        fOnAppLoad: function() {
            $("#submitInquiryForm").on("submit", function(e) {
                e.preventDefault();

                oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

                if ($('#agree').prop('checked') === false) {
                    alert('개인정보수집에 동의해주세요.');
                    return false;
                }

                $.ajax({
                    type: 'POST',
                    url: $(this).attr('action'),
                    data: $(this).serialize(),
                    success: function(response) {
                        alert('1:1 문의가 등록되었습니다.');
                        window.location.href = '/customer/inquiryList';
                        window.location.href = '/mypage/inquiry';
                    },
                    error: function() {
                        alert('문의 제출 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            });
        }
    });

    $('#deleteInquiryForm').on('submit', function(e) {
        e.preventDefault();
        if (confirm('정말로 삭제하시겠습니까?')) {
            alert('1:1 문의가 삭제되었습니다');
            this.submit();
        }
    });

    $('#cancelButton').on('click', function() {
        window.location.href = '/customer/inquiryList';
    });

    $('#searchInquiriesButton').on('click', function() {
        var keyword = $('#searchKeyword').val();
        window.location.href = '/customer/inquiryList?keyword=' + keyword;
    });

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
