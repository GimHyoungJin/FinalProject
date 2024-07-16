<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>theater</title>
  <meta charset="utf-8">
  <script src="<c:url value='/js/jquery-3.7.1.min.js' />"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
  
  <style>
    .sidebar {
      height: 100%;
      padding-top: 20px;
      background-color: #f8f9fa;
      border-right: 1px solid #dee2e6;
    }
    .sidebar .list-group-item.active {
      background-color: #007bff;
      border-color: #007bff;
    }
    .main-content {
      padding: 20px;
    }
    .card {
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/header.jsp" %>
  <div class="container-fluid">
    <div class="row">
      <!-- 사이드바 -->
      <div class="col-md-3 sidebar">
        <div class="list-group">
   		 <div class="list-group-item header" aria-current="true">
    		관리자 페이지
		 </div>
         <a href="<c:url value='/admin/members' />" class="list-group-item list-group-item-action">회원 관리</a>
         <a href="<c:url value='/admin/movie' />" class="list-group-item list-group-item-action">영화 관리</a>
          
        </div>
      </div>
      <!-- 메인 콘텐츠 -->
      <div class="col-md-9 main-content">
        <h1> 영화관 관리 </h1>
        <br><br><br> <h3 class="card-title">기본정보</h3>
        <!-- 영화관 관리 내용 -->
        <div class="card">
 		  <div class="card-body">
         <form action="<c:url value='/admin/theater/add' />" method="post">
          <div class="mb-3">
            <label for="theaterName" class="form-label">영화 상영관</label>
            <input type="text" class="form-control" id="theaterName" name="theaterName" required>
          </div>
          <div class="mb-3">
            <label for="regionId" class="form-label">지역</label>
            <select class="form-select" id="regionId" name="regionId" required>
              <option value="">지역 선택</option>
              <option value="seoul">서울</option>
              <option value="busan">부산</option>
              <option value="daegu">대구</option>
              <option value="incheon">인천</option>
              <option value="gwangju">광주</option>
              <option value="daejeon">대전</option>
              <option value="ulsan">울산</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="address" class="form-label">주소</label>
            <input type="text" class="form-control" id="address" name="address" required>
          </div>
          <div class="mb-3">
            <label for="screenCount" class="form-label">상영관수</label>
            <input type="number" class="form-control" id="screenCount" name="screenCount" required>
          </div>
          <div class="mb-3">
            <label for="totalSeats" class="form-label">좌석수</label>
            <input type="number" class="form-control" id="totalSeats" name="totalSeats" required>
          </div>
          <div class="mb-3">
            <label for="latitude" class="form-label">위도</label>
            <input type="number" step="0.000001" class="form-control" id="latitude" name="latitude" required>
          </div>
          <div class="mb-3">
            <label for="longitude" class="form-label">경도</label>
            <input type="number" step="0.000001" class="form-control" id="longitude" name="longitude" required>
          </div>
          <button type="submit" class="btn btn-primary">추가</button>
        </form>
        </div>
        </div>
        <br>
        <h3 class="card-title">영화관 목록</h3>
        <div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>지역</th>
              <th>영화관 명</th>
              <th>주소</th>
              <th>상영관수</th>
              <th>좌석수</th>
              <th>위도</th>
              <th>경도</th>
              <th>삭제</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="theater" items="${theaters}">
              <tr>
                <td>${theater.theaterId}</td>
                <td>${theater.regionId}</td>
                <td>${theater.theaterName}</td>
                <td>${theater.address}</td>
                <td>${theater.screenCount}</td>
                <td>${theater.totalSeats}</td>
                <td>${theater.latitude}</td>
                <td>${theater.longitude}</td>
                <td>
                  <form action="<c:url value='/admin/theater/delete' />" method="post">
                    <input type="hidden" name="theaterId" value="${theater.theaterId}">
                    <button type="submit" class="btn btn-danger">삭제</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>