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
  <!-- 공통 끝 -->
  <!-- 개별 파일 시작 -->
  <link href="<c:url value='/css/customer/inquiry.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/smarteditor2/js/lib/jindo2.all.js' />"></script>
  <script src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>
  <script src="<c:url value='/smarteditor2/js/smarteditor2.js' />" charset="utf-8"></script>
  <!-- 개별 파일 끝 -->
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <div id="container" class="d-flex justify-content-center mt-3">
    <div id="main-content" class="d-flex">
      <div id="sidebar" class="me-3">
        <%@ include file="customer_sidebar.jsp" %>
      </div>
      <div class="content">
        <h1>1:1 문의</h1>
        <p>문의하시기 전 FAQ를 확인하시면 궁금증을 더욱 빠르게 해결하실 수 있습니다.</p>
        <form id="submitInquiryForm" method="post" action="<c:url value='/customer/submitInquiry' />">
          <div class="form-group">
            <label for="agree">
              <input type="checkbox" id="agree" name="agree">
              개인정보 수집에 대한 동의 [필수]
            </label>
            <div class="agree-text">
              <p>개인정보 수집 및 이용에 대한 동의를 얻기 위해 본 개인정보 수집 및 이용 방침을 숙지해주세요.</p>
            </div>
          </div>
          <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="mem_id" class="form-control" required>
          </div>
          <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" class="form-control" required>
          </div>
          <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="inq_title" class="form-control" required>
          </div>
          <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="inq_content" class="form-control" rows="10" style="display:none;"></textarea>
          </div>
          <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" class="form-control" required>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn btn-primary">등록하기</button>
            <button type="reset" class="btn btn-secondary">다시입력</button>
            <button type="button" class="btn btn-tertiary cancelButton">작성취소</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>

  <!-- SmartEditor2 초기화 -->
  <script type="text/javascript">
    $(document).ready(function() {
      console.log("Document is ready");

      var oEditors = [];

      nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "content",
        sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html' />",
        fCreator: "createSEditor2",
        fOnAppLoad: function() {
          console.log("SmartEditor2 is loaded");

          // SmartEditor2가 로드된 후 이벤트 설정
          var form = $("#submitInquiryForm");
          if (form.length) {
            console.log("Form found");

            form.on("submit", function(e) {
              e.preventDefault();

              // SmartEditor2 내용을 textarea로 업데이트
              oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

              // 개인정보수집 동의 확인
              if ($('#agree').prop('checked') === false) {
                alert('개인정보수집에 동의해주세요.');
                return false;
              }

              // AJAX로 폼 제출
              $.ajax({
                type: 'POST',
                url: $(this).attr('action'),
                data: $(this).serialize(),
                success: function(response) {
                  alert('1:1 문의가 등록되었습니다.');
                  window.location.href = '/customer/inquiryList';
                },
                error: function() {
                  alert('문의 제출 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
              });
            });

            // 작성취소 버튼 클릭 시 페이지 이동
            $('.cancelButton').on('click', function() {
              window.location.href = '/customer/inquiryList';
            });
          } else {
            console.log("Form not found");
          }
        }
      });
    });
  </script>
</body>
</html>
