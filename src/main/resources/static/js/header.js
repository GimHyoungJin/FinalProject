   // 로그인 모달 열기 함수 정의
    window.showLoginModal = function() {
        $('#menuModal').modal('hide'); //모달창 숨김
        $('#loginModal').modal('show'); //모달창 보임
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

    // 로그인 모달이 표시될 때 랜덤 포스터 이미지를 설정하는 함수
    $('#loginModal').on('show.bs.modal', function() {
        const randomImage = images[Math.floor(Math.random() * images.length)];
        $('#posterImage').attr('src', randomImage);
    });
              
    // 로그인 상태 체크 함수 정의
    function checkLogin(event) {
        event.preventDefault(); // 기본 이벤트 동작을 막음, 막는 이유 : 체크 하기 전에 mypage로 이동하면 안되기 때문
        
        // ajax 요청을 통해 서버에 로그인 상태를 확인
        $.ajax({
            url: '/member/status',
            type: 'GET',
            success: function(response) {
                // 서버로 부터 응답이 성공적일 때 실행, 응답은 JSON 형태로 {loggedIn: true/false}를 포함함
                // 만약 성공적으로 로그인이 되었다면 클릭했던 링크로 이동한다.
                if (response.loggedIn) {
                    window.location.href = event.target.href; // 클릭된 링크로 이동하는 href 속성
                } else {
                    // 로그인 상태가 아닐시 로그인 모달창을 보여줌
                    showLoginModal();
                }
            },
            error: function(error) {
                // 서버로 부터 응답이 실패했다면 오류 메시지 출력
                console.error('로그인 상태 확인 실패: ', error);
            }
        });
    }

    // MyPage 링크들에 각각 클릭 이벤트 추가함과 동시에 checkLogin 함수를 호출해 로그인 상태를 확인
    $('#mypage-home-link, #bookinglist-link, #store-vouchers-link, #coupons-link, #my-inquiries-link, #profile-link, #reserve-link, #quick-reserve-modal-link, #quick-reserve-link, #admin-link, #reserve-link2, #reserve-link3, #reservation-logo-link, #btn btn-boo').on('click', checkLogin);

    // 로그인 폼 제출 함수로 사용자의 로그인 정보를 서버로 전송하고 성공시 로그인 모달을 숨기고 상태를 업데이트 한다.
    window.submitLoginForm = function() {
        const formData = {
            mem_id: $("#mem_id").val(),
            passwd: $("#passwd").val()
        };

        // ajax를 이용한 로그인 정보 전송
        $.ajax({
            url: '/member/login', // 로그인을 처리하는 엔드포인트(서버)
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData), // 폼데이터를 Json 형식으로 변환해 전송한다.
            success: function(response) {
                // 응답이 성공적일 경우 모달창을 숨기고
                if (response.success) {
                    $('#loginModal').modal('hide');
                    loginStatus(true); // 로그인 후 상태 업데이트 시 새로고침
                } else {
                    // 실패시 알림
                    alert('로그인 실패: ' + response.message);
                }
            },
            error: function(xhr) {
                // 로그인 실패시 오류 메세지를 출력함
                alert('로그인 실패: ' + JSON.stringify(xhr.responseJSON));
            }
        });
    };

    // 로그아웃 함수로 confirm 창을 통해 로그아웃 할지 안할지를 선택함(확인, 취소)
    function logout() {
        if (confirm('로그아웃 하시겠습니까?')) {
            $.ajax({
                url: '/member/logout', // logout을 처리하는 엔드포인트(서버)
                type: 'GET',
                success: function(response) {
                    if (response.success) {
                        window.location.href = '/main';
                    } else {
                        alert('로그아웃 실패'); // 로그아웃 실패시 메시지
                    }
                },
                error: function(xhr) { // 로그아웃 실패시 에러메세지
                    alert('로그아웃 실패: ' + JSON.stringify(xhr.responseJSON));
                }
            });
        }
    }

	// 로그인 상태 업데이트 함수
	function loginStatus(refresh) {
	    $.ajax({
	        url: '/member/status',
	        type: 'GET',
	        success: function(response) {
	            const loginText = response.loggedIn ? '로그아웃' : '로그인'; // 로그인 상태에 따라 버튼의 텍스트가 변경됨
	            const loginAction = response.loggedIn ? logout : showLoginModal; // 로그인 상태에 따른 버튼 동작을 설정함
	            
	            // 로그인, 로그아웃의 버튼 텍스트와 동작을 설정한다.
	            $('#login-link, #modal-login-button').text(loginText).off('click').on('click', function(event) {
	                event.preventDefault();
	                loginAction();
	            });
	
	            // 관리자 여부 확인 및 버튼 표시
	            $('.admin-button-container').each(function() {
	                if (response.loggedIn && response.isAdmin) {
	                    $(this).show();
	                } else {
	                    $(this).hide();
	                }
	            });
	
	            if (refresh) {
	                location.reload(); // 로그인 상태에 변화가 있으면 페이지 새로고침
	            }
	        },
	        error: function(error) {
	            console.error('로그인 상태 확인 실패: ', error);
	        }
	    });
	}

    // 페이지 로드 시 로그인 상태 확인
    loginStatus();

    // 카카오 SDK 초기화 및 카카오 로그인 처리 추가
    // 실제 사용되는 JavaScript SDK 키로 클라이언트 애플리케이션을 식별하는데 사용됨(의도된 동작)
    // 보안상 민감한 데이터만 Controller 같은 서버에서 처리하면 된다.
    Kakao.init('4b552ed83497cd04c4b444d7119643ce');

    // 카카오 로그인 버튼 클릭 이벤트 리스너, 클릭이벤트 발생시 카카오 로그인 함수가 호출됨
    document.getElementById('kakaobtn').addEventListener('click', function() {
        kakaoLogin();
    });

    // 카카오 로그인 함수 
    function kakaoLogin() {
        // 카카오 로그인 API 호출 : 로그인 팝업창을 여기서 호출함
        Kakao.Auth.login({
            success: function(authObj) {
                // 로그인 성공 시, authObj에 액세스 토큰이 포함됨
                // 액세스 토큰을 사용하여 사용자 정보 요청
                Kakao.API.request({
                    url: '/v2/user/me', // 사용자 정보 요청 URL
                    success: function(response) {
                        // 사용자 정보 요청이 성공하면, 서버로 사용자 정보 전달 준비
                        var xhr = new XMLHttpRequest();
                        xhr.open("POST", "/member/kakaoLogin", true); // 서버의 로그인 처리 URL
                        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                        xhr.onreadystatechange = function() {
                            // 서버 응답 처리
                            if (xhr.readyState === 4 && xhr.status === 200) {
                                var result = JSON.parse(xhr.responseText); // 서버 응답을 JSON으로 파싱
                                if (result.success) {
                                    // 로그인 성공 시, 페이지 새로고침
                                    location.reload();
                                } else {
                                    // 로그인 실패 시, 알림
                                    alert("로그인에 실패했습니다. 다시 시도해 주세요.");
                                }
                            }
                        };
                        // 서버로 사용자 정보 및 액세스 토큰 전송
                        xhr.send(JSON.stringify({
                            accessToken: authObj.access_token, // 카카오에서 받은 액세스 토큰
                            user: response // 카카오에서 받은 사용자 정보
                        }));
                    },
                    fail: function(error) {
                        // 사용자 정보 요청 실패 시, 알림
                        alert("사용자 정보를 가져오는데 실패했습니다: " + JSON.stringify(error));
                    }
                });
            },
            fail: function(error) {
                // 로그인 실패 시, 알림
                alert("로그인에 실패했습니다: " + JSON.stringify(error));
            }
        });
    }

    // 구글 api 로그인
    // Google Identity Services (GIS) JavaScript 라이브러리에서 사용하는 콜백 함수
    function handleCredentialResponse(response) {
        $.ajax({
            type: 'POST',
            url: '/member/googleLogin',
            contentType: 'application/json',
            data: JSON.stringify({ token: response.credential }),
            success: function(data) {
                if (data.success) {
                    location.reload(); // 로그인 성공 시 페이지 새로고침
                } else {
                    console.error('로그인에 실패하였습니다:', data.message); // 실패 시 서버에서 반환된 메시지 출력
                    alert('로그인에 실패하였습니다: ' + data.message); // 실패 시 경고창 표시
                }
            },
            // 에러 발생 시 경고창 표시
            error: function(error) {
                console.error('Error:', error);
                alert('로그인 과정에서 오류가 발생하였습니다.');
            }
        });
    }

    // 페이지의 모든 리소스(이미지, js, css 등)이 모두 로드된 후 실행함
    window.onload = function() {
        // initialize 메소드를 이용해 Google Identitiy Service를 초기화한 뒤, 클라이언트 ID를 사용하여 google 인증 서비스를 사용할 수 있게 하고,
        // 정상적으로 사용자 인증이 완료되었습니다. 그 과정을 처리할 콜백함수를 지정한 뒤 서버로 데이터를 전송함.
        google.accounts.id.initialize({
            client_id: "1051773193513-6ue0j504qgi80d191t7si0bpoahig155.apps.googleusercontent.com",
            callback: handleCredentialResponse // 사용자 인증이 완료되었을 경우, 콜백함수
        });

        // renderButton을 이용해 커스텀 구글 로그인 버튼을 g_id_signin이라는 이름의 class를 가진 div에 생성
        google.accounts.id.renderButton(
            document.querySelector(".g_id_signin"),
            { theme: "outline", size: "large" }  // 커스텀 구글 로그인 버튼 생성
        );
        google.accounts.id.prompt(); // onTapdialog라는 프롬프트 창을 생성하는 메소드
    }

