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
  <div id="container">
		<div class="row">
			<div id="sidebar">
        <%@ include file="customer_sidebar.jsp" %>
      </div>
      <!--  -->
		 <div class="container">
        <!-- 1:1 문의 리스트 -->
        <div class="content">
            <h1>1:1 문의</h1>
            <div class="info">
                <p>1:1 문의를 접수해 주세요</p>
                <p>접수하신 글은 비밀글로 등록되어 작성자와 관리자만 확인 가능합니다.</p>
            </div>

            <!-- 1:1 문의하기 버튼 -->
            <div class="button-container">
                <button class="btn btn-primary" onclick="location.href='<c:url value='/customer/inquiryForm' />'">1:1 문의</button>
            </div>

            <!-- 검색 -->
            <div class="search-container">
                <input type="text" id="search-input" placeholder="검색어를 입력해 주세요.">
                <button id="search-button">검색</button>
            </div>

            <!-- 문의 리스트 -->
            <div class="table-responsive" id="inquiry-table">
                <c:choose>
                    <c:when test="${empty inquiries}">
                        <p>문의 내역이 없습니다.</p>
                    </c:when>
                    <c:otherwise>
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
                                        <td>${inquiry.inq_num}</td>
                                        <td><a href="<c:url value='/customer/inquiryDetail?inq_num=${inquiry.inq_num}' />">${inquiry.inq_title}</a></td>
                                        <td>${inquiry.inq_status}</td>
                                        <td>${inquiry.inq_date}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이지 네비게이션 -->
            <div class="pagination">
                <ul>
                    <c:forEach begin="1" end="${totalPages}" var="page">
                        <li><a href="?page=${page}">${page}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <script>
        // 검색 기능
        $(document).ready(function() {
            $('#search-button').click(function() {
                const keyword = $('#search-input').val();
                if (keyword) {
                    location.href = "<c:url value='/customer/inquiryList' />?keyword=" + keyword;
                }
            });
        });
    </script>
   		<!--  -->
      </div>
    </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>