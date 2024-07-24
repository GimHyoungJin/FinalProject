<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>나의 문의내역</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
</head>
<body>
  <%@ include file="/WEB-INF/header.jsp" %>
 
 <div class="container-fluid mypage-container">
    <div class="row">
      <div class="col-md-3 sidebar">
        <div class="list-group">
          <a href="<c:url value='/mypage/mypage' />" class="list-group-item header" aria-current="true">
            나의 무비오
          </a>
        <a href="<c:url value='/mypage/bookinglist' />" class="list-group-item list-group-item-action">예매/구매 내역</a>
          <a href="<c:url value='/mypage/inquiry' />" class="list-group-item list-group-item-action">나의 문의내역</a>
          <a href="<c:url value='/mypage/profile' />" class="list-group-item list-group-item-action">회원정보</a>
          <a href="<c:url value='/mypage/store_vouchers' />" class="list-group-item list-group-item-action">스토어 교환권</a>
        </div>
      </div>
      <div class="col-md-9">
        <h2>나의 문의내역</h2>
        <div class="mt-3 mb-3">
        </div>
        <ul class="nav nav-tabs tab-block">
          <li class="nav-item"><a class="nav-link active" href="#" data-type="inquiry">1:1 문의내역</a></li>
          <li class="nav-item"><a class="nav-link active" href="#" data-type="lost">분실물 문의내역</a></li>
        </ul>
 		<br><br>
 		<button class="btn btn-primary" onclick="location.href='http://localhost:8080/customer/inquiryForm'">1:1 문의하기</button>
        <p class="mt-3">고객센터를 통해 남기신 1:1 문의내역을 확인하실 수 있습니다.</p>
        <div class="table-responsive" id="inquiry-table">
          <c:choose>
            <c:when test="${empty inquiry}">
              <p>문의내역이 없습니다.</p>
            </c:when>
            <c:otherwise>
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>회원 ID</th>
                    <th>유형</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>등록일</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="inq" items="${inquiry}">
                    <tr>
                      <td>${inq.mem_id}</td>
                      <td>${inq.inq_type}</td>
                      <td>${inq.inq_title}</td>
                      <td>${inq.inq_content}</td>
                      <td>${inq.inq_date}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="table-responsive" id="lost-table" style="display:none;">
          <c:choose>
            <c:when test="${empty lostInquiry}">
              <p>분실물 문의내역이 없습니다.</p>
            </c:when>
            <c:otherwise>
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>회원 ID</th>
                    <th>유형</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>등록일</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="lost" items="${lostInquiry}">
                    <tr>
                      <td>${lost.mem_id}</td>
                      <td>${lost.inq_type}</td>
                      <td>${lost.inq_title}</td>
                      <td>${lost.inq_content}</td>
                      <td>${lost.inq_date}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/footer.jsp" %>

  <script>
    $(document).ready(function() {
      $('ul.nav-tabs li a').click(function(e) {
        e.preventDefault();
        $('ul.nav-tabs li a').removeClass('active');
        $(this).addClass('active');
        var type = $(this).data('type');
        if (type === 'inquiry') {
          $('#inquiry-table').show();
          $('#lost-table').hide();
          $('p.mt-3').text('고객센터를 통해 남기신 1:1 문의내역을 확인하실 수 있습니다.');
        } else if (type === 'lost') {
          $('#inquiry-table').hide();
          $('#lost-table').show();
          $('p.mt-3').text('고객센터를 통해 남기신 분실물 문의내역을 확인하실 수 있습니다.');
        }
      });
    });
  </script>
</body>
</html>
