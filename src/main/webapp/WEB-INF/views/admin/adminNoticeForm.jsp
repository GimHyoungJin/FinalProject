<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>관리자 공지사항 작성</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/js/adminNotice.js' />"></script>
  <style>
    .content-wrapper {
      margin-top: 20px;
      padding: 20px;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 900px;
    }
    .form-label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .form-control {
      width: 100%;
      margin-bottom: 20px;
      padding: 10px;
      border-radius: 4px;
      border: 1px solid #ccc;
    }
    .btn-primary {
      background-color: #007bff;
      border: none;
      color: white;
      padding: 10px 20px;
      cursor: pointer;
    }
    .btn-primary:hover {
      background-color: #0056b3;
    }
    .btn-secondary {
      background-color: #6c757d;
      border: none;
      color: white;
      padding: 10px 20px;
      cursor: pointer;
    }
    .btn-secondary:hover {
      background-color: #5a6268;
    }
    .btn-danger {
      background-color: #dc3545;
      border: none;
      color: white;
      padding: 10px 20px;
      cursor: pointer;
    }
    .btn-danger:hover {
      background-color: #c82333;
    }
  </style>
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <div class="container-fluid content-container">
    <div class="row">
      <div class="col-3">
        <%@ include file="../customer/customer_sidebar.jsp" %>
      </div>
      <div class="col-9 d-flex justify-content-center">
        <div class="content-wrapper">
          <h2>공지사항 작성</h2>
          <c:if test="${not empty errorMessage}">
              <div class="alert alert-danger">${errorMessage}</div>
          </c:if>
          <form id="noticeForm" action="/admin/notices?action=create" method="post">
            <div class="mb-3">
              <label for="title" class="form-label">제목</label>
              <input type="text" class="form-control" id="title" name="title" required>
            </div>
            <div class="mb-3">
              <label for="content" class="form-label">내용</label>
              <textarea class="form-control" id="content" name="content" rows="10" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">작성</button>
            <button type="reset" class="btn btn-secondary">다시입력</button>
            <button type="button" class="btn btn-danger" onclick="window.location.href='/admin/notices?action=list'">작성취소</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>