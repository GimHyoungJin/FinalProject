<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- JSTL core 태그 라이브러리 선언 --%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Order Form</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap CSS 및 JS 파일을 포함하여 페이지의 스타일과 인터랙션을 지원 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/jquery-3.7.1.min.js"></script> <!-- jQuery 라이브러리 포함 -->
  <script src="https://cdn.iamport.kr/v1/iamport.js"></script> <!-- 아임포트 결제 라이브러리 포함 -->
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css"> <!-- 헤더 스타일 CSS 파일 포함 -->
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css"> <!-- 푸터 스타일 CSS 파일 포함 -->
</head>
<body>

<%@ include file="../../header.jsp" %> <!-- 헤더 JSP 파일 포함 -->

<!-- 내비게이션 바 -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link active" href="/product/list">상품</a> <!-- 상품 리스트 페이지로 이동 -->
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="/cart/list">장바구니</a> <!-- 장바구니 페이지로 이동 -->
      </li>
    </ul>
  </div>
</nav>

<!-- 주문서 작성 폼 -->
<div class="container text-center">
  <div class="row">
    <div class="col-sm-12">
      <p><h3>주문서 작성</h3></p>
    </div>
  </div>
  
  <div class="row">
    <div class="col-sm-12">
      <!-- 주문 폼: 서버로 주문 데이터를 전송 -->
        <table class="table table-hover">
          <tbody style="text-align: left;">
            <!-- 받는 사람 입력 필드 -->
            <tr>
              <th>받는사람</th>
              <td><input type="text" name="deliverynm" id="deliverynm" class="form-control" required></td>
            </tr>
            <!-- 받는 번호 입력 필드 -->
            <tr>
              <th>받는번호</th>
              <td><input type="text" name="deliverypnum" id="deliverypnum" class="form-control" required></td>
            </tr>
            <!-- 결제 버튼 -->
            <tr>
              <td colspan="2" align="center">
				<input type="button" value="결제하기" class="btn btn-dark" 
       				   onclick="checkLoginAndPay('inicis', '${useremail}', '${username}', '${proName}', ${totalPrice}, '${proDetailCode}', ${orderDetailAmount})">
              </td>
            </tr>
          </tbody>
        </table>
    </div>
  </div>
</div>

<%@ include file="../../footer.jsp" %> <!-- 푸터 JSP 파일 포함 -->

<!-- 로그인 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginModalLabel">로그인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- 로그인 폼 -->
        <form id="loginForm">
          <div class="mb-3">
            <label for="loginEmail" class="form-label">이메일 주소</label>
            <input type="email" class="form-control" id="loginEmail" required>
          </div>
          <div class="mb-3">
            <label for="loginPassword" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="loginPassword" required>
          </div>
          <button type="submit" class="btn btn-primary">로그인</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>

IMP.init("imp83385183"); // 아임포트 초기화

// 현재 시간을 기준으로 고유한 주문 번호 생성
var today = new Date();
var hours = today.getHours();
var minutes = today.getMinutes();
var seconds = today.getSeconds();
var milliseconds = today.getMilliseconds();
var makeMerchantUid = `IMP${hours}${minutes}${seconds}${milliseconds}`;

// 로그인 상태 확인 및 결제 진행
async function checkLoginAndPay(paymentMethod, useremail, username, proName, productPrice, proDetailCode, orderDetailAmount) {
    // 주문서 유효성 검사
	let deliverynm = $("#deliverynm").val().trim();
    if (deliverynm.length <= 2) {
        alert("받는사람을 입력해주세요");
        $("#deliverynm").focus();
        return;
    }
	
    let deliverypnum = $("#deliverypnum").val().trim();
    let numericRegex = /^[0-9]{11}$/;
    if (!numericRegex.test(deliverypnum)) {
        alert("번호를 올바르게 입력해주세요");
        $("#deliverypnum").focus();
        return;
    }
	
    if(confirm("구매 하시겠습니까?")) {
	    console.log('Product Price:', productPrice);  // 값 확인
	    console.log('Product Name:', proName);  // 값 확인
	    const isLoggedIn = await checkLoginStatus();
	    if (isLoggedIn) {
	        if (paymentMethod === 'inicis') {
	            inicisPay(useremail, username, proName, productPrice, proDetailCode, orderDetailAmount);
	        }
	    } else {
	        showLoginModal();
	    }
    }//end
}//checkLoginAndPay() end

// 로그인 상태 확인
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

// 로그인 모달 표시
function showLoginModal() {
    $('#loginModal').modal('show');
}

//이니시스 결제 진행
async function inicisPay(useremail, username, proName, productPrice, proDetailCode, orderDetailAmount) {
    if (confirm("결제 하시겠습니까?")) {
        IMP.request_pay({
            pg: 'html5_inicis.INIpayTest',
            pay_method: 'card',
            mer_uid: 'merchant_' + new Date().getTime(),
            name: proName,
            amount: productPrice,
            buyer_email: useremail,
            buyer_name: username,
            goodsname: proName // 추가된 필수 파라미터
        }, async function (rsp) {
        	
            console.log(rsp);
        	
            if (rsp.success) {
                // 결제가 성공하면 서버에 결제 정보 전송
                const response = await fetch('/order/insert', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        imp_uid: rsp.imp_uid,
                        mer_uid: rsp.merchant_uid,
                        paid_amount: rsp.paid_amount,
                        apply_num: rsp.apply_num,
                        buyer_email: rsp.buyer_email,
                        buyer_name: rsp.buyer_name,
                        pay_method: rsp.pay_method,
                        pay_status: rsp.status,
                        card_information: rsp.card_name,
                        pro_detail_code: proDetailCode, // 상품 상세 코드 추가
                        order_detail_amount: orderDetailAmount // 주문 수량 추가
                    })
                });
				console.log(response);
                if (response.ok) {
                    const result = await response.json();
                    
                    let flag = result.data;
                    
                    if (flag == "success") {
                        alert('결제 완료!');
                    } else {
                        alert('결제 처리 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                    
                    window.location.href = '/order/msgView?flag=' + flag;

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


</script>
</body>
</html>
