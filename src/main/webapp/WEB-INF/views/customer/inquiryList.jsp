<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>1:1문의 목록</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->
  <!-- 개별파일 시작 -->
  <link href="<c:url value='/css/customer/inquiry.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/js/inquiry.js' />"></script>
  <!-- 개별 파일 끝 -->
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
      <div class="container mt-5">
        <h1>1:1 문의</h1>
        <p>1:1 문의를 접수 해 주세요. 접수하신 글은 비밀글로 등록되어 작성자와 관리자만 확인 가능합니다.</p>
        
        <!-- 1:1 문의하기 버튼 -->
        <button class="btn btn-primary mb-3" onclick="location.href='<c:url value='/customer/inquiryForm' />'">1:1 문의</button>

        <!-- 검색 입력란과 버튼 -->
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="검색어를 입력해 주세요." aria-label="검색어를 입력해 주세요." aria-describedby="button-search">
            <button class="btn btn-outline-secondary" type="button" id="button-search">검색</button>
        </div>

        <!-- 문의 목록 테이블 -->
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
                    <tr>
                        <!-- 문의 번호 -->
                        <td>${inquiry.inq_num}</td>
                        <!-- 문의 제목 클릭 시 상세보기로 이동 -->
                        <td><a href="<c:url value='/customer/inquiryDetail?inq_num=${inquiry.inq_num}' />">${inquiry.inq_title}</a></td>
                        <!-- 문의 답변 상태 -->
                        <td>${inquiry.answerStatus}</td>
                        <!-- 문의 등록일 -->
                        <td>${inquiry.inq_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 페이지 네비게이션 -->
        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <c:forEach var="page" begin="1" end="${totalPages}">
                    <li class="page-item ${page == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${page}">${page}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>