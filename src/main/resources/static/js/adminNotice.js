document.addEventListener('DOMContentLoaded', function() {
    checkAdminAccess();
});

// 관리자 접근 권한 확인
function checkAdminAccess() {
    var username = sessionStorage.getItem('username');
    if (username !== 'master1004') {
        alert('접근 권한이 없습니다.');
        window.location.href = ''; // 접근 권한이 없을 경우 리디렉션할 페이지 (나중에 채워 넣기)
    }
}

// 공지사항 폼 제출
function submitNoticeForm(action) {
    var form = document.getElementById('noticeForm');
    form.action = action;
    form.submit();
}

// 공지사항 삭제
function deleteNotice(noticeNum) {
    if (confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '/admin/notices';

        var actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        form.appendChild(actionInput);

        var noticeNumInput = document.createElement('input');
        noticeNumInput.type = 'hidden';
        noticeNumInput.name = 'noticeNum';
        noticeNumInput.value = noticeNum;
        form.appendChild(noticeNumInput);

        document.body.appendChild(form);
        form.submit();
    }
}
