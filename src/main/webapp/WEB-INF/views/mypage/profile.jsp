<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>개인정보 수정</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
  <style>
    .content-wrapper {
      margin-top: 20px;
      border: 1px solid black;
      padding: 20px;
    }
  </style>
</head>
<body>
  <%@ include file="../../header.jsp" %>

  <div class="container-fluid mypage-container">
    <div class="row">
      <div class="container-fluid mypage-container">
        <div class="row">
          <div class="col-md-3 sidebar">
            <div class="list-group">
              <a href="<c:url value='/mypage/mypage' />" class="list-group-item header" aria-current="true">나의 무비오</a>
              <a href="<c:url value='/mypage/bookinglist' />" class="list-group-item list-group-item-action">예매/구매 내역</a>
              <a href="<c:url value='/mypage/inquiry' />" class="list-group-item list-group-item-action">나의 문의내역</a>
              <a href="<c:url value='/mypage/profile' />" class="list-group-item list-group-item-action">회원정보</a>
              <a href="<c:url value='/mypage/store_vouchers' />" class="list-group-item list-group-item-action">스토어 교환권</a>
            </div>
          </div>

          <div class="col-md-9 content-wrapper">
            <form method="post" action="<c:url value='/mypage/profile' />">
              <input type="hidden" name="memId" value="${profile.mem_id}" />
              <br><br>
              <h2>개인정보 수정</h2>
              <div class="card mt-3">
                <p><br><br>회원님의 정보를 정확히 입력해주세요.</p>

                <!-- 에러 메시지 출력 -->
                <c:if test="${not empty error}">
                  <div class="alert alert-danger">${error}</div>
                </c:if>

                <div class="mb-3 row">
                  <label for="username" class="col-sm-2 col-form-label">이름</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="username" name="username" value="${profile.username}">
                  </div>
                </div>
                <div class="mb-3 row">
                  <label for="passwd" class="col-sm-2 col-form-label">비밀번호</label>
                  <div class="col-sm-10">
                    <input type="password" class="form-control" id="passwd" name="passwd" value="${profile.passwd}">
                  </div>
                </div>
                <div class="mb-3 row">
                  <label for="phone" class="col-sm-2 col-form-label">전화번호</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="phone" name="phone" value="${profile.phone}">
                  </div>
                </div>
                <div class="mb-3 row">
                  <label for="birth" class="col-sm-2 col-form-label">생년월일</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="birth" name="birth" value="${profile.birth}">
                  </div>
                </div>
                <div class="mb-3 row">
                  <label for="gender" class="col-sm-2 col-form-label">성별</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="gender" name="gender" value="${profile.gender}">
                  </div>
                </div>
                <div class="mb-3 row">
                  <label for="zipcode" class="col-sm-2 col-form-label">우편번호</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="zipcode" name="zipcode" value="${profile.zipcode}">
                  </div>
                </div>
                <div class="mb-3 row">
                  <label for="address1" class="col-sm-2 col-form-label">주소 1</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="address1" name="address1" value="${profile.address1}">
                  </div>
                </div>
                <div class="mb-3 row">
                  <label for="address2" class="col-sm-2 col-form-label">주소 2</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="address2" name="address2" value="${profile.address2}">
                  </div>
                </div>
                <div class="mb-3 row">
                  <label class="col-sm-2 col-form-label">SMS 수신동의</label>
                  <div class="col-sm-10 d-flex align-items-center">
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" id="sms_agree_y" name="sms_agree" value="Y" <c:if test="${profile.sms_agree == 'Y'}">checked</c:if>>
                      <label class="form-check-label" for="sms_agree_y">예</label>
                    </div>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" id="sms_agree_n" name="sms_agree" value="N" <c:if test="${profile.sms_agree == 'N'}">checked</c:if>>
                      <label class="form-check-label" for="sms_agree_n">아니오</label>
                    </div>
                  </div>
                </div>
                <div class="mb-3 row">
                  <label class="col-sm-2 col-form-label">이메일 수신동의</label>
                  <div class="col-sm-10 d-flex align-items-center">
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" id="email_agree_y" name="email_agree" value="Y" <c:if test="${profile.email_agree == 'Y'}">checked</c:if>>
                      <label class="form-check-label" for="email_agree_y">예</label>
                    </div>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" id="email_agree_n" name="email_agree" value="N" <c:if test="${profile.email_agree == 'N'}">checked</c:if>>
                      <label class="form-check-label" for="email_agree_n">아니오</label>
                    </div>
                  </div>
                </div>
              </div>
              <div class="mb-3 row">
                <div class="col-sm-10 offset-sm-2"> <br><br>
                  <input type="submit" value="수정" class="btn btn-dark">
                  <form action="<c:url value='/mypage/profile/deactivate' />" method="post" class="d-inline">
                    <input type="hidden" name="memId" value="${profile.mem_id}">
                 <!--     <button type="submit" class="btn btn-danger">비활성화</button> --> 
                  </form>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="../../footer.jsp" %>

  <script>
    $(document).ready(function() {
      <% if ("Y".equals(session.getAttribute("updateSuccess"))) { %>
        alert("변경사항이 적용되었습니다.");
        <% session.removeAttribute("updateSuccess"); %>
      <% } %>
    });
  </script>
</body>
</html>
