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
      height: 750px;
      margin: auto; /* 중앙 정렬 */
      border-radius: 15px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      position: relative;
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
    
    .reply-section {
      margin-top: 20px;
      position: relative;
    }
    
    .reply-section .card-header.card-header-custom {
	  background-color: #bdafde;
	  color: white;
	}
	
    .reply-content {
      margin-bottom: 10px;
    }
    .card-reply {
      width: 650px; /* 고정형 크기 설정 */
      margin: auto; /* 중앙 정렬 */
      margin-top: 20px;
      margin-bottom: 20px;
      border-radius: 15px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      position: relative;
    }
    
    .arrow {
      width: 0; 
      height: 0; 
      border-left: 10px solid transparent;
      border-right: 10px solid transparent;
      border-top: 10px solid #ccc;
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
    }
    
    .arrow-up {
      top: -10px;
      border-top: none;
      border-bottom: 10px solid #ccc;
    }
    
    .arrow-down {
      bottom: -10px;
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
    <div class="arrow arrow-down"></div>
  </div>

 <!-- 답변 내용 표시 카드 섹션 -->
<c:if test="${not empty replies}">
  <div class="reply-section">
    <div class="arrow arrow-up"></div>
    <div class="card card-reply">
      <div class="card-header card-header-custom">
        <h5 class="card-title mb-0">답변</h5>
      </div>
      <div class="card-body card-body-custom">
        <c:forEach var="reply" items="${replies}">
          <div class="reply-content">
            <span>${reply.inqde_content}</span>
            <br>
            <small>작성일 : ${reply.inqde_date}</small>
          </div>
          <hr>
        </c:forEach>
      </div>
    </div>
  </div>
</c:if>

 <!-- 답변 다는 카드 섹션--> 
<div class="admin-button-container" style="display: none;">
  <div class="arrow arrow-down"></div>
  <div class="card card-reply">
    <div class="card-header card-header-custom">
      <h5 class="card-title mb-0">답변</h5>
    </div>
    <div class="card-body card-body-custom">
      <form id="replyForm" method="post" action="<c:url value='/customer/addReply' />">
        <input type="hidden" name="inq_num" value="${inquiry.inq_num}" />
        <div class="mb-3">
          <label for="replyContent" class="form-label">답변 작성</label>
          <textarea class="form-control" id="replyContent" name="inqde_content" rows="3"></textarea>
        </div>
        <button type="submit" class="btn btn-primary btn-custom">답변 달기</button>
      </form>
    </div>
  </div>
</div>

 <!-- 목록 및 삭제 버튼 -->
  <div class="btn-group-custom">
    <button type="button" class="btn btn-secondary btn-custom me-2" onclick="location.href='<c:url value='/customer/inquiryList' />'">목록</button>
    <div class="admin-button-container" style="display: none;">
      <form id="deleteForm" method="post" action="<c:url value='/customer/deleteInquiry' />">
        <input type="hidden" name="inq_num" value="${inquiry.inq_num}" />
        <button type="button" class="btn btn-danger btn-custom" onclick="confirmDelete()">삭제</button>
      </form>
    </div>
  </div>
  
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>

  <script>
    function confirmDelete() {
      if (confirm('정말 삭제하시겠습니까?')) {
        document.getElementById('deleteForm').submit();
      }
    }
  </script>
</body>
</html>
