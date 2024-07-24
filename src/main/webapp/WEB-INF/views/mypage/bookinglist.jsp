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
  <%@ include file="../../header.jsp" %>

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
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a class="nav-link active" data-bs-toggle="tab" href="#booking">예매 내역</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" data-bs-toggle="tab" href="#purchase">구매 내역</a>
            </li>
          </ul>

          <div class="tab-content">
            <div id="booking" class="tab-pane fade show active mt-3">
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
                                    <th>좌석 정보</th>
                                    <th>예매 날짜</th>
                                    <th>사용자 이름</th>
                                    <th>영화 제목</th>
                                    <th>극장 이름</th>
                                  </tr>
                                </thead>
                                <tbody id="bookingTable">
                                  <c:forEach var="booking" items="${bookingList}">
                                    <tr>
                                      <td>${booking.resId}</td>
                                      <td>${booking.memId}</td>
                                      <td>${booking.resSeatInfo}</td>
                                      <td>${booking.resDate}</td>
                                      <td>${booking.username}</td>
                                      <td>${booking.movieTitle}</td>
                                      <td>${booking.theaterName}</td>
                                    </tr>
                                  </c:forEach>
                                </tbody>
                              </table>
                            </div>
                          </div>
                          <div class="d-flex justify-content-center mt-3">
                           
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

           <div id="purchase" class="tab-pane fade mt-3">
  <h2>구매 내역</h2>
  <div class="card mt-3">
    <div class="card-body">
      <h5 class="card-title">구매내역</h5>
      <c:choose>
        <c:when test="${loggedIn}">
          <c:choose>
            <c:when test="${not empty orderList}">
              <div id="orderContent">
                <div id="main-info">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>주문 번호</th>
                        <th>결제일시</th>
                        <th>구분</th>
                        <th>상품명</th>
                        <th>결제금액</th>
                        <th>상태</th>
                      </tr>
                    </thead>
                    <tbody id="orderTable">
                      <c:forEach var="order" items="${orderList}">
                        <tr>
                          <td>${order.orderNo}</td>
                          <td>${order.orderDate}</td>
                          <td>${order.orderType}</td>
                          <td>${order.productName}</td>
                          <td>${order.orderDetailPrice}</td>
                          <td>${order.orderState}</td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </c:when>
            <c:otherwise>
              <p>구매내역이 없습니다.</p>
            </c:otherwise>
          </c:choose>
        </c:when>
        <c:otherwise>
          <p>구매내역이 없습니다. 로그인 후 구매내역을 확인할 수 있습니다.</p>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="../../footer.jsp" %>
</body>
</html>
