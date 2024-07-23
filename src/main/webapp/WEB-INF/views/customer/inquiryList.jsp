<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>통합 문의</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <!-- 공통 끝 -->
  <!-- 개별파일 시작 -->
  <link href="<c:url value='/css/customer/inquiry.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
  <!-- 개별 파일 끝 -->
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <div id="container" class="d-flex justify-content-center mt-3">
    <div id="main-content" class="d-flex">
      <div id="sidebar" class="me-3">
        <%@ include file="customer_sidebar.jsp" %>
      </div>
      <div class="content">
        <div class="container">
          <h2>통합 문의 목록</h2>
          <p>문의를 접수 해 주세요.</p>
          <p>접수하신 글은 비밀글로 등록되어 비밀번호를 통해 확인 가능합니다.</p>
          <!-- 1:1 문의 버튼 -->
          <div class="text-end mb-3">
             <a id="inquiry-btn" href="<c:url value='/customer/inquiryForm' />" class="btn btn-primary" onclick="checkLogin(event)">통합 문의</a>
          </div>
          <!-- 탭 네비게이션 -->
          <ul class="nav nav-tabs" id="inquiryTabs" role="tablist">
            <li class="nav-item" role="presentation">
              <a class="nav-link active" id="all-inquiries-tab" data-bs-toggle="tab" href="#all-inquiries" role="tab" aria-controls="all-inquiries" aria-selected="true">전체 문의</a>
            </li>
            <li class="nav-item" role="presentation">
              <a class="nav-link" id="inquiry-type-1-tab" data-bs-toggle="tab" href="#inquiry-type-1" role="tab" aria-controls="inquiry-type-1" aria-selected="false">1:1 문의</a>
            </li>
            <li class="nav-item" role="presentation">
              <a class="nav-link" id="inquiry-type-2-tab" data-bs-toggle="tab" href="#inquiry-type-2" role="tab" aria-controls="inquiry-type-2" aria-selected="false">분실물 문의</a>
            </li>
          </ul>
          <div class="tab-content" id="inquiryTabsContent">
            <!-- 전체 문의 탭 -->
            <div class="tab-pane fade show active" id="all-inquiries" role="tabpanel" aria-labelledby="all-inquiries-tab">
              <!-- 전체 문의 목록 테이블 -->
              <div class="table-responsive mt-3">
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>접수상태</th>
                      <th>등록일</th>
                      <th>문의유형</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="inquiry" items="${inquiries}">
                      <tr>
                        <td>${inquiry.inq_num}</td>
                        <td><a href="javascript:void(0);" onclick="showPasswordPrompt(${inquiry.inq_num});">${inquiry.inq_title}</a></td>
                        <td>
                          <c:choose>
                            <c:when test="${inquiry.inq_status == '0'}">확인중</c:when>
                            <c:when test="${inquiry.inq_status == '1'}">답변 완료</c:when>
                            <c:otherwise>알 수 없음</c:otherwise>
                          </c:choose>
                        </td>
                        <td>${inquiry.inq_date}</td>
                        <td>
                          <c:choose>
                            <c:when test="${inquiry.inq_type == '1'}">1:1 문의</c:when>
                            <c:when test="${inquiry.inq_type == '2'}">분실물 문의</c:when>
                            <c:otherwise>알 수 없음</c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
            <!-- 1:1 문의 탭 -->
            <div class="tab-pane fade" id="inquiry-type-1" role="tabpanel" aria-labelledby="inquiry-type-1-tab">
              <!-- 1:1 문의 목록 테이블 -->
              <div class="table-responsive mt-3">
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>접수상태</th>
                      <th>등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="inquiry" items="${inquiries}">
                      <c:if test="${inquiry.inq_type == '1'}">
                        <tr>
                          <td>${inquiry.inq_num}</td>
                          <td><a href="javascript:void(0);" onclick="showPasswordPrompt(${inquiry.inq_num});">${inquiry.inq_title}</a></td>
                          <td>
                            <c:choose>
                              <c:when test="${inquiry.inq_status == '0'}">확인중</c:when>
                              <c:when test="${inquiry.inq_status == '1'}">답변 완료</c:when>
                              <c:otherwise>알 수 없음</c:otherwise>
                            </c:choose>
                          </td>
                          <td>${inquiry.inq_date}</td>
                        </tr>
                      </c:if>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
            <!-- 분실물 문의 탭 -->
            <div class="tab-pane fade" id="inquiry-type-2" role="tabpanel" aria-labelledby="inquiry-type-2-tab">
              <!-- 분실물 문의 목록 테이블 -->
              <div class="table-responsive mt-3">
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>접수상태</th>
                      <th>등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="inquiry" items="${inquiries}">
                      <c:if test="${inquiry.inq_type == '2'}">
                        <tr>
                          <td>${inquiry.inq_num}</td>
                          <td><a href="javascript:void(0);" onclick="showPasswordPrompt(${inquiry.inq_num});">${inquiry.inq_title}</a></td>
                          <td>
                            <c:choose>
                              <c:when test="${inquiry.inq_status == '0'}">확인중</c:when>
                              <c:when test="${inquiry.inq_status == '1'}">답변 완료</c:when>
                              <c:otherwise>알 수 없음</c:otherwise>
                            </c:choose>
                          </td>
                          <td>${inquiry.inq_date}</td>
                        </tr>
                      </c:if>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <!-- 페이지 네비게이션 -->
          <nav aria-label="Page navigation">
            <ul class="pagination">
              <c:forEach begin="1" end="${totalPages}" var="page">
                <li class="page-item"><a class="page-link" href="?page=${page}">${page}</a></li>
              </c:forEach>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </div>
  <!-- 비밀번호 입력 모달 -->
  <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="passwordModalLabel">비밀번호 확인</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p>비밀번호를 입력하세요:</p>
          <input type="password" id="inputPassword" class="form-control">
          <input type="hidden" id="inquiryNum">
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary" onclick="verifyPassword()">확인</button>
        </div>
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
  <script>
    function showPasswordPrompt(inquiryNum) {
      $('#inquiryNum').val(inquiryNum);
      $('#passwordModal').modal('show');
    }

    function verifyPassword() {
      var inquiryNum = $('#inquiryNum').val();
      var password = $('#inputPassword').val();

      $.ajax({
        url: '<c:url value="/customer/verifyPassword" />',
        method: 'POST',
        data: {
          inq_num: inquiryNum,
          password: password
        },
        success: function(response) {
          if (response.valid) {
            window.location.href = '<c:url value="/customer/inquiryDetail" />?inq_num=' + inquiryNum;
          } else {
            alert('비밀번호가 틀렸습니다.');
          }
        },
        error: function() {
          alert('비밀번호 확인 중 오류가 발생했습니다.');
        }
      });
    }
  </script>
</body>
</html>
