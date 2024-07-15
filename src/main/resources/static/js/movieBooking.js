$(document).ready(function () {
    let selectedCategory = '';
    let totalPersons = { adult: 0, teen: 0, child: 0 };
    let selectedSeats = { adult: [], teen: [], child: [] };
    const seatPrices = { adult: 15000, teen: 8000, child: 5000 };
    const categoryNames = { adult: '성인', teen: '청소년', child: '아동' };
    let isPaymentComplete = false;

    function getSeatPosition(seatId) {
        const match = seatId.match(/([A-Z]+)(\d+)/);
        return match ? { row: match[1], col: parseInt(match[2], 10) } : null;
    }

function getAdjacentSeats(seatId, count, maxCols) {
    const position = getSeatPosition(seatId);
    if (!position) return [];
    const { row, col } = position;
    const seats = [];

    // 선택한 좌석을 포함
    seats.push(`${row}${col}`);

    // 좌석을 추가할 범위 계산
    let leftCount = Math.floor((count - 1) / 2);
    let rightCount = count - 1 - leftCount;

    // 좌측 방향으로 인접 좌석 계산
    for (let i = 1; i <= leftCount; i++) {
        const currentCol = col - i;
        if (currentCol > 0) {
            seats.unshift(`${row}${currentCol}`);
        } else {
            rightCount++;
        }
    }

    // 우측 방향으로 인접 좌석 계산
    for (let i = 1; i <= rightCount; i++) {
        const currentCol = col + i;
        if (currentCol <= maxCols) {
            seats.push(`${row}${currentCol}`);
        } else {
            leftCount++;
        }
    }

    // 만약 좌우로 충분히 확장하지 못한 경우, 부족한 좌석을 추가
    while (seats.length < count) {
        const firstSeat = seats[0];
        const firstCol = parseInt(firstSeat.match(/(\d+)/)[0]);
        const lastSeat = seats[seats.length - 1];
        const lastCol = parseInt(lastSeat.match(/(\d+)/)[0]);

        if (firstCol > 1) {
            seats.unshift(`${row}${firstCol - 1}`);
        } else if (lastCol < maxCols) {
            seats.push(`${row}${lastCol + 1}`);
        } else {
            break;
        }
    }

    return seats.slice(0, count);  // 원하는 좌석 수만큼 반환
}
    function markUnavailableSeats(seatId, count, maxCols) {
        const adjacentSeats = getAdjacentSeats(seatId, count, maxCols);
        for (let seat of adjacentSeats) {
            const seatElement = $(`.seat[data-seat='${seat}']`);
            if (!seatElement.hasClass('reserved') && !seatElement.hasClass('selected')) {
                seatElement.addClass('unavailable');
            }
        }
    }

    function unmarkUnavailableSeats() {
        $('.seat').removeClass('unavailable');
    }

    function updateSelectedSeatsDisplay() {
        let allSelectedSeats = selectedSeats.adult.concat(selectedSeats.teen, selectedSeats.child);
        $('#selectedSeats').val(allSelectedSeats.join(','));
        $('#selectedSeatsDisplay').text(allSelectedSeats.join(', '));
        updateTotalPrice();
    }

    function updateTotalPrice() {
        let totalPrice = 0;
        for (const category in selectedSeats) {
            const count = selectedSeats[category].length;
            totalPrice += count * seatPrices[category];
        }
        $('#totalPrice').text(totalPrice.toLocaleString() + '원');
    }

    function updateTotalPersons() {
        const totalCount = totalPersons.adult + totalPersons.teen + totalPersons.child;
        $('#totalPersons').text(totalCount + '명');
    }

    function resetSeatSelection() {
        $('.seat').removeClass('selected');
        selectedSeats.adult.forEach(seat => $(`.seat[data-seat='${seat}']`).addClass('selected'));
        selectedSeats.teen.forEach(seat => $(`.seat[data-seat='${seat}']`).addClass('selected'));
        selectedSeats.child.forEach(seat => $(`.seat[data-seat='${seat}']`).addClass('selected'));
    }

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
            categorySeats = [];
        } else {
            const adjacentSeats = getAdjacentSeats(seatId, totalPersons[selectedCategory], 10);
            const invalidSeat = adjacentSeats.find(seat => $(`.seat[data-seat='${seat}']`).hasClass('reserved') || $(`.seat[data-seat='${seat}']`).hasClass('selected'));

            if (invalidSeat) {
                alert(`${categoryNames[selectedCategory]} 인원 수만큼 좌석을 선택할 수 없습니다.`);
                markUnavailableSeats(seatId, totalPersons[selectedCategory], 10);
                return;
            }

            const allSelectedSeatsCount = selectedSeats.adult.length + selectedSeats.teen.length + selectedSeats.child.length + adjacentSeats.length - categorySeats.length;
            if (allSelectedSeatsCount > 6) {
                alert("최대 인원은 6명까지입니다.");
                return;
            }

            categorySeats = adjacentSeats;
        }

        selectedSeats[selectedCategory] = categorySeats;
        resetSeatSelection();
        updateSelectedSeatsDisplay();
        checkSelectionComplete();
    });

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

    $('.seat').on('mouseleave', function () {
        unmarkUnavailableSeats();
    });

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
        } else {
            $('.person-select button').addClass('disabled');
            $(`.person-select button[data-category="${selectedCategory}"]`).removeClass('disabled');
        }
    }

    function fetchSeatStatus() {
        $.ajax({
            url: '/reservation/seatStatus',
            method: 'GET',
            success: function (response) {
                for (let seat in response) {
                    if (response[seat]) {
                        $(`.seat[data-seat='${seat}']`).addClass('reserved');
                    } else {
                        $(`.seat[data-seat='${seat}']`).removeClass('reserved');
                    }
                }
            },
            error: function (error) {
                console.error('Error fetching seat status:', error);
            }
        });
    }

    $('#paymentButton').on('click', function () {
        if (confirm("결제를 진행하시겠습니까?")) {
            isPaymentComplete = true;
            updateSeatStatus();
        }
    });

    function updateSeatStatus() {
        if (isPaymentComplete) {
            $.ajax({
                url: '/reservation/updateSeatStatus',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    selectedSeats: selectedSeats,
                    totalPersons: totalPersons
                }),
                success: function (response) {
                    console.log(response);
                    fetchSeatStatus();
                },
                error: function (error) {
                    if (error.status === 409) {
                        alert("선택한 좌석 중 이미 예약된 좌석이 있습니다.");
                    } else {
                        console.error('Error updating seat status:', error);
                    }
                }
            });
        }
    }

    fetchSeatStatus();
    setInterval(fetchSeatStatus, 1000);
});
