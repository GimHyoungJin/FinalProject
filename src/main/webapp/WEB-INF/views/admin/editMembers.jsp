<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원 수정</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/member/modal.css' />" rel="stylesheet" type="text/css">

</head>
<body>
  <%@ include file="/WEB-INF/header.jsp" %>

  <div class="container mt-4">
    <!-- 회원수정 폼 -->
    <h1>회원 수정</h1>
    <h3>유효성검사만 넣으면 수정데이터가 사라져서 일단 보류</h3>
    <form name="admin_memupdate" id="admin_memupdate" action="<c:url value='/admin/members/update' />" method="post">
      <div class="mb-4" style="margin-bottom: 20px;">
        <input type="hidden" name="mem_id" value="${member.mem_id}">
        <div class="mb-3">
          <label for="username" class="form-label">이름</label>
          <input type="text" class="form-control" id="username" name="username" value="${member.username}" required>
          <div id="name-check-result" class="invalid-feedback"></div>
        </div>
        <div class="mb-3">
          <label for="passwd" class="form-label">비밀번호</label>
          <input type="password" class="form-control" id="passwd" name="passwd" value="${member.passwd}" required>
        </div>
       
        <div class="mb-3">
          <label for="email" class="form-label">이메일</label>
          <input type="email" class="form-control" id="email" name="email" value="${member.email}" required>
          <div id="email-check-result" class="invalid-feedback"></div>
        </div>
        <div class="mb-3">
          <label for="phone" class="form-label">전화번호</label>
          <input type="text" class="form-control" id="phone" name="phone" value="${member.phone}" required>
          <div id="phone-check-result" class="invalid-feedback"></div>
        </div>
        <div class="mb-3">
          <label for="birth" class="form-label">생년월일 (8자리)</label>
          <input type="text" class="form-control" id="birth" name="birth" value="${member.birth}" required>
          <div id="birth-check-result" class="text-danger"></div>
        </div>
        <div class="mb-3">
          <label for="gender" class="form-label">성별</label>
          <select class="form-select" id="gender" name="gender" required>
            <option value="M" <c:if test="${member.gender == 'M'}">selected</c:if>>남성</option>
            <option value="F" <c:if test="${member.gender == 'F'}">selected</c:if>>여성</option>
          </select>
        </div>
        <div class="mb-3">
          <label for="zipcode" class="form-label">우편번호</label>
          <input type="text" class="form-control" id="zipcode" name="zipcode" value="${member.zipcode}" readonly>
          <button type="button" class="btn btn-secondary mt-2" onclick="DaumPostcode()">주소 찾기</button>
        </div>
        <div class="mb-3">
          <label for="address1" class="form-label">주소</label>
          <input type="text" class="form-control" id="address1" name="address1" value="${member.address1}" readonly>
        </div>
        <div class="mb-3">
          <label for="address2" class="form-label">나머지 주소</label>
          <input type="text" class="form-control" id="address2" name="address2" value="${member.address2}">
        </div>
        <div class="mb-3">
          <label class="form-label">SMS 수신동의</label>
          <div>
            <input type="radio" id="sms_agree_y" name="sms_agree" value="Y" <c:if test="${member.sms_agree == 'Y'}">checked</c:if>> 예
            <input type="radio" id="sms_agree_n" name="sms_agree" value="N" <c:if test="${member.sms_agree == 'N'}">checked</c:if>> 아니오
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label">이메일 수신동의</label>
          <div>
            <input type="radio" id="email_agree_y" name="email_agree" value="Y" <c:if test="${member.email_agree == 'Y'}">checked</c:if>> 예
            <input type="radio" id="email_agree_n" name="email_agree" value="N" <c:if test="${member.email_agree == 'N'}">checked</c:if>> 아니오
          </div>
        </div>
        <div class="mb-3">
          <label for="mem_grade" class="form-label">회원 등급</label>
          <select class="form-select" id="mem_grade" name="mem_grade" required>
            <option value="1" <c:if test="${member.mem_grade == 1}">selected</c:if>>일반 회원</option>
            <option value="2" <c:if test="${member.mem_grade == 2}">selected</c:if>>우수 회원</option>
            <option value="0" <c:if test="${member.mem_grade == 0}">selected</c:if>>관리자</option>
          </select>
        </div>
        <input type="submit" class="btn btn-dark" value="수정" >
        <button type="button" class="btn btn-dark" onclick="window.location.href='<c:url value='/admin/members' />'">취소</button>
      </div>
    </form>
  </div>

  <%@ include file="/WEB-INF/footer.jsp" %>

  <!-- DAUM 우편번호 API 모달 -->
  <div class="modal fade" id="postcodeModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 800px;">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalLabel">우편번호 찾기</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" id="modalBody" style="height: 600px;"></div>
      </div>
    </div>
  </div>

  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>
