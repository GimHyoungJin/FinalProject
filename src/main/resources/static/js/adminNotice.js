document.addEventListener('DOMContentLoaded', function() {
    checkAdminAccess();
});

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
