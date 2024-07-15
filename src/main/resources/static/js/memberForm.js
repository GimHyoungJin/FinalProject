$(document).ready(function() {
     
     //폼을 새로고침하거나, 새로 불러올경우 초기의 데이터가 모두 리셋
     function resetForm() {
        $('#mem_id').val('');
        $('#passwd').val('');
        $('#repasswd').val('');
        $('#username').val('');
        $('#email').val('');
        $('#phone').val('');
        $('#birth').val('');
        $('input[name="gender"]').prop('checked', false);
        $('#zipcode').val('');
        $('#address1').val('');
        $('#address2').val('');
        $('input[name="sms_agree"]').prop('checked', false);
        $('input[name="email_agree"]').prop('checked', false);
        // 모든 경고 메시지 초기화
        $('.invalid-feedback').text('').removeClass('text-danger text-success');
    }

    // 페이지 불러올 시 폼의 데이터를 모두 초기화
    resetForm();
    
    // DAUM 우편번호 API를 사용하는 함수 정의
    window.DaumPostcode = function() {
        // 새로운 daum.Postcode 객체를 생성하여 우편번호 검색 API를 연동
        new daum.Postcode({
            // 주소 검색이 완료되었을 때 호출되는 콜백 함수 정의
            oncomplete: function(data) {
                // 콜백 함수는 특정 작업이 완료되었을 때 실행되는 함수로 여기서는
                // 주소 검색이 완료되었을 때 실행되어 데이터를 처리한다.
                // 검색된 데이터를 이용해 우편번호와 주소 정보를 입력 필드에 설정함
                $('#zipcode').val(data.zonecode); // 검색 결과의 zonecode를 우편번호 필드에 설정
                $('#address1').val(data.roadAddress); // 검색 결과의 도로명 주소를 address1 필드에 설정
                $('#address2').val(data.jibunAddress || ''); // 검색 결과의 지번 주소를 address2 필드에 설정, 지번 주소가 없을 경우 빈 문자열 설정
                // 우편번호 모달을 숨김
                $('#postcodeModal').modal('hide');
            },
            width: '100%', // 우편번호 검색 API 창의 너비를 100%로 설정
            height: '100%' // 우편번호 검색 API 창의 높이를 100%로 설정
        }).embed($('#modalBody')[0]); // 모달 내의 modalBody 요소에 우편번호 API를 나타냄(embed)
        // embed는 API를 특정 HTML 요소 내에 삽입하여 표시하는 기능으로, 여기서는 우편번호 검색 창을 모달 창 내에 표시한다.
       

        // 우편번호 모달을 표시
        $('#postcodeModal').modal('show');
    };

    // 공통 AJAX 요청 함수 정의
    function checkAvailability(url, data, resultElement, availableMessage, duplicateMessage) {
        console.log('Checking availability:', url, data);  // 요청을 확인하기 위한 디버깅 메시지 추가
        // AJAX 요청 설정
        $.ajax({
            url: url, // 서버의 엔드포인트 URL
            type: 'POST', // HTTP 메서드 설정 (POST 요청) 요청명령어
            contentType: 'application/json', // 요청 데이터 타입 설정 (JSON 형식)
            data: JSON.stringify(data), // 데이터를 JSON 문자열로 변환하여 전송
            // AJAX 요청이 성공적으로 완료되었을 때 호출되는 콜백 함수
            success: function(response) {
                console.log('Response from', url, response);  // 응답을 확인하기 위한 디버깅 메시지 추가
                // 중복 여부에 따라 메시지 설정 및 스타일 변경
                const message = response.isDuplicate ? duplicateMessage : availableMessage; // 중복 여부에 따라 메시지 설정
                $(resultElement).text(message) // 메시지를 resultElement에 설정
                                .toggleClass('text-danger', response.isDuplicate) // 중복일 경우 text-danger 클래스 추가
                                .toggleClass('text-success', !response.isDuplicate); // 중복이 아닐 경우 text-success 클래스 추가
            },
            // AJAX 요청이 실패했을 때 호출되는 콜백 함수(데이터의 요청을 처리)
            error: function(xhr) {
                console.error('Error checking availability:', url, xhr);  // 오류를 확인하기 위한 디버깅 메시지 추가
                // 오류 메시지 표시
                $(resultElement).text('오류가 발생했습니다. 나중에 다시 시도하세요.') // 오류 메시지를 resultElement에 설정
                                .addClass('text-danger'); // text-danger 클래스 추가
            }
        });
    }
    // checkAvailability 함수는 중복 확인을 위해 AJAX 요청을 보냄
    // AJAX 요청은 비동기적으로 서버와 데이터를 주고받기 위한 방법으로
    // 해당 함수를 사용하여 아이디와 이메일의 중복을 확인하고, 결과를 사용자에게 실시간으로 알려줌.

    // 아이디 중복 확인 이벤트 핸들러
    $('#mem_id').on('input', function() {
        // 사용자가 mem_id 입력 필드에 값을 입력할 때마다 checkAvailability 함수를 호출하여 아이디 중복 확인
        checkAvailability(
            '/member/checkId', // 아이디 중복 확인 엔드포인트 
            { mem_id: $(this).val() }, // 요청 데이터로 사용자가 입력한 아이디 값 전송 - data와 매핑
            '#id-check-result', // 결과 메시지를 표시할 요소 - 콜백 함수 매핑
            '사용 가능한 아이디입니다.', // 요소에 아이디가 사용 가능한 경우 표시할 메시지 
            '이미 사용 중인 아이디입니다.' //요소에 아이디가 중복된 경우 표시할 메시지
        );
    });

    // 이메일 중복 확인 이벤트 핸들러
    $('#email').on('input', function() {
        const email = $(this).val(); // 사용자가 입력한 이메일 값을 가져옴
        // 이메일 형식 확인
        if (email.includes('@') && email.split('@')[1].includes('.')) {
            // 이메일 형식이 올바를 경우 checkAvailability 함수를 호출하여 이메일 중복 확인
            checkAvailability(
                '/member/checkEmail', // 이메일 중복 확인 엔드포인트
                { email: email }, // 요청 데이터로 사용자가 입력한 이메일 값 전송
                '#email-check-result', // 결과 메시지를 표시할 요소
                '사용 가능한 이메일입니다.', // 이메일이 사용 가능한 경우 표시할 메시지
                '이미 사용 중인 이메일입니다.' // 이메일이 중복된 경우 표시할 메시지
            );
        } else {
            // 유효하지 않은 이메일 형식 경고 메시지
            $('#email-check-result').text('올바른 이메일 주소를 입력해주세요.') // 경고 메시지를 resultElement에 설정
                                   .addClass('text-danger') // text-danger 클래스 추가
                                   .removeClass('text-success'); // text-success 클래스 제거
        }
    });

    // 비밀번호 일치 확인 이벤트 핸들러
    $('#repasswd').on('input', function() {
        const passwd = $('#passwd').val(); // 비밀번호 입력 필드의 값을 가져옴
        const repasswd = $(this).val(); // 비밀번호 확인 입력 필드의 값을 가져옴
        // 비밀번호 일치 여부 확인
        const message = passwd !== repasswd ? '비밀번호가 일치하지 않습니다.' : ''; // 비밀번호가 일치하지 않을 경우 경고 메시지 설정
        $('#password-check-result').text(message) // 경고 메시지를 resultElement에 설정
                                   .toggleClass('text-danger', passwd !== repasswd) // 비밀번호가 일치하지 않을 경우 text-danger 클래스 추가
                                   .toggleClass('text-success', passwd === repasswd); // 비밀번호가 일치할 경우 text-success 클래스 추가
    });

    // 생년월일 형식 변환 및 검증 이벤트 핸들러
    $('#birth').on('input', function() {
        // 입력값에서 숫자만 남기고 나머지 문자 제거
        const value = $(this).val().replace(/\D/g, ''); // 숫자가 아닌 문자 제거
        if (value.length === 8) {
            // 입력값이 8자리 숫자인 경우 YYYY.MM.DD 형식으로 변환
            const formattedValue = `${value.substring(0, 4)}.${value.substring(4, 6)}.${value.substring(6, 8)}`; // YYYY.MM.DD 형식으로 변환
            $(this).val(formattedValue); // 변환된 값을 입력 필드에 설정
        }
        // 생년월일 형식 유효성 검사
        const isValidDate = /^\d{4}\.\d{2}\.\d{2}$/.test($(this).val()); // YYYY.MM.DD 형식인지 확인
        const message = !isValidDate ? '생년월일은 YYYY.MM.DD 형식으로 입력해 주세요.' : ''; // 유효하지 않을 경우 경고 메시지 설정
        $('#birth-check-result').text(message) // 경고 메시지를 resultElement에 설정
                                .toggleClass('text-danger', !isValidDate) // 유효하지 않을 경우 text-danger 클래스 추가
                                .toggleClass('text-success', isValidDate); // 유효할 경우 text-success 클래스 추가
    });
    // 생년월일 형식 유효성 검사는 정확한 날짜 형식을 입력하도록 유도하여 잘못된 데이터 입력을 방지함

    // 이름 유효성 검사 이벤트 핸들러
    $('#username').on('input', function() {
        const username = $(this).val().trim(); // 입력값의 앞뒤 공백을 제거한 값을 가져옴
        // 이름 길이 유효성 검사
        const message = username.length < 2 ? '이름을 두 글자 이상 입력해 주세요.' : ''; // 이름이 두 글자 미만일 경우 경고 메시지 설정
        $('#name-check-result').text(message) // 경고 메시지를 resultElement에 설정
                               .toggleClass('text-danger', username.length < 2) // 이름이 두 글자 미만일 경우 text-danger 클래스 추가
                               .toggleClass('text-success', username.length >= 2); // 이름이 두 글자 이상일 경우 text-success 클래스 추가
    });
    // 이름 유효성 검사는 사용자 이름이 최소한 두 글자 이상이어야 한다는 조건을 만족하도록 함
 	
 	// 전화번호 중복 확인 및 유효성 검사 이벤트 핸들러
 	//전화번호에 대한 유효성 검사만 존재하던 이벤트 핸들러에 전화번호 중복확인에 대한 이벤트 핸들러를 포함함
    $('#phone').on('input', function() {
        const phone = $(this).val().replace(/\D/g, ''); // 입력값에서 숫자만 남기고 나머지 문자 제거
        let formattedPhone = '';
        if (phone.length > 10) {
            formattedPhone = `${phone.substring(0, 3)}-${phone.substring(3, 7)}-${phone.substring(7)}`; // 010-XXXX-XXXX 형식으로 변환
        } else if (phone.length > 6) {
            formattedPhone = `${phone.substring(0, 3)}-${phone.substring(3, 6)}-${phone.substring(6)}`; // 010-XXX-XXXX 형식으로 변환
        } else if (phone.length > 3) {
            formattedPhone = `${phone.substring(0, 3)}-${phone.substring(3)}`; // 010-XXX 형식으로 변환
        } else {
            formattedPhone = phone; // 그대로 유지
        }
        $(this).val(formattedPhone); // 변환된 값을 입력 필드에 설정

        // 전화번호 형식 유효성 검사
        const isValidPhone = /^\d{3}-\d{3,4}-\d{4}$/.test(formattedPhone); // 전화번호가 010-XXXX-XXXX 또는 010-XXX-XXXX 형식인지 확인
        const message = !isValidPhone ? '올바른 전화번호 형식이 아닙니다.' : ''; // 유효하지 않을 경우 경고 메시지 설정
        $('#phone-check-result').text(message) // 경고 메시지를 resultElement에 설정
                               .toggleClass('text-danger', !isValidPhone) // 유효하지 않을 경우 text-danger 클래스 추가
                               .toggleClass('text-success', isValidPhone); // 유효할 경우 text-success 클래스 추가

        if (isValidPhone) {
            // 전화번호 형식이 올바를 경우 중복 확인
            checkAvailability(
                '/member/checkPhone', // 전화번호 중복 확인 엔드포인트
                { phone: formattedPhone }, // 요청 데이터로 사용자가 입력한 전화번호 값 전송
                '#phone-check-result', // 결과 메시지를 표시할 요소
                '사용 가능한 전화번호입니다.', // 전화번호가 사용 가능한 경우 표시할 메시지
                '이미 존재하는 전화번호입니다.' // 전화번호가 중복된 경우 표시할 메시지
            );
        }
    });

    //유효성 검사 함수 정의
    //validateField 함수로 각 필드의 유효성을 검사하고, 실패 시 오류 메시지를 표시함과 동시에 해당 필드에 포커스(커서)를 이동함.
    function validateField(field, check, messageElement, errorMessage) {
        if (!check()) {
            // 유효성 검사 실패 시 메시지 및 포커스 설정
            $(messageElement).text(errorMessage) // 오류 메시지를 resultElement에 설정
                             .addClass('text-danger') // text-danger 클래스 추가
                             .removeClass('text-success'); // text-success 클래스 제거
            $(field).focus(); // 해당 필드에 포커스 설정
            return false; // 유효성 검사 실패 반환
        }
        return true; // 유효성 검사 성공 반환
    }
    

    // 회원가입 폼 제출 함수 정의
    window.submitForm = function() {
        console.log('Submitting form...');  // 폼 제출을 확인하기 위한 디버깅 메시지 추가
        // 유효성 검사 목록
        const validations = [
            { field: '#mem_id', check: () => !$('#id-check-result').hasClass('text-danger'), messageElement: '#id-check-result', errorMessage: '아이디를 확인해 주세요.' },
            { field: '#email', check: () => !$('#email-check-result').hasClass('text-danger'), messageElement: '#email-check-result', errorMessage: '이메일을 확인해 주세요.' },
            {	
				//비밀번호에 대한 유효성 검사
                field: '#passwd',
                check: () => {
                    const passwd = $('#passwd').val().trim(); // 비밀번호 입력 필드의 값을 가져옴
                    return passwd.length >= 5 && passwd.length <= 15; // 비밀번호가 5~15 글자 이내인지 확인
                },
                messageElement: '#password-check-result',
                errorMessage: '비밀번호는 5~15 글자 이내로 입력해 주세요'
            },
            {	
				//비밀번호 재확인 유효성검사
                field: '#repasswd',
                check: () => $('#passwd').val().trim() === $('#repasswd').val().trim(), // 비밀번호와 비밀번호 확인 입력값이 일치하는지 확인
                messageElement: '#password-check-result',
                errorMessage: '비밀번호가 일치하지 않습니다.'
            },
            {	//이름에 대한 유효성 검사
                field: '#username',
                check: () => $('#username').val().trim().length >= 2, // 이름이 두 글자 이상인지 확인
                messageElement: '#name-check-result',
                errorMessage: '이름을 두 글자 이상 입력해 주세요.'
            },
            {	//생년월일에 대한 유효성 검사
                field: '#birth',
                check: () => /^\d{4}\.\d{2}\.\d{2}$/.test($('#birth').val().trim()), // 생년월일 형식이 YYYY.MM.DD인지 확인
                messageElement: '#birth-check-result',
                errorMessage: '생년월일은 YYYY.MM.DD 형식으로 입력해 주세요.'
            },
            {
				//전화번호에 대한 유효성 검사로 전화번호 형식 및 전화번호 중복에 대한 검사
              	field: '#phone',
              	//텍스트를 출력하는 phone-check-result 요소에 text-danger 클래스가 없고, 전화번호 형식이 올바른지 검사한다.
              	//그리고 전화번호 형식이 010-XXX-XXXX, 010-XXXX-XXXX의 형식인지 검사함
		        check: () => !$('#phone-check-result').hasClass('text-danger') && /^\d{3}-\d{3,4}-\d{4}$/.test($('#phone').val().trim()),
		        messageElement: '#phone-check-result',
		        errorMessage: '올바른 전화번호 형식이 아니거나 중복된 전화번호입니다.'
            }
        ];

        // 유효성 검사 실행
        for (const { field, check, messageElement, errorMessage } of validations) {
            if (!validateField(field, check, messageElement, errorMessage)) {
                console.log('Validation failed:', field, errorMessage);  // 유효성 검사 실패를 확인하기 위한 디버깅 메시지 추가
                return false; // 유효성 검사 실패 반환
            }
        }

        // 폼 데이터 수집
        const formData = {
            mem_id: $('#mem_id').val().trim(), // 아이디 입력 필드의 값을 가져옴
            passwd: $('#passwd').val().trim(), // 비밀번호 입력 필드의 값을 가져옴
            username: $('#username').val().trim(), // 이름 입력 필드의 값을 가져옴
            email: $('#email').val().trim(), // 이메일 입력 필드의 값을 가져옴
            phone: $('#phone').val().trim(), // 전화번호 입력 필드의 값을 가져옴
            birth: $('#birth').val().trim(), // 생년월일 입력 필드의 값을 가져옴
            gender: $('input[name="gender"]:checked').val(), // 성별 라디오 버튼에서 선택된 값을 가져옴
            zipcode: $('#zipcode').val().trim(), // 우편번호 입력 필드의 값을 가져옴
            address1: $('#address1').val().trim(), // 주소1 입력 필드의 값을 가져옴
            address2: $('#address2').val().trim(), // 주소2 입력 필드의 값을 가져옴
            sms_agree: $('input[name="sms_agree"]:checked').val(), // SMS 수신 동의 체크박스의 값을 가져옴
            email_agree: $('input[name="email_agree"]:checked').val() // 이메일 수신 동의 체크박스의 값을 가져옴
        };

        console.log('Form data:', formData);  // 수집된 폼 데이터를 확인하기 위한 디버깅 메시지 추가

        // AJAX 요청으로 회원가입 처리
        $.ajax({
            url: '/member/register', // 회원가입 엔드포인트
            type: 'POST', // HTTP 메서드 설정 (POST 요청)
            contentType: 'application/json', // 요청 데이터 타입 설정 (JSON 형식)
            data: JSON.stringify(formData), // 데이터를 JSON 문자열로 변환하여 전송
            success: function(response) {
                console.log('Response from register:', response);  // 응답을 확인하기 위한 디버깅 메시지 추가
                if (response.success) {
                    // 회원가입 성공 시 성공 페이지로 이동
                    window.location.href = '/member/success';
                } else {
                    // 회원가입 실패 시 오류 메시지 표시
                    alert('회원가입에 실패하였습니다 : ' + response.message);
                }
            },
            error: function(xhr) {
                console.error('Error registering:', xhr);  //오류를 확인하기 위한 디버깅 메시지 추가
                alert('오류가 발생했습니다. 나중에 다시 시도하세요.');
            }
        });
    };
});
