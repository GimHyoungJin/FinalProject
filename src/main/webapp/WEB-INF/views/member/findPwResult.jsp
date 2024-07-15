<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>비밀번호 재설정</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/member/findIdPw.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <style>
    .result-container {
      background-color: #f9f9f9;
      padding: 20px;
      border: 1px solid #e0e0e0;
      border-radius: 10px;
      margin-top: 50px;
      margin-bottom: 150px;
      max-width: 600px;
      margin-left: auto;
      margin-right: auto;
    }
    .result-header {
      font-size: 24px;
      font-weight: bold;
    }
    .result-content {
      font-size: 18px;
      margin-top: 20px;
    }
    .result-content strong {
      color: orange;
    }
    .result-buttons {
      margin-top: 20px;
    }
    .alert-danger {
      margin-top: 20px;
    }
    .form-control {
      font-size: 14px;
      padding: 10px;
    }
    .btn-primary {
      font-size: 14px;
      padding: 10px 20px;
    }
  </style>
  <script>
    $(document).ready(function() {
      $("form").on("submit", function(e) {
        var newPassword = $("#newPassword").val();
        var confirmPassword = $("#confirmPassword").val();

        if (newPassword.length < 5 || newPassword.length > 15) {
          e.preventDefault();
          alert("비밀번호는 5자에서 15자 사이여야 합니다.");
          return false;
        }

        if (newPassword !== confirmPassword) {
          e.preventDefault();
          alert("비밀번호가 일치하지 않습니다.");
          return false;
        }

        e.preventDefault(); // Prevent form from submitting normally

        // Perform the form submission via AJAX
        $.ajax({
          type: "POST",
          url: $(this).attr('action'),
          data: $(this).serialize(),
          success: function(response) {
            if (response.success) {
              alert("비밀번호 재설정이 완료되었습니다.");
              window.location.href = "<c:url value='/' />"; // Redirect to main page
            } else {
              alert("비밀번호 재설정에 실패하였습니다. 다시 시도해주세요.");
            }
          }
        });
      });
    });
  </script>
</head>
<body>
  <%@ include file="../../header.jsp" %>

  <!-- 메인 콘텐츠 시작 -->
  <div class="container mt-5">
    <h2 class="text-center">비밀번호 재설정</h2>
    <div class="result-container text-center">
      <c:choose>
        <c:when test="${success}">
          <form action="<c:url value='/member/updatePassword' />" method="post">
            <input type="hidden" name="mem_id" value="${mem_id}">
            <div class="mb-3">
              <label for="newPassword" class="form-label">새 비밀번호</label>
              <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            </div>
            <div class="mb-3">
              <label for="confirmPassword" class="form-label">비밀번호 확인</label>
              <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="result-buttons">
              <button type="submit" class="btn btn-primary">비밀번호 재설정</button>
            </div>
          </form>
        </c:when>
        <c:otherwise>
          <div class="alert alert-danger text-center" role="alert">
            입력하신 정보와 일치하는 회원이 없습니다.
          </div>
          <div class="result-buttons">
            <a href="<c:url value='/member/findIdPw' />" class="btn btn-primary">다시 시도하기</a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->

  <%@ include file="../../footer.jsp" %>
</body>
</html>
