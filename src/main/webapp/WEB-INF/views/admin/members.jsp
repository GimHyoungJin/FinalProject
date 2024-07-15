<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>members</title>
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
          <a href="<c:url value='/admin/theater' />" class="list-group-item list-group-item-action">영화관 관리</a>
          <a href="<c:url value='/admin/movie' />" class="list-group-item list-group-item-action">영화 관리</a>
        </div>
      </div>
      <!-- 메인 콘텐츠 -->
      <div class="col-md-9 main-content">
        <h1> 회원 관리 </h1>
        <br><br><br> <h3 class="card-title">기본정보</h3>
        <div class="card">
          <div class="card-body">
           
            <!-- 회원 검색 폼 -->
            <form class="mb-4" action="<c:url value='/admin/members' />" method="get">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" placeholder="이름, 이메일, 가입일 등으로 검색" value="${param.search}">
                    <button class="btn btn-primary" type="submit">검색</button>
                </div>
            </form>

            <!-- 회원 목록 테이블 -->
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>이름</th>
                        <th>비밀번호</th>
                        <th>이메일</th>
                        <th>전화번호</th>
                        <th>등록일</th>
                        <th>생년월일</th>
                        <th>성별</th>
                        <th>주소</th>
                        <th>sms수신동의</th>
                        <th>email수신동의</th>
                        <th>회원등급</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="member" items="${members}">
                        <tr>
                            <td>${member.id}</td>
                            <td><a href="<c:url value='/admin/members/${member.id}' />">${member.name}</a></td>
                            <td>${member.password}</td>
                            <td>${member.email}</td>
                            <td>${member.phone}</td>
                            <td>${member.joinDate}</td>
                            <td>${member.birth}</td>
                            <td>${member.gender}</td>
                            <td>${member.address}</td>
                            <td><c:choose>
                                  <c:when test="${member.smsOptIn}">Yes</c:when>
                                  <c:otherwise>No</c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:choose>
                                  <c:when test="${member.emailOptIn}">Yes</c:when>
                                  <c:otherwise>No</c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:choose>
                                  <c:when test="${member.grade == 0}">관리자</c:when>
                                  <c:when test="${member.grade == 1}">일반회원</c:when>
                                  <c:when test="${member.grade == 2}">VIP</c:when>
                                  <c:when test="${member.grade == 3}">VVIP</c:when>
                                </c:choose>
                            </td>
                            <td>
                                <form action="<c:url value='/admin/members/updateStatus' />" method="post" class="d-inline">
                                    <input type="hidden" name="memberId" value="${member.id}">
                                    <select name="status" class="form-select" onchange="this.form.submit()">
                                        <option value="active" <c:if test="${member.status == 'active'}">selected</c:if>>활성화</option>
                                        <option value="inactive" <c:if test="${member.status == 'inactive'}">selected</c:if>>비활성화</option>
                                        <option value="deleted" <c:if test="${member.status == 'deleted'}">selected</c:if>>삭제</option>
                                    </select>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 페이지 네이션 (선택 사항) -->
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                            <a class="page-link" href="?page=${i}&search=${param.search}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
          </div>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>
