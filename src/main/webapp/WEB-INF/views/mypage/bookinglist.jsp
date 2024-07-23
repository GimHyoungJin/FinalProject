<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>예매/구매 내역</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/style.css' />" rel="stylesheet" type="text/css">
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
        <div class="container mt-5">
          <h2>예매 내역</h2>
          <div class="card mt-3">
            <div class="card-body">
              <h5 class="card-title">예매내역</h5>
              <c:choose>
                <c:when test="${loggedIn}">
                  <c:choose>
                    <c:when test="${not empty bookingList}">
                      <div id="bookingContent">
                        <div id="main-info">
                          <table class="table table-bordered">
                            <thead>
                              <tr>
                                <th>예매 ID</th>
                                <th>회원 ID</th>
                                <th>영화 ID</th>
                                <th>좌석 정보</th>
                                <th>성인</th>
                                <th>청소년</th>
                                <th>아동</th>
                                <th>총 인원(티켓) 수</th>
                                <th>예매 날짜</th>
                                <th>사용자 이름</th>
                                <th>이메일</th>
                                <th>영화 제목</th>
                                <th>극장 이름</th>
                                <th>주소</th>
                              </tr>
                            </thead>
                            <tbody id="bookingTable">
                              <c:forEach var="booking" items="${bookingList}">
                                <tr>
                                  <td>${booking.resId}</td>
                                  <td>${booking.memId}</td>
                                  <td>${booking.screenMovieId}</td>
                                  <td>${booking.resSeatInfo}</td>
                                  <td>${booking.adult}</td>
                                  <td>${booking.teenager}</td>
                                  <td>${booking.child}</td>
                                  <td>${booking.totPeople}</td>
                                  <td>${booking.resDate}</td>
                                  <td>${booking.username}</td>
                                  <td>${booking.email}</td>
                                  <td>${booking.movieTitle}</td>
                                  <td>${booking.theaterName}</td>
                                  <td>${booking.address}</td>
                                </tr>
                              </c:forEach>
                            </tbody>
                          </table>
                        </div>
                      </div>
                      <div class="d-flex justify-content-center mt-3">
                        <form action="<c:url value='/mypage/bookinglist' />" method="get">
                          <input type="hidden" name="offset" value="${offset}" />
                          <button type="submit" class="btn btn-primary">더보기</button>
                        </form>
                      </div>
                    </c:when>
                    <c:otherwise>
                      <p>예매내역이 없습니다.</p>
                    </c:otherwise>
                  </c:choose>
                </c:when>
                <c:otherwise>
                  <p>예매내역이 없습니다. 로그인 후 예매내역을 확인할 수 있습니다.</p>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>
