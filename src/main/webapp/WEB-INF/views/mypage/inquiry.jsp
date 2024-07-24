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
  <style>
    .table-custom thead th {
      background-color: #000;
      color: #fff;
      border-bottom: 2px solid #4a4a4a;
    }
    .table-custom tbody tr:nth-child(odd) {
      background-color: #f2f2f2;
    }
    .table-custom tbody tr:nth-child(even) {
      background-color: #fff;
    }
    .table-custom tbody tr:hover {
      background-color: #ddd;
    }
    .table-custom tbody td {
      border-top: 1px solid #4a4a4a;
    }
  </style>
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
              <a class="nav-link active" data-bs-toggle="tab" href="#inquiry">1:1 문의내역</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" data-bs-toggle="tab" href="#lost">분실물 문의내역</a>
            </li>
          </ul>

          <div class="tab-content mt-3">
            <div id="inquiry" class="tab-pane fade show active">
              <h2>1:1 문의내역</h2>
              <button class="btn btn-dark" onclick="location.href='<c:url value='/customer/inquiryForm' />'">문의하기</button>
              <p class="mt-3">고객센터를 통해 남기신 1:1 문의내역을 확인하실 수 있습니다.</p>
              <div class="table-responsive">
                <c:choose>
                  <c:when test="${empty inquiry}">
                    <p>문의내역이 없습니다.</p>
                  </c:when>
                  <c:otherwise>
                    <table class="table table-bordered table-custom">
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
                          <c:if test="${inq.inq_type == '1'}">
                            <tr>
                              <td>${inq.mem_id}</td>
                              <td>1:1 문의</td>
                              <td>${inq.inq_title}</td>
                              <td>${inq.inq_content}</td>
                              <td>${inq.inq_date}</td>
                            </tr>
                          </c:if>
                        </c:forEach>
                      </tbody>
                    </table>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
            <div id="lost" class="tab-pane fade">
              <h2>분실물 문의내역</h2>
              <button class="btn btn-dark" onclick="location.href='<c:url value='/customer/inquiryForm' />'">문의하기</button>
              <p class="mt-3">고객센터를 통해 남기신 분실물 문의내역을 확인하실 수 있습니다.</p>
              <div class="table-responsive">
                <c:choose>
                  <c:when test="${empty inquiry}">
                    <p>분실물 문의내역이 없습니다.</p>
                  </c:when>
                  <c:otherwise>
                    <table class="table table-bordered table-custom">
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
                          <c:if test="${inq.inq_type == '2'}">
                            <tr>
                              <td>${inq.mem_id}</td>
                              <td>분실물 문의</td>
                              <td>${inq.inq_title}</td>
                              <td>${inq.inq_content}</td>
                              <td>${inq.inq_date}</td>
                            </tr>
                          </c:if>
                        </c:forEach>
                      </tbody>
                    </table>
                  </c:otherwise>
                </c:choose>
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
