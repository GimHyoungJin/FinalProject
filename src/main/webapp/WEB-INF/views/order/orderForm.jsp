<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>detail</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/jquery-3.7.1.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">  
  <!-- 포트원 결제 -->
  <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
  <script src="<c:url value='/js/payment.js' />"></script>
</head>
<body>

<%@ include file="../../header.jsp" %>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
    <ul class="navbar-nav">    	
      <li class="nav-item">
        <a class="nav-link active" href="/product/list">상품</a>
      </li>      
      <li class="nav-item">
        <a class="nav-link active" href="/cart/list">장바구니</a>
      </li>
    </ul>
  </div>
</nav>

<div class="container text-center">
  <!-- 본문 시작 -->
  <div class="row">
    <div class="col-sm-12">
 		<p><h3>주문서 작성</h3></p>
    </div><!-- col end -->
  </div><!-- row end -->
  
  <div class="row">
    <div class="col-sm-12">
            <form name="productfrm" method="post" action="insert" onsubmit="return orderCheck()">
                <input type="hidden" name="proDetailCode" value="${product.proDetailCode}">
                <input type="hidden" name="cart_price" id="cart_price">
                <table class="table table-hover">
                    <tbody style="text-align: left;">
                    <tr>
                        <th>받는사람</th>
                        <td><input type="text" name="deliverynm" id="deliverynm" class="form-control" required></td>
                    </tr>
                    <tr>
                        <th>받는번호</th>
                        <td><input type="text" name="deliverypnum" id="deliverypnum" class="form-control" required></td>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" value="카카오페이 간편결제" class="btn btn-warning" onclick="checkLoginAndPay('kakao', '${user_email}', '${username}')">
                            <input type="button" value="결제하기" class="btn btn-dark" onclick="checkLoginAndPay('inicis', '${user_email}', '${username}')">
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
    </div><!-- col end -->
  </div><!-- row end -->
  <!-- 본문 끝 -->
</div><!-- container end -->

<%@ include file="../../footer.jsp" %>

<!-- 로그인 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginModalLabel">로그인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
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
function orderCheck() {
	let deliverynm = $("#deliverynm").val().trim();
	if(deliverynm.length <= 2) {
		alert("받는사람 입력해주세요");
		$("#deliverynm").focus();
		return false;
	}

	let deliverypnum = $("#deliverypnum").val().trim();
	let numericRegex = /^[0-9]{11}$/;

	if (!numericRegex.test(deliverypnum)) {
	    alert("번호를 입력해주세요");
	    $("#deliverypnum").focus();
	    return false;
	}

	if(confirm("결제할까요?")) {
		return true;
	} else {
		return false;
	}
}

// 구매자 정보 전달
const user_email = '${user_email}';
const username = '${username}';

const buyButton = document.getElementById('payment');
buyButton.setAttribute('onclick', `checkLoginAndPay('${user_email}', '${username}')`);
</script>

</body>
</html>
