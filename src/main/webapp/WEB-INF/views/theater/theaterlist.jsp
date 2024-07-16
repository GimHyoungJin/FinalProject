<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>전체 극장</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/theater/theater.css' />" rel="stylesheet" type="text/css"> <!-- theater.css 추가 -->
</head>
<body>
  <%@ include file="/WEB-INF/header.jsp" %>

  <div class="container mt-4">
    <br><br><h5>전체 극장</h5><br><br>

    <div class="theater-box" style="height: 292px;"> <!-- theater-box 추가 -->
      <ul class="nav nav-tabs" id="theaterTab" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="seoul-tab" data-bs-toggle="tab" data-bs-target="#seoul" type="button" role="tab" aria-controls="seoul" aria-selected="true">서울</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="gyeonggi-tab" data-bs-toggle="tab" data-bs-target="#gyeonggi" type="button" role="tab" aria-controls="gyeonggi" aria-selected="false">경기</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="incheon-tab" data-bs-toggle="tab" data-bs-target="#incheon" type="button" role="tab" aria-controls="incheon" aria-selected="false">인천</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="gangwon-tab" data-bs-toggle="tab" data-bs-target="#gangwon" type="button" role="tab" aria-controls="gangwon" aria-selected="false">강원</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="daejeon_chungcheong-tab" data-bs-toggle="tab" data-bs-target="#daejeon_chungcheong" type="button" role="tab" aria-controls="daejeon_chungcheong" aria-selected="false">대전/충청</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="busan_daegu-tab" data-bs-toggle="tab" data-bs-target="#busan_daegu" type="button" role="tab" aria-controls="busan_daegu" aria-selected="false">부산/대구</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="gwangju_jeolla-tab" data-bs-toggle="tab" data-bs-target="#gwangju_jeolla" type="button" role="tab" aria-controls="gwangju_jeolla" aria-selected="false">광주/전라</button>
        </li>
      </ul>

      <div class="tab-content" id="theaterTabContent">
        <div class="tab-pane fade show active" id="seoul" role="tabpanel" aria-labelledby="seoul-tab">
          <div class="theater-list-wrapper">
            <div class="theater-list">
              <table class="table">
                <tbody>
                  <c:set var="columnCount" value="0" />
                  <tr>
                    <c:forEach var="theater" items="${theaterList}">
                      <c:if test="${theater.region_id == 'seoul'}">
                        <td><a href="<c:url value='/theater/detail?id=${theater.theater_id}' />">${theater.theater_name}</a></td> <!-- 여기서 no를 id로 변경 -->
                        <c:set var="columnCount" value="${columnCount + 1}" />
                        <c:if test="${columnCount % 4 == 0}">
                          </tr><tr>
                        </c:if>
                      </c:if>
                    </c:forEach>
                    <!-- 남은 셀을 빈 셀로 채우기 -->
                    <c:forEach begin="${columnCount % 4}" end="3" var="i">
                      <td></td>
                    </c:forEach>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="gyeonggi" role="tabpanel" aria-labelledby="gyeonggi-tab">
          <div class="theater-list-wrapper">
            <div class="theater-list">
              <table class="table">
                <tbody>
                  <c:set var="columnCount" value="0" />
                  <tr>
                    <c:forEach var="theater" items="${theaterList}">
                      <c:if test="${theater.region_id == 'gyeonggi'}">
                        <td><a href="<c:url value='/theater/detail?id=${theater.theater_id}' />">${theater.theater_name}</a></td> <!-- 여기서 no를 id로 변경 -->
                        <c:set var="columnCount" value="${columnCount + 1}" />
                        <c:if test="${columnCount % 4 == 0}">
                          </tr><tr>
                        </c:if>
                      </c:if>
                    </c:forEach>
                    <!-- 남은 셀을 빈 셀로 채우기 -->
                    <c:forEach begin="${columnCount % 4}" end="3" var="i">
                      <td></td>
                    </c:forEach>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="incheon" role="tabpanel" aria-labelledby="incheon-tab">
          <div class="theater-list-wrapper">
            <div class="theater-list">
              <table class="table">
                <tbody>
                  <c:set var="columnCount" value="0" />
                  <tr>
                    <c:forEach var="theater" items="${theaterList}">
                      <c:if test="${theater.region_id == 'incheon'}">
                        <td><a href="<c:url value='/theater/detail?id=${theater.theater_id}' />">${theater.theater_name}</a></td> <!-- 여기서 no를 id로 변경 -->
                        <c:set var="columnCount" value="${columnCount + 1}" />
                        <c:if test="${columnCount % 4 == 0}">
                          </tr><tr>
                        </c:if>
                      </c:if>
                    </c:forEach>
                    <!-- 남은 셀을 빈 셀로 채우기 -->
                    <c:forEach begin="${columnCount % 4}" end="3" var="i">
                      <td></td>
                    </c:forEach>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="gangwon" role="tabpanel" aria-labelledby="gangwon-tab">
          <div class="theater-list-wrapper">
            <div class="theater-list">
              <table class="table">
                <tbody>
                  <c:set var="columnCount" value="0" />
                  <tr>
                    <c:forEach var="theater" items="${theaterList}">
                      <c:if test="${theater.region_id == 'gangwon'}">
                        <td><a href="<c:url value='/theater/detail?id=${theater.theater_id}' />">${theater.theater_name}</a></td> <!-- 여기서 no를 id로 변경 -->
                        <c:set var="columnCount" value="${columnCount + 1}" />
                        <c:if test="${columnCount % 4 == 0}">
                          </tr><tr>
                        </c:if>
                      </c:if>
                    </c:forEach>
                    <!-- 남은 셀을 빈 셀로 채우기 -->
                    <c:forEach begin="${columnCount % 4}" end="3" var="i">
                      <td></td>
                    </c:forEach>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="daejeon_chungcheong" role="tabpanel" aria-labelledby="daejeon_chungcheong-tab">
          <div class="theater-list-wrapper">
            <div class="theater-list">
              <table class="table">
                <tbody>
                  <c:set var="columnCount" value="0" />
                  <tr>
                    <c:forEach var="theater" items="${theaterList}">
                      <c:if test="${theater.region_id == 'daejeon_chungcheong'}">
                        <td><a href="<c:url value='/theater/detail?id=${theater.theater_id}' />">${theater.theater_name}</a></td> <!-- 여기서 no를 id로 변경 -->
                        <c:set var="columnCount" value="${columnCount + 1}" />
                        <c:if test="${columnCount % 4 == 0}">
                          </tr><tr>
                        </c:if>
                      </c:if>
                    </c:forEach>
                    <!-- 남은 셀을 빈 셀로 채우기 -->
                    <c:forEach begin="${columnCount % 4}" end="3" var="i">
                      <td></td>
                    </c:forEach>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="busan_daegu" role="tabpanel" aria-labelledby="busan_daegu-tab">
          <div class="theater-list-wrapper">
            <div class="theater-list">
              <table class="table">
                <tbody>
                  <c:set var="columnCount" value="0" />
                  <tr>
                    <c:forEach var="theater" items="${theaterList}">
                      <c:if test="${theater.region_id == 'busan_daegu'}">
                        <td><a href="<c:url value='/theater/detail?id=${theater.theater_id}' />">${theater.theater_name}</a></td> <!-- 여기서 no를 id로 변경 -->
                        <c:set var="columnCount" value="${columnCount + 1}" />
                        <c:if test="${columnCount % 4 == 0}">
                          </tr><tr>
                        </c:if>
                      </c:if>
                    </c:forEach>
                    <!-- 남은 셀을 빈 셀로 채우기 -->
                    <c:forEach begin="${columnCount % 4}" end="3" var="i">
                      <td></td>
                    </c:forEach>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="gwangju_jeolla" role="tabpanel" aria-labelledby="gwangju_jeolla-tab">
          <div class="theater-list-wrapper">
            <div class="theater-list">
              <table class="table">
                <tbody>
                  <c:set var="columnCount" value="0" />
                  <tr>
                    <c:forEach var="theater" items="${theaterList}">
                      <c:if test="${theater.region_id == 'gwangju_jeolla'}">
                        <td><a href="<c:url value='/theater/detail?id=${theater.theater_id}' />">${theater.theater_name}</a></td> <!-- 여기서 no를 id로 변경 -->
                        <c:set var="columnCount" value="${columnCount + 1}" />
                        <c:if test="${columnCount % 4 == 0}">
                          </tr><tr>
                        </c:if>
                      </c:if>
                    </c:forEach>
                    <!-- 남은 셀을 빈 셀로 채우기 -->
                    <c:forEach begin="${columnCount % 4}" end="3" var="i">
                      <td></td>
                    </c:forEach>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <br><br><br><br><br>
  <div class="container mt-4">

  </div>
  
  <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>
