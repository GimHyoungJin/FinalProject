<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원 목록</title>
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
            관리자 메뉴
          </a>
          <a href="<c:url value='/admin/members' />" class="list-group-item list-group-item-action">회원 목록</a>
          <a href="<c:url value='/admin/other' />" class="list-group-item list-group-item-action">기타 메뉴</a>
        </div>
      </div>
      <div class="col-md-9">
        <h2>회원 목록</h2>
        <div class="mt-3 mb-3">
        </div>
        <div class="table-responsive">
          <c:choose>
            <c:when test="${empty members}">
              <p>회원 목록이 없습니다.</p>
            </c:when>
            <c:otherwise>
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>등록일</th>
                    <th>전화번호</th>
                    <th>생년월일</th>
                    <th>성별</th>
                    <th>주소</th>
                    <th>SMS 수신 동의</th>
                    <th>이메일 수신 동의</th>
                    <th>회원 등급</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="member" items="${members}">
                    <tr>
                      <td>${member.id}</td>
                      <td>${member.name}</td>
                      <td>${member.email}</td>
                      <td>${member.joinDate}</td>
                      <td>${member.phone}</td>
                      <td>${member.birthDate}</td>
                      <td>${member.gender}</td>
                      <td>${member.address}</td>
                      <td>${member.smsOptIn}</td>
                      <td>${member.emailOptIn}</td>
                      <td>
                        <form action="<c:url value='/admin/members/updateGrade' />" method="post" class="d-inline">
                          <input type="hidden" name="memberId" value="${member.id}">
                          <select name="grade" class="form-select" onchange="this.form.submit()">
                            <option value="1" <c:if test="${member.grade == 1}">selected</c:if>>일반 회원</option>
                            <option value="2" <c:if test="${member.grade == 2}">selected</c:if>>우수 회원</option>
                            <option value="3" <c:if test="${member.grade == 0}">selected</c:if>>관리자</option>
                          </select>
                        </form>
                      </td>
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
</body>
</html>
