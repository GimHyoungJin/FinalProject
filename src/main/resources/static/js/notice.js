document.addEventListener('DOMContentLoaded', function () {
    // 공지사항 리스트에서 페이지 이동 기능
    const pageLinks = document.querySelectorAll('.page-link');
    pageLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const page = this.getAttribute('data-page');
            const url = new URL(window.location.href);
            url.searchParams.set('page', page);
            window.location.href = url.toString();
        });
    });

    // 공지사항 상세보기 기능
    const noticeLinks = document.querySelectorAll('.notice-link');
    noticeLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const noticeId = this.getAttribute('data-id');
            const url = new URL(window.location.href);
            url.pathname = `/customer/notices/${noticeId}`;
            window.location.href = url.toString();
        });
    });

    // 홈 페이지에서 최신 공지사항 5개 표시 기능
    const recentNoticeLinks = document.querySelectorAll('.recent-notice-link');
    recentNoticeLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const noticeId = this.getAttribute('data-id');
            const url = new URL(window.location.href);
            url.pathname = `/customer/notices/${noticeId}`;
            window.location.href = url.toString();
        });
    });
});
