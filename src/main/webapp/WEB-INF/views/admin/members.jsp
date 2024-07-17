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
            관리자 페이지
          </a>
         <a href="<c:url value='/admin/movie' />" class="list-group-item list-group-item-action">영화 관리</a>
           <a href="<c:url value='/admin/theater' />" class="list-group-item list-group-item-action">영화관 관리</a>
        </div>
      </div>
      <div class="col-md-9">
        <h1>회원 관리</h1>
        <br><br><br> 
        <div class="mt-3 mb-3">
          <form class="mb-4" action="<c:url value='/admin/members/add' />" method="post">
              <div class="mb-3">
                  <label for="memId" class="form-label">회원 ID</label>
                  <input type="text" class="form-control" id="memId" name="mem_id" required>
              </div>
              <div class="mb-3">
                  <label for="username" class="form-label">이름</label>
                  <input type="text" class="form-control" id="username" name="username" required>
              </div>
              <div class="mb-3">
                  <label for="password" class="form-label">비밀번호</label>
                  <input type="password" class="form-control" id="password" name="passwd" required>
              </div>
              <div class="mb-3">
                  <label for="email" class="form-label">이메일</label>
                  <input type="email" class="form-control" id="email" name="email" required>
              </div>
              <div class="mb-3">
                  <label for="phone" class="form-label">전화번호</label>
                  <input type="text" class="form-control" id="phone" name="phone" required>
              </div>
              <div class="mb-3">
                  <label for="birth" class="form-label">생년월일</label>
                  <input type="text" class="form-control" id="birth" name="birth" required>
              </div>
              <div class="mb-3">
                  <label for="gender" class="form-label">성별</label>
                  <input type="text" class="form-control" id="gender" name="gender" required>
              </div>
              <div class="mb-3">
                  <label for="zipcode" class="form-label">우편번호</label>
                  <input type="text" class="form-control" id="zipcode" name="zipcode" required>
              </div>
              <div class="mb-3">
                  <label for="address1" class="form-label">주소 1</label>
                  <input type="text" class="form-control" id="address1" name="address1" required>
              </div>
              <div class="mb-3">
                  <label for="address2" class="form-label">주소 2</label>
                  <input type="text" class="form-control" id="address2" name="address2" required>
              </div>
              <div class="mb-3">
                  <label for="smsAgree" class="form-label">SMS 수신 동의</label>
                  <input type="text" class="form-control" id="smsAgree" name="sms_agree" required>
              </div>
              <div class="mb-3">
                  <label for="emailAgree" class="form-label">이메일 수신 동의</label>
                  <input type="text" class="form-control" id="emailAgree" name="email_agree" required>
              </div>
              <button type="submit" class="btn btn-primary">추가</button>
          </form>
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
                    <th>비밀번호</th>
                    <th>이메일</th>
                    <th>등록일</th>
                    <th>전화번호</th>
                    <th>생년월일</th>
                    <th>성별</th>
                    <th>주소</th>
                    <th>SMS 수신 동의</th>
                    <th>이메일 수신 동의</th>
                    <th>회원 등급</th>
                    <th>관리</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="member" items="${members}">
                    <tr>
                      <td>${member.mem_id}</td>
                      <td>${member.username}</td>
                      <td>${member.passwd}</td>
                      <td>${member.email}</td>
                      <td>${member.regdate}</td>
                      <td>${member.phone}</td>
                      <td>${member.birth}</td>
                      <td>${member.gender}</td>
                      <td>${member.address}</td>
                      <td>${member.sms_agree}</td>
                      <td>${member.email_agree}</td>
                      <td>
                          <form action="<c:url value='/admin/members/updateGrade' />" method="post" class="d-inline">
                              <input type="hidden" name="mem_id" value="${member.mem_id}">
                              <select name="mem_grade" class="form-select" onchange="this.form.submit()">
                                  <option value="1" <c:if test="${member.mem_grade == 1}">selected</c:if>>일반 회원</option>
                                  <option value="2" <c:if test="${member.mem_grade == 2}">selected</c:if>>우수 회원</option>
                                  <option value="0" <c:if test="${member.mem_grade == 0}">selected</c:if>>관리자</option>
                              </select>
                          </form>
                      </td>
                      <td>
                          <form action="<c:url value='/admin/members/delete' />" method="post" class="d-inline">
                              <input type="hidden" name="mem_id" value="${member.mem_id}">
                              <button type="submit" class="btn btn-danger">삭제</button>
                          </form>
                          <a href="<c:url value='/admin/members/edit?mem_id=${member.mem_id}' />" class="btn btn-primary">수정</a>
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
