<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>1:1 문의</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 시작 끝 -->
  <link href="<c:url value='/css/inquiry.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/sidebar.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/js/inquiry.js' />"></script>

</head>
<body>
  <%@ include file="../../header.jsp" %>

	<div id="container">
		<div class="row">
			<div id="sidebar">
        <%@ include file="customer_sidebar.jsp" %>
      </div>
      <div class="col-md-9">
        <h1>1:1 문의</h1>
        <p class="description">고객님의 문의에 정확한 답변을 위해 문의하신 고객의 예약 내역 및 사용기록을 조회할 수 있습니다. 고객님께서 제공하신 정보는 문의사항 조회용으로만 사용됩니다.</p>
        <p class="description">문의사항이 FAQ에 포함되었는지 공고된 공지를 먼저 확인해 보시기 바랍니다.</p>
        <div id="info-box">
          <div id="info-header">
            <span>개인정보 수집에 대한 동의</span>
            <span id="required">필수*</span>
          </div>
          <p id="info-content">
            개인정보 수집에 동의해 주셔야 문의사항 등록이 가능합니다. 개인정보는 오직 문의사항 답변용으로만 사용되며, 다른 용도로는 사용되지 않습니다.
          </p>
        </div>
        <form action="<c:url value='/customer/submitInquiry' />" method="post" enctype="multipart/form-data">
          <div class="form-group">
            <label for="inquiry-type">문의유형</label>
            <select id="inquiry-type" name="inq_type" class="form-control">
              <option value="customer">고객센터</option>
              <option value="theater">지점문의</option>
            </select>
          </div>
          <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" class="form-control">
          </div>
          <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" class="form-control">
          </div>
          <div class="form-group">
            <label for="phone">휴대폰</label>
            <input type="text" id="phone" name="phone" class="form-control">
          </div>
          <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="inq_title" class="form-control">
          </div>
          <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="inq_content" class="form-control" rows="5"></textarea>
          </div>
          <div class="form-group">
            <label for="file">첨부파일</label>
            <input type="file" id="file" name="file" class="form-control">
          </div>
          <button type="submit" id="submit-btn" class="btn btn-primary">등록</button>
        </form>
      </div>
    </div>
  </div>

  <%@ include file="../../footer.jsp" %>
</body>
</html>
