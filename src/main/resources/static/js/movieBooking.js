$(document).ready(function () {
    // 변수 초기화
    let selectedCategory = '';
    let totalPersons = { adult: 0, teen: 0, child: 0 };
    let selectedSeats = { adult: [], teen: [], child: [] };
    const seatPrices = { adult: 100, teen: 100, child: 100 };
    const categoryNames = { adult: '성인', teen: '청소년', child: '아동' };
    let reservationId = null;
    let paymentId = null;

    // WebSocket 초기화
    const socket = new WebSocket("ws://" + window.location.host + "/ws");

    socket.onopen = function(event) {
        console.log("WebSocket is connected.");
    };

    socket.onmessage = function (event) {
        const data = JSON.parse(event.data);
        const seatId = data.seatId;
        const isReserved = data.isReserved;

        const seatElement = $(`.seat[data-seat='${seatId}']`);
        if (isReserved) {
            seatElement.addClass('reserved');
        } else {
            seatElement.removeClass('reserved');
        }
        updateRemainingSeats();
    };

    // 좌석 ID에서 행과 열을 추출하는 함수
    function getSeatPosition(seatId) {
        const match = seatId.match(/([A-Z]+)(\d+)/);
        return match ? { row: match[1], col: parseInt(match[2], 10) } : null;
    }

    // 지정된 좌석 ID와 인원 수를 기반으로 인접 좌석을 계산하는 함수
    function getAdjacentSeats(seatId, count, maxCols) {
        const position = getSeatPosition(seatId);
        if (!position) return [];
        const { row, col } = position;
        const seats = [];

        seats.push(`${row}${col}`);

        // 좌측 방향으로 인접 좌석 계산
        for (let i = 1; i < count; i++) {
            const currentCol = col - i;
            if (currentCol > 0) {
                seats.unshift(`${row}${currentCol}`);
                if (seats.length === count) return seats;
            } else {
                break;
            }
        }

        // 우측 방향으로 인접 좌석 계산
        for (let i = 1; seats.length < count; i++) {
            const currentCol = col + i;
            if (currentCol <= maxCols) {
                seats.push(`${row}${currentCol}`);
                if (seats.length === count) return seats;
            } else {
                break;
            }
        }

        return seats.length === count ? seats : [];
    }

    // 인접 좌석을 'unavailable' 클래스로 표시하는 함수
    function markUnavailableSeats(seatId, count, maxCols) {
        const adjacentSeats = getAdjacentSeats(seatId, count, maxCols);
        for (let seat of adjacentSeats) {
            const seatElement = $(`.seat[data-seat='${seat}']`);
            if (!seatElement.hasClass('reserved') && !seatElement.hasClass('selected')) {
                seatElement.addClass('unavailable');
            }
        }
    }

    // 모든 좌석에서 'unavailable' 클래스를 제거하는 함수
    function unmarkUnavailableSeats() {
        $('.seat').removeClass('unavailable');
    }

     // 선택된 좌석을 표시하고 총 가격을 업데이트하는 함수
    function updateSelectedSeatsDisplay() {
        let allSelectedSeats = selectedSeats.adult.concat(selectedSeats.teen, selectedSeats.child);
        $('#selectedSeats').val(allSelectedSeats.join(','));
        $('#selectedSeatsDisplay').text(allSelectedSeats.join(', '));
        updateTotalPrice();
    }

    // 선택된 좌석 수에 따라 총 가격을 계산하는 함수
    function updateTotalPrice() {
        let totalPrice = 0;
        for (const category in selectedSeats) {
            const count = selectedSeats[category].length;
            totalPrice += count * seatPrices[category];
        }
        $('#totalPrice').text(totalPrice.toLocaleString() + '원');
    }

    // 선택된 인원 수를 업데이트하는 함수
    function updateTotalPersons() {
        const totalCount = totalPersons.adult + totalPersons.teen + totalPersons.child;
        $('#totalPersons').text(totalCount + '명');
    }

    // 모든 좌석의 선택 상태를 초기화하는 함수
    function resetSeatSelection() {
        $('.seat').removeClass('selected');
        for (const category in selectedSeats) {
            selectedSeats[category].forEach(seat => {
                $(`.seat[data-seat='${seat}']`).addClass('selected');
            });
        }
    }

    // 좌석 클릭 이벤트 핸들러
    $('.seat').on('click', function () {
        if ($(this).hasClass('reserved') || $(this).hasClass('unavailable')) {
            return;
        }

        if (!selectedCategory) {
            alert("인원 카테고리를 먼저 선택하세요.");
            return;
        }

        const seatId = $(this).data('seat');
        unmarkUnavailableSeats();

        let categorySeats = selectedSeats[selectedCategory];

        if (categorySeats.includes(seatId)) {
            selectedSeats[selectedCategory] = categorySeats.filter(seat => seat !== seatId);
        } else {
            const adjacentSeats = getAdjacentSeats(seatId, totalPersons[selectedCategory], 10);
            const invalidSeat = adjacentSeats.find(seat => 
                $(`.seat[data-seat='${seat}']`).hasClass('reserved') || 
                $(`.seat[data-seat='${seat}']`).hasClass('selected')
            );

            if (invalidSeat || adjacentSeats.length < totalPersons[selectedCategory]) {
                alert(`${categoryNames[selectedCategory]} 인원 수만큼 좌석을 선택할 수 없습니다.`);
                markUnavailableSeats(seatId, totalPersons[selectedCategory], 10);
                return;
            }

            const allSelectedSeatsCount = Object.values(selectedSeats).flat().length + adjacentSeats.length - categorySeats.length;
            if (allSelectedSeatsCount > 6) {
                alert("최대 인원은 6명까지입니다.");
                return;
            }

            selectedSeats[selectedCategory] = adjacentSeats;
        }

        resetSeatSelection();
        updateSelectedSeatsDisplay();
        checkSelectionComplete();
    });

    // 좌석에 마우스를 올렸을 때 인접 좌석을 표시하는 이벤트 핸들러
    $('.seat').on('mouseenter', function () {
        if ($(this).hasClass('reserved') || $(this).hasClass('selected')) {
            return;
        }

        if (!selectedCategory) {
            return;
        }

        const seatId = $(this).data('seat');
        unmarkUnavailableSeats();
        const adjacentSeats = getAdjacentSeats(seatId, totalPersons[selectedCategory], 10);
        const invalidSeat = adjacentSeats.find(seat => $(`.seat[data-seat='${seat}']`).hasClass('reserved') || $(`.seat[data-seat='${seat}']`).hasClass('selected'));

        if (invalidSeat || adjacentSeats.length < totalPersons[selectedCategory]) {
            markUnavailableSeats(seatId, totalPersons[selectedCategory], 10);
        }
    });

    // 좌석에서 마우스를 뗐을 때 인접 좌석 표시를 제거하는 이벤트 핸들러
    $('.seat').on('mouseleave', function () {
        unmarkUnavailableSeats();
    });

    // 인원 선택 버튼 클릭 이벤트 핸들러
    $('.person-select button').on('click', function () {
        const category = $(this).data('category');
        const count = parseInt($(this).text(), 10);

        if (totalPersons[category] === count) {
            totalPersons[category] = 0;
            selectedSeats[category] = [];
            $(this).removeClass('selected');
        } else {
            const totalSelectedPersons = totalPersons.adult + totalPersons.teen + totalPersons.child;
            const newTotal = totalSelectedPersons - totalPersons[category] + count;

            if (newTotal > 6) {
                alert("총 인원은 최대 6명까지만 선택할 수 있습니다.");
                return;
            }

            $(`.person-select button[data-category="${category}"]`).removeClass('selected');
            $(this).addClass('selected');
            totalPersons[category] = count;
            selectedCategory = category;
        }

        updateTotalPersons();
        resetSeatSelection();
        updateSelectedSeatsDisplay();
        checkSelectionComplete();
    });

    // 모든 선택이 완료되었는지 확인하는 함수
    function checkSelectionComplete() {
        let allComplete = true;
        for (const category in totalPersons) {
            if (totalPersons[category] !== selectedSeats[category].length) {
                allComplete = false;
                break;
            }
        }
        if (allComplete) {
            $('.person-select button').removeClass('disabled');
            $('#paymentButton').removeClass('disabled').css('background-color', 'red');
        } else {
            $('.person-select button').addClass('disabled');
            $(`.person-select button[data-category="${selectedCategory}"]`).removeClass('disabled');
            $('#paymentButton').addClass('disabled').css('background-color', '#343433');
        }
    }

    // 좌석 상태를 서버에서 가져오는 함수
    function fetchSeatStatus() {
        $.ajax({
            url: '/reservation/seatStatus',
            method: 'GET',
            data: { screen_movie_id: screen_movie_id },
            success: function (response) {
                console.log("Server response:", response);
                let seatStatus = response.seatStatus;
                let totalSeats = response.totalSeats;

                // 모든 좌석의 상태를 초기화
                $('.seat').removeClass('reserved').removeClass('selected');

                // 서버에서 받은 예약된 좌석 정보를 적용
                for (let seat in seatStatus) {
                    if (seatStatus[seat]) {
                        $(`.seat[data-seat='${seat}']`).addClass('reserved');
                    }
                }

                // 현재 선택된 좌석 정보를 다시 적용
                for (let category in selectedSeats) {
                    selectedSeats[category].forEach(seat => {
                        if (!$(`.seat[data-seat='${seat}']`).hasClass('reserved')) {
                            $(`.seat[data-seat='${seat}']`).addClass('selected');
                        }
                    });
                }

                $('#totalSeats').text(totalSeats);
                updateRemainingSeats();
            },
            error: function (error) {
                console.error('Error fetching seat status:', error);
            }
        });
    }

    // 남은 좌석 수를 업데이트하는 함수
    function updateRemainingSeats() {
        const totalSeats = parseInt($('#totalSeats').text());
        const reservedSeats = $('.seat.reserved').length;
        $('#remainingSeats').text(totalSeats - reservedSeats);
    }

    // UUID 생성 및 예약 ID 초기화
    function generateUUID() {
        return $.ajax({
            url: '/reservation/generateUUID',
            method: 'GET',
            success: function (uuid) {
                reservationId = uuid;
            },
            error: function (error) {
                console.error('Error generating UUID:', error);
            }
        });
    }

    // 결제 UUID 생성 및 결제 ID 초기화
    function generatePaymentUUID() {
        return $.ajax({
            url: '/reservation/generateUUID',
            method: 'GET',
            success: function (uuid) {
                paymentId = uuid;
            },
            error: function (error) {
                console.error('Error generating UUID:', error);
            }
        });
    }

    // 결제 버튼 클릭 이벤트 핸들러
    $('#paymentButton').on('click', function () {
        if ($(this).hasClass('disabled')) {
            return;
        }

        // 아임포트 결제 초기화
        IMP.init('imp20583321');

        let totalAmount = parseInt($('#totalPrice').text().replace(/[^0-9]/g, ''));

        // 아임포트 결제 요청
        IMP.request_pay({
            pg: 'html5_inicis',
            pay_method: 'card',
            merchant_uid: 'merchant_' + new Date().getTime(),
            name: '영화 예매',
            amount: totalAmount,
            buyer_email: memberInfo.email,
            buyer_name: memberInfo.name,
            buyer_tel: memberInfo.phone,
        }, function (rsp) {
            if (rsp.success) {
                saveReservation(rsp);
            } else {
                alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
            }
        });
    });

    // 예약 정보를 저장하는 함수
    function saveReservation(paymentResponse) {
        const reservationData = {
            res_id: reservationId,
            mem_id: memberInfo.mem_id,
            screen_movie_id: screenMovieId,
            res_seat_info: $('#selectedSeatsDisplay').text(),
            adult: totalPersons.adult,
            teenager: totalPersons.teen,
            child: totalPersons.child,
            tot_people: totalPersons.adult + totalPersons.teen + totalPersons.child
        };

        $.ajax({
            url: '/reservation/save',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(reservationData),
            success: function (resId) {
                savePayment(resId, paymentResponse);
                // 예약 성공 후 좌석 상태 갱신
                fetchSeatStatus();
            },
            error: function (error) {
                console.error('Error saving reservation:', error);
                alert('예약 처리 중 오류가 발생하였습니다.');
            }
        });
    }

    // 결제 정보를 저장하는 함수
    function savePayment(resId, paymentResponse) {
        const paymentData = {
            pay_id: paymentId,
            res_id: resId,
            imp_uid: paymentResponse.imp_uid,
            mer_uid: paymentResponse.merchant_uid,
            pay_method: paymentResponse.pay_method,
            tot_price: parseInt($('#totalPrice').text().replace(/[^0-9]/g, '')),
            pay_status: 'Y',
            card_information: paymentResponse.card_name
	};
	
	 $.ajax({
        url: '/reservation/payment/save',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(paymentData),
        success: function (response) {
            console.log(response);
            alert('예약 및 결제가 성공적으로 완료되었습니다.');
            window.location.href = 'payment/success';
        },
        error: function (error) {
            console.error('Error saving payment:', error);
            alert('결제 처리 중 오류가 발생하였습니다.');
        }
    });
}

// 페이지 로드 시 UUID 생성
generateUUID().then(fetchSeatStatus);

// 결제 UUID 생성
generatePaymentUUID();

// 주기적으로 좌석 상태를 업데이트
setInterval(fetchSeatStatus, 5000); // 5초마다 업데이트

});