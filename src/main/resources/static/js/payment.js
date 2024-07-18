var IMP = window.IMP;
IMP.init("imp83385183"); // 가맹점 식별코드

var today = new Date();
var hours = today.getHours();
var minutes = today.getMinutes();
var seconds = today.getSeconds();
var milliseconds = today.getMilliseconds();
var makeMerchantUid = `IMP${hours}${minutes}${seconds}${milliseconds}`;

async function checkLoginAndPay(useremail, username) {
    const isLoggedIn = await checkLoginStatus();
    if (isLoggedIn) {
        kakaoPay(useremail, username);
    } else {
        showLoginModal();
    }
}

async function checkLoginStatus() {
    try {
        const response = await fetch('/order/checkLogin');
        const isLoggedIn = await response.json();
        return isLoggedIn;
    } catch (error) {
        console.error('Error checking login status:', error);
        return false;
    }
}

function showLoginModal() {
    $('#loginModal').modal('show'); // 로그인 모달 표시
}

async function kakaoPay(useremail, username) {
    if (confirm("구매 하시겠습니까?")) {
        const emoticonName = document.getElementById('title') ? document.getElementById('title').innerText : '상품명';

        IMP.request_pay({
            pg: 'kakaopay.TC0ONETIME',
            pay_method: 'card',
            merchant_uid: makeMerchantUid,
            name: emoticonName,
            amount: 100,
            buyer_email: useremail,
            buyer_name: username
        }, async function (rsp) {
            if (rsp.success) {
                console.log(rsp);
                // 결제 성공시 프로젝트 DB 저장 요청
                const response = await fetch('/order/insert', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        imp_uid: rsp.imp_uid,
                        merchant_uid: rsp.merchant_uid,
                        paid_amount: rsp.paid_amount,
                        apply_num: rsp.apply_num,
                        buyer_email: rsp.buyer_email,
                        buyer_name: rsp.buyer_name
                    })
                });

                if (response.ok) {
                    const result = await response.json();
                    if (result.success) {
                        alert('결제 완료!');
                        window.location.reload();
                    } else {
                        alert(result.message);
                    }
                } else {
                    alert(`error:[${response.status}]\n결제요청이 승인된 경우 관리자에게 문의바랍니다.`);
                }
            } else {
                alert(rsp.error_msg);
            }
        });
    } else {
        return false;
    }
}

// 테스트를 위해 결제 함수가 호출되는지 확인하는 로그 추가
console.log('payment.js loaded');
