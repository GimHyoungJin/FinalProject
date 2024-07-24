document.addEventListener('DOMContentLoaded', function () {
    // 공지사항 리스트에서 페이지 이동 기능
    const pageLinks = document.querySelectorAll('.page-link');
    pageLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const page = this.getAttribute('data-page');

            if (!page) {
                console.error('data-page attribute is missing or invalid.');
                alert('유효하지 않은 페이지 번호입니다.');
                return;
            }

            const url = new URL(window.location.href);
            url.searchParams.set('page', page);

            console.log('Fetching URL:', url.toString()); // URL 확인용 로그

            fetch(url.toString())
                .then(response => {
                    if (!response.ok) {
                        throw new Error('페이지를 불러오는 중 오류가 발생했습니다.');
                    }
                    return response.text();
                })
                .then(html => {
                    document.open();
                    document.write(html);
                    document.close();
                })
                .catch(error => {
                    console.error('Fetch error:', error); // 콘솔 로그에 오류 메시지 출력
                    alert(error.message); // 사용자에게 에러 메시지 표시
                });
        });
    });

    // 공지사항 상세보기 기능
    const noticeLinks = document.querySelectorAll('.notice-link, .recent-notice-link');
    noticeLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const noticeId = this.getAttribute('data-id');
            const url = new URL(window.location.href);
            url.pathname = `/customer/noticeDetail`;
            url.searchParams.set('noticeNum', noticeId);

            fetch(url.toString())
                .then(response => {
                    if (!response.ok) {
                        throw new Error('공지사항을 불러오는 중 오류가 발생했습니다.');
                    }
                    return response.text();
                })
                .then(html => {
                    document.open();
                    document.write(html);
                    document.close();
                })
                .catch(error => {
                    alert(error.message); // 사용자에게 에러 메시지 표시
                });
        });
    });
});

// 공지사항 폼 제출
function submitNoticeForm(action) {
    var form = document.getElementById('noticeForm');
    form.action = action;

    fetch(form.action, {
        method: form.method,
        body: new FormData(form)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('공지사항을 저장하는 중 오류가 발생했습니다.');
        }
        return response.text();
    })
    .then(responseText => {
        window.location.href = '/notice/list';
    })
    .catch(error => {
        alert(error.message); // 사용자에게 에러 메시지 표시
    });
}

// 공지사항 삭제
function deleteNotice(noticeNum) {
    if (confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
        fetch('/customer/noticeDelete', {
            method: 'POST',
            body: new URLSearchParams({
                'noticeNum': noticeNum
            }),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('공지사항을 삭제하는 중 오류가 발생했습니다.');
            }
            return response.text();
        })
        .then(responseText => {
             window.location.href = '/customer/noticeList?page=1&size=10';
        })
        .catch(error => {
            alert(error.message); // 사용자에게 에러 메시지 표시
        });
    }
}
