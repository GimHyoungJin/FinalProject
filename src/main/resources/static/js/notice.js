$(document).ready(function() {
    // 문서가 완전히 로드되고 DOM이 준비되었을 때 실행되는 함수
    // DOM(Document Object Model)은 웹 페이지의 구조를 트리 형태로 표현한 것
    // DOM은 HTML 요소들을 객체로 표현하며, JavaScript를 통해 이 객체들을 조작할 수 있음

    // 로그인 모달 열기 함수 정의
    window.showLoginModal = function() {
        // 메뉴 모달을 숨기고 로그인 모달을 표시
        // modal('hide')는 모달 창을 숨기고, modal('show')는 모달 창을 표시함
        $('#menuModal').modal('hide');
        $('#loginModal').modal('show');
    };

    // 랜덤 포스터 이미지를 설정하는 함수
    const images = [
        '/images/poster/우마무스메.png',
        '/images/poster/하이재킹v2.png',
        '/images/poster/핸섬가이즈_세로.png',
        '/images/poster/탈주세로v2.png',
        '/images/poster/하이재킹v3.png',
        '/images/poster/인사이드아웃v2.png'
    ];

    // 로그인 모달이 표시될 때 랜덤 포스터 이미지를 설정
    $('#loginModal').on('show.bs.modal', function() {
        // 이미지 배열에서 랜덤 이미지를 선택
        // show.bs.modal 이벤트는 Bootstrap의 모달 창이 열릴 때 발생하는 이벤트
        const randomImage = images[Math.floor(Math.random() * images.length)];
        // 선택된 이미지를 포스터 이미지 태그에 설정
        $('#posterImage').attr('src', randomImage);
    });

    // 로그인 폼 제출 함수 정의
    window.submitLoginForm = function() {
        // 폼 데이터 수집 (사용자가 입력한 아이디와 비밀번호를 수집)
        const formData = {
            mem_id: $("#mem_id").val(), // 사용자 아이디
            passwd: $("#passwd").val() // 사용자 비밀번호
        };

        // AJAX 요청으로 로그인 처리
        $.ajax({
            url: '/member/login', // 서버의 로그인 엔드포인트 (서버에서 특정 기능을 수행하기 위해 설정된 URL)
            type: 'POST', // HTTP 메서드
            contentType: 'application/json', // 요청 데이터 타입 (JSON 형태로 데이터를 전송)
            data: JSON.stringify(formData), // JSON(JavaScript Object Notation) 형태로 데이터 전송
            success: function(response) {
                if (response.success) {
                    // 로그인 성공 시 로그인 모달을 숨기고 로그인 상태 업데이트
                    $('#loginModal').modal('hide');
                    updateLoginStatus();
                } else {
                    // 로그인 실패 시 메시지 표시
                    alert('로그인 실패: ' + response.message);
                }
            },
            error: function(xhr) {
                // AJAX 요청 실패 시 오류 메시지 표시
                alert('로그인 실패: ' + JSON.stringify(xhr.responseJSON));
            }
        });
    };

    // 로그아웃 함수 정의
    function logout() {
        // 로그아웃 확인 다이얼로그 표시
        if (confirm('로그아웃 하시겠습니까?')) {
            // AJAX 요청으로 로그아웃 처리
            $.ajax({
                url: '/member/logout', // 서버의 로그아웃 엔드포인트
                type: 'GET', // HTTP 메서드
                success: function(response) {
                    if (response.success) {
                        // 로그아웃 성공 시 페이지 새로고침
                        location.reload();
                    } else {
                        // 로그아웃 실패 시 메시지 표시
                        alert('로그아웃 실패');
                    }
                },
                error: function(xhr) {
                    // AJAX 요청 실패 시 오류 메시지 표시
                    alert('로그아웃 실패: ' + JSON.stringify(xhr.responseJSON));
                }
            });
        }
    }

    // 로그인 상태 업데이트 함수 정의
    function updateLoginStatus() {
        // AJAX 요청으로 로그인 상태 확인
        $.ajax({
            url: '/member/status', // 서버의 로그인 상태 확인 엔드포인트
            type: 'GET', // HTTP 메서드
            success: function(response) {
                //로그인 상태에 따라 로그인/로그아웃 버튼 텍스트 및 동작 설정(상태에 따라 로그아웃 함수, 또는 showModal 함수 호출)
                const loginText = response.loggedIn ? '로그아웃' : '로그인';
                const loginAction = response.loggedIn ? logout : showLoginModal;

                //로그인 링크와 모달 로그인 버튼 텍스트 및 클릭 이벤트 설정
                $('#login-link, #modal-login-button').text(loginText).off('click').on('click', function(event) {
                    event.preventDefault();
                    loginAction();
                });
            },
            error: function(xhr, status, error) {
                // 로그인 상태 확인 실패 시 콘솔에 오류 메시지 출력
                console.error('로그인 상태 확인 실패: ', error);
            }
        });
    }

    // 페이지 로드 시 로그인 상태 확인
    updateLoginStatus();
});
