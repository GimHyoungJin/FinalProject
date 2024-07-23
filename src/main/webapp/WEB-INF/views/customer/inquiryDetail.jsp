<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>문의 내용</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <style>
    .card-custom {
      width: 700px; /* 고정형 크기 설정 */
      height: 800px;
      margin: auto; /* 중앙 정렬 */
      border-radius: 15px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    .card-header-custom {
      background-color: #f8f9fa;
      border-bottom: 1px solid #dee2e6;
      padding: 10px;
    }
    .card-body-custom {
      padding: 2rem;
    }
    .btn-custom {
      border-radius: 20px;
      padding: 0.5rem 1.5rem;
    }
    .btn-group-custom {
      display: flex;
      justify-content: center;
      margin-top: 20px;
      margin-bottom: 20px;
    }
    .info-group {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      margin-bottom: 10px;
    }
    .info-label {
      font-weight: bold;
      margin-right: 5px;
    }
    .info-group div {
      display: flex;
      align-items: center;
      margin-bottom: 5px;
    }
    .info-content {
      margin-right: 10px;
    }
  </style>
  <!-- 공통 끝 -->
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <div class="container mt-5">
    <div class="card card-custom">
      <div class="card-header card-header-custom">
        <h5 class="card-title mb-0">${inquiry.inq_title}</h5>
      </div>
      <div class="card-body card-body-custom">
        <div class="info-group">
          <div class="info-content">
            <span class="info-label">이름:</span>
            <span>${username}</span>
          </div>
          <div class="info-content">
            <span class="info-label">문의 유형:</span>
            <span>
              <c:choose>
                <c:when test="${inquiry.inq_type == '1'}">1:1 문의</c:when>
                <c:when test="${inquiry.inq_type == '2'}">분실물 문의</c:when>
                <c:otherwise>알 수 없음</c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="info-content">
            <span class="info-label">답변 상태:</span>
            <span>
              <c:choose>
                <c:when test="${inquiry.inq_status == '0'}">미답변</c:when>
                <c:when test="${inquiry.inq_status == '1'}">답변 완료</c:when>
                <c:otherwise>알 수 없음</c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="info-content">
            <span class="info-label">등록일:</span>
            <span>${inquiry.inq_date}</span>
          </div>
        </div>
        <hr>
        <div>
          <span>${inquiry.inq_content}</span>
        </div>
      </div>
    </div>
    <div class="btn-group-custom">
      <button type="button" class="btn btn-secondary btn-custom me-2" onclick="location.href='<c:url value='/customer/inquiryList' />'">목록</button>
      <div class="admin-button-container" style="display: none;">
      <button type="button" class="btn btn-danger btn-custom" onclick="deleteInquiry(${inquiry.inq_num})">삭제</button>
      </div>
    </div>
  </div>
  
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>

  <script>
    function deleteInquiry(inq_num) {
      if(confirm('삭제하시겠습니까?')) {
        window.location.href = '/customer/deleteInquiry?inq_num=' + inq_num;
      }
    }
  </script>
</body>
</html>
