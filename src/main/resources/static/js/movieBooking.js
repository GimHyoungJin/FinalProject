$(document).ready(function () {
    // 변수 초기화
    let selectedCategory = ''; // 선택된 인원 카테고리
    let totalPersons = { adult: 0, teen: 0, child: 0 }; // 각 카테고리별 인원 수 초기화
    let selectedSeats = { adult: [], teen: [], child: [] }; // 각 카테고리별 선택된 좌석 초기화
    const seatPrices = { adult: 100, teen: 100, child: 100 }; // 각 카테고리별 좌석 가격 설정
    const categoryNames = { adult: '성인', teen: '청소년', child: '아동' }; // 카테고리별 이름 설정
    let reservationId = null; // 예약 ID 초기화
    let paymentId = null;  // 결제 ID 초기화

    // 좌석 ID에서 행과 열을 추출하는 함수
    function getSeatPosition(seatId) {
        const match = seatId.match(/([A-Z]+)(\d+)/); // 좌석 ID에서 행(A-Z)과 열(숫자)을 추출
        return match ? { row: match[1], col: parseInt(match[2], 10) } : null; // 추출된 행과 열을 객체로 반환
    }

    // 지정된 좌석 ID와 인원 수를 기반으로 인접 좌석을 계산하는 함수
    function getAdjacentSeats(seatId, count, maxCols) {
        const position = getSeatPosition(seatId); // 좌석의 행과 열을 추출
        if (!position) return []; // 유효하지 않은 좌석 ID일 경우 빈 배열 반환
        const { row, col } = position; // 추출된 행과 열을 각각 row, col 변수에 저장
        const seats = []; // 인접 좌석을 저장할 배열

        seats.push(`${row}${col}`); // 선택한 좌석을 포함

        // 좌측 방향으로 인접 좌석 계산
        for (let i = 1; i < count; i++) {
            const currentCol = col - i; // 현재 열에서 i만큼 감소
            if (currentCol > 0) {
                seats.unshift(`${row}${currentCol}`); // 좌석을 배열의 앞에 추가
                if (seats.length === count) return seats;  // 필요한 좌석 수가 충족되면 배열 반환
            } else {
                break; // 유효하지 않은 좌석일 경우 반복문 종료
            }
        }

        // 우측 방향으로 인접 좌석 계산
        for (let i = 1; seats.length < count; i++) {
            const currentCol = col + i; // 현재 열에서 i만큼 증가
            if (currentCol <= maxCols) {
                seats.push(`${row}${currentCol}`); // 좌석을 배열의 뒤에 추가
                if (seats.length === count) return seats;  // 필요한 좌석 수가 충족되면 배열 반환
            } else {
                break; // 유효하지 않은 좌석일 경우 반복문 종료
            }
        }

        // 좌석 수가 부족할 경우 빈 배열 반환
        return seats.length === count ? seats : [];
    }

    // 인접 좌석을 'unavailable' 클래스로 표시하는 함수
    function markUnavailableSeats(seatId, count, maxCols) {
        const adjacentSeats = getAdjacentSeats(seatId, count, maxCols); // 인접 좌석 계산
        for (let seat of adjacentSeats) {
            const seatElement = $(`.seat[data-seat='${seat}']`); // 좌석 요소 선택
            if (!seatElement.hasClass('reserved') && !seatElement.hasClass('selected')) {
                seatElement.addClass('unavailable'); // 인접 좌석을 'unavailable' 클래스로 표시
            }
        }
    }

    // 모든 좌석에서 'unavailable' 클래스를 제거하는 함수
    function unmarkUnavailableSeats() {
        $('.seat').removeClass('unavailable'); // 모든 좌석에서 'unavailable' 클래스를 제거
    }

    // 선택된 좌석을 표시하고 총 가격을 업데이트하는 함수
    function updateSelectedSeatsDisplay() {
        let allSelectedSeats = selectedSeats.adult.concat(selectedSeats.teen, selectedSeats.child); // 모든 선택된 좌석을 하나의 배열로 합침
        $('#selectedSeats').val(allSelectedSeats.join(',')); // 선택된 좌석을 숨겨진 필드에 저장
        $('#selectedSeatsDisplay').text(allSelectedSeats.join(', ')); // 선택된 좌석을 표시
        updateTotalPrice(); // 총 가격 업데이트
    }

    // 선택된 좌석 수에 따라 총 가격을 계산하는 함수
    function updateTotalPrice() {
        let totalPrice = 0; // 총 가격 초기화
        for (const category in selectedSeats) {
            const count = selectedSeats[category].length; // 카테고리별 선택된 좌석 수
            totalPrice += count * seatPrices[category]; // 각 카테고리의 선택된 좌석 수에 따라 총 가격 계산
        }
        $('#totalPrice').text(totalPrice.toLocaleString() + '원'); // 총 가격을 표시
    }

    // 선택된 인원 수를 업데이트하는 함수
    function updateTotalPersons() {
        const totalCount = totalPersons.adult + totalPersons.teen + totalPersons.child; // 총 인원 수 계산
        $('#totalPersons').text(totalCount + '명'); // 총 인원 수를 표시
    }

    // 모든 좌석의 선택 상태를 초기화하는 함수
    function resetSeatSelection() {
        $('.seat').removeClass('selected'); // 모든 좌석의 'selected' 클래스를 제거
        selectedSeats.adult.forEach(seat => $(`.seat[data-seat='${seat}']`).addClass('selected')); // 성인 좌석 선택 상태 표시
        selectedSeats.teen.forEach(seat => $(`.seat[data-seat='${seat}']`).addClass('selected')); // 청소년 좌석 선택 상태 표시
        selectedSeats.child.forEach(seat => $(`.seat[data-seat='${seat}']`).addClass('selected')); // 아동 좌석 선택 상태 표시
    }

    // 좌석 클릭 이벤트 핸들러
    $('.seat').on('click', function () {
        if ($(this).hasClass('reserved') || $(this).hasClass('unavailable')) {
            return; // 예약되었거나 사용할 수 없는 좌석인 경우 아무 작업도 수행하지 않음
        }

        if (!selectedCategory) {
            alert("인원 카테고리를 먼저 선택하세요.");
            return; // 인원 카테고리가 선택되지 않은 경우 경고 메시지 표시
        }

        const seatId = $(this).data('seat'); // 클릭한 좌석의 ID
        unmarkUnavailableSeats(); // 모든 좌석에서 'unavailable' 클래스를 제거

        let categorySeats = selectedSeats[selectedCategory]; // 현재 선택된 카테고리의 좌석 배열

        if (categorySeats.includes(seatId)) {
            selectedSeats[selectedCategory] = []; // 이미 선택된 좌석인 경우 모든 좌석 선택 해제
        } else {
            const adjacentSeats = getAdjacentSeats(seatId, totalPersons[selectedCategory], 10); // 인접 좌석 계산
            const invalidSeat = adjacentSeats.find(seat => $(`.seat[data-seat='${seat}']`).hasClass('reserved') || $(`.seat[data-seat='${seat}']`).hasClass('selected'));

            if (invalidSeat || adjacentSeats.length < totalPersons[selectedCategory]) {
                alert(`${categoryNames[selectedCategory]} 인원 수만큼 좌석을 선택할 수 없습니다.`);
                markUnavailableSeats(seatId, totalPersons[selectedCategory], 10);
                return; // 인접 좌석이 예약되었거나 사용할 수 없는 경우 경고 메시지 표시
            }

            const allSelectedSeatsCount = selectedSeats.adult.length + selectedSeats.teen.length + selectedSeats.child.length + adjacentSeats.length - categorySeats.length;
            if (allSelectedSeatsCount > 6) {
                alert("최대 인원은 6명까지입니다.");
                return; // 최대 인원 수를 초과한 경우 경고 메시지 표시
            }

            selectedSeats[selectedCategory] = adjacentSeats; // 선택된 카테고리의 인접 좌석을 저장
        }

        resetSeatSelection(); // 모든 좌석의 선택 상태 초기화
        updateSelectedSeatsDisplay(); // 선택된 좌석을 표시하고 총 가격 업데이트
        checkSelectionComplete(); // 모든 선택이 완료되었는지 확인
    });

    // 좌석에 마우스를 올렸을 때 인접 좌석을 표시하는 이벤트 핸들러
    $('.seat').on('mouseenter', function () {
        if ($(this).hasClass('reserved') || $(this).hasClass('selected')) {
            return; // 예약되었거나 선택된 좌석인 경우 아무 작업도 수행하지 않음
        }

        if (!selectedCategory) {
            return; // 인원 카테고리가 선택되지 않은 경우 아무 작업도 수행하지 않음
        }

        const seatId = $(this).data('seat'); // 마우스를 올린 좌석의 ID
        unmarkUnavailableSeats(); // 모든 좌석에서 'unavailable' 클래스를 제거
        const adjacentSeats = getAdjacentSeats(seatId, totalPersons[selectedCategory], 10); // 인접 좌석 계산
        const invalidSeat = adjacentSeats.find(seat => $(`.seat[data-seat='${seat}']`).hasClass('reserved') || $(`.seat[data-seat='${seat}']`).hasClass('selected'));

        if (invalidSeat || adjacentSeats.length < totalPersons[selectedCategory]) {
            markUnavailableSeats(seatId, totalPersons[selectedCategory], 10); // 인접 좌석이 예약되었거나 사용할 수 없는 경우 'unavailable' 클래스를 추가
        }
    });

    // 좌석에서 마우스를 뗐을 때 인접 좌석 표시를 제거하는 이벤트 핸들러
    $('.seat').on('mouseleave', function () {
        unmarkUnavailableSeats(); // 모든 좌석에서 'unavailable' 클래스를 제거
    });

    // 인원 선택 버튼 클릭 이벤트 핸들러
    $('.person-select button').on('click', function () {
        const category = $(this).data('category'); // 클릭한 버튼의 카테고리
        const count = parseInt($(this).text(), 10); // 클릭한 버튼의 인원 수

        if (totalPersons[category] === count) {
            totalPersons[category] = 0; // 이미 선택된 인원 수인 경우 0으로 초기화
            selectedSeats[category] = []; // 해당 카테고리의 선택된 좌석 초기화
            $(this).removeClass('selected'); // 버튼에서 'selected' 클래스 제거
        } else {
            const totalSelectedPersons = totalPersons.adult + totalPersons.teen + totalPersons.child; // 총 선택된 인원 수 계산
            const newTotal = totalSelectedPersons - totalPersons[category] + count; // 새로운 총 인원 수 계산

            if (newTotal > 6) {
                alert("총 인원은 최대 6명까지만 선택할 수 있습니다.");
                return; // 최대 인원 수를 초과한 경우 경고 메시지 표시
            }

            $(`.person-select button[data-category="${category}"]`).removeClass('selected'); // 해당 카테고리의 모든 버튼에서 'selected' 클래스 제거
            $(this).addClass('selected'); // 클릭한 버튼에 'selected' 클래스 추가
            totalPersons[category] = count; // 해당 카테고리의 인원 수 업데이트
            selectedCategory = category; // 선택된 카테고리 저장
        }

        updateTotalPersons(); // 총 인원 수 업데이트
        resetSeatSelection(); // 모든 좌석의 선택 상태 초기화
        updateSelectedSeatsDisplay(); // 선택된 좌석을 표시하고 총 가격 업데이트
        checkSelectionComplete(); // 모든 선택이 완료되었는지 확인
    });

    // 모든 선택이 완료되었는지 확인하는 함수
    function checkSelectionComplete() {
        let allComplete = true; // 모든 선택이 완료되었는지 여부 초기화
        for (const category in totalPersons) {
            if (totalPersons[category] !== selectedSeats[category].length) {
                allComplete = false; // 선택된 인원 수와 선택된 좌석 수가 일치하지 않는 경우
                break;
            }
        }
        if (allComplete) {
            $('.person-select button').removeClass('disabled'); // 모든 버튼에서 'disabled' 클래스 제거
            $('#paymentButton').removeClass('disabled').css('background-color', 'red'); // 결제 버튼 활성화 및 빨간색으로 변경
        } else {
            $('.person-select button').addClass('disabled'); // 모든 버튼에 'disabled' 클래스 추가
            $(`.person-select button[data-category="${selectedCategory}"]`).removeClass('disabled'); // 선택된 카테고리의 버튼에서 'disabled' 클래스 제거
            $('#paymentButton').addClass('disabled').css('background-color', '#343433'); // 결제 버튼 비활성화 및 원래 색상으로 변경
        }
    }

    // 좌석 상태를 서버에서 가져오는 함수
    function fetchSeatStatus() {
        $.ajax({
            url: '/reservation/seatStatus', // 좌석 상태를 가져오는 엔드포인트
            method: 'GET', // GET 요청
            success: function (response) {
                for (let seat in response) {
                    if (response[seat]) {
                        $(`.seat[data-seat='${seat}']`).addClass('reserved'); // 예약된 좌석 표시
                    } else {
                        $(`.seat[data-seat='${seat}']`).removeClass('reserved'); // 예약되지 않은 좌석 표시
                    }
                }
            },
            error: function (error) {
                console.error('Error fetching seat status:', error); // 좌석 상태 가져오기 실패 시 오류 메시지 표시
            }
        });
    }

    // UUID 생성 및 예약 ID 초기화
    function generateUUID() {
        return $.ajax({
            url: '/reservation/generateUUID', // UUID를 생성하는 엔드포인트
            method: 'GET', // GET 요청
            success: function (uuid) {
                reservationId = uuid; // 예약 ID 초기화
            },
            error: function (error) {
                console.error('Error generating UUID:', error); // UUID 생성 실패 시 오류 메시지 표시
            }
        });
    }

    // 결제 UUID 생성 및 결제 ID 초기화
    function generatePaymentUUID() {
        return $.ajax({
            url: '/reservation/generateUUID', // UUID를 생성하는 엔드포인트
            method: 'GET', // GET 요청
            success: function (uuid) {
                paymentId = uuid; // 결제 ID 초기화
            },
            error: function (error) {
                console.error('Error generating UUID:', error); // UUID 생성 실패 시 오류 메시지 표시
            }
        });
    }

    // 결제 버튼 클릭 이벤트 핸들러
    $('#paymentButton').on('click', function () {
        if ($(this).hasClass('disabled')) {
            return; // 버튼이 비활성화된 경우 아무 작업도 수행하지 않음
        }

        // 아임포트 결제 초기화
        IMP.init('imp20583321'); // 가맹점 식별코드

        // 총 결제 금액 계산
        let totalAmount = parseInt($('#totalPrice').text().replace(/[^0-9]/g, '')); // 총 금액에서 숫자만 추출하여 정수로 변환

        // 아임포트 결제 요청
        IMP.request_pay({
            pg: 'html5_inicis', // PG사
            pay_method: 'card', // 결제 방식
            merchant_uid: 'merchant_' + new Date().getTime(), // 가맹점에서 생성한 고유 주문번호
            name: '영화 예매', // 결제창에서 보여질 상품명
            amount: totalAmount, // 결제 금액
            buyer_email: memberInfo.email, // 구매자 이메일
            buyer_name: memberInfo.name, // 구매자 이름
            buyer_tel: memberInfo.phone, // 구매자 전화번호
        }, function (rsp) { // callback
            if (rsp.success) {
                // 결제 성공 시 예약 정보 저장
                saveReservation(rsp);
            } else {
                // 결제 실패 시
                alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
            }
        });
    });

    // 예약 정보를 저장하는 함수
    function saveReservation(paymentResponse) {
        const reservationData = {
            res_id: reservationId, // 고유 ID 생성 로직 필요
            //mem_id: '${member.mem_id}', // 회원 ID
            //screen_movie_id: '${screenMovieId}', // 화면에서 가져올 정보 필요
            res_seat_info: $('#selectedSeatsDisplay').text(), // 선택된 좌석 정보
            adult: totalPersons.adult, // 성인 인원 수
            teenager: totalPersons.teen, // 청소년 인원 수
            child: totalPersons.child, // 아동 인원 수
            tot_people: totalPersons.adult + totalPersons.teen + totalPersons.child // 총 인원 수
        };

        $.ajax({
            url: '/reservation/save', // 예약 정보를 저장하는 엔드포인트
            method: 'POST', // POST 요청
            contentType: 'application/json', // 요청 데이터 타입 설정
            data: JSON.stringify(reservationData), // 예약 데이터를 JSON 형식으로 변환하여 전송
            success: function (resId) {
                // 예약 정보 저장 후 결제 정보 저장
                savePayment(resId, paymentResponse);
            },
            error: function (error) {
                console.error('Error saving reservation:', error); // 예약 정보 저장 실패 시 오류 메시지 표시
                alert('예약 처리 중 오류가 발생하였습니다.');
            }
        });
    }

    // 결제 정보를 저장하는 함수
    function savePayment(resId, paymentResponse) {
        const paymentData = {
            pay_id: paymentId, // 고유 ID 생성 로직 필요
            res_id: resId, // 예약 ID
            imp_uid: paymentResponse.imp_uid, // 아임포트 고유 결제 ID
            mer_uid: paymentResponse.merchant_uid, // 가맹점 고유 주문번호
            pay_method: paymentResponse.pay_method, // 결제 방식
            tot_price: parseInt($('#totalPrice').text().replace(/[^0-9]/g, '')), // 총 결제 금액
            pay_status: 'Y', // 결제 상태
            card_information: paymentResponse.card_name // 결제 카드 정보
        };

        $.ajax({
            url: '/reservation/payment/save', // 결제 정보를 저장하는 엔드포인트
            method: 'POST', // POST 요청
            contentType: 'application/json', // 요청 데이터 타입 설정
            data: JSON.stringify(paymentData), // 결제 데이터를 JSON 형식으로 변환하여 전송
            success: function (response) {
                console.log(response); // 성공 응답 로그 출력
                alert('예약 및 결제가 성공적으로 완료되었습니다.'); // 성공 메시지 표시
                window.location.href = '/payment/success'; // 결제 성공 페이지로 이동
            },
            error: function (error) {
                console.error('Error saving payment:', error); // 결제 정보 저장 실패 시 오류 메시지 표시
                alert('결제 처리 중 오류가 발생하였습니다.');
            }
        });
    }

    // 페이지 로드 시 UUID 생성
    generateUUID().then(fetchSeatStatus); // UUID 생성 후 좌석 상태 가져오기

    // 결제 UUID 생성
    generatePaymentUUID();

    // 주기적으로 좌석 상태를 업데이트
    setInterval(fetchSeatStatus, 1000); // 1초마다 좌석 상태 업데이트
});
