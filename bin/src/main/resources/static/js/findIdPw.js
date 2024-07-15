$(document).ready(function() {
    // 전화번호 포맷팅 함수
    function formatPhone(phone) {
      phone = phone.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자는 제거
      if (phone.length > 3 && phone.length <= 7) {
        phone = phone.replace(/(\d{3})(\d+)/, '010-$2');
      } else if (phone.length > 7) {
        phone = phone.replace(/(\d{3})(\d{3,4})(\d{4})/, '010-$2-$3');
      }
      return phone;
    }

    // 아이디 찾기 전화번호 입력 필드 이벤트
    $("#phone-id").on("input", function() {
      $(this).val(formatPhone($(this).val()));
    });

    // 비밀번호 찾기 전화번호 입력 필드 이벤트
    $("#phone-pw").on("input", function() {
      $(this).val(formatPhone($(this).val()));
    });

    // 폼 제출 유효성 검사 함수
    function validatePhone(formId, phoneId, feedbackId) {
      $(formId).on("submit", function(e) {
        e.preventDefault();
        var phone = $(phoneId).val();
        var phonePattern = /^010-\d{3,4}-\d{4}$/;

        if (!phonePattern.test(phone)) {
          $(feedbackId).text("유효한 전화번호를 입력하세요.").show();
          $(phoneId).addClass("is-invalid");
        } else {
          // 데이터가 유효하다면 폼 제출
          $(feedbackId).text("").hide();
          $(phoneId).removeClass("is-invalid");
          e.currentTarget.submit();
        }
      });
    }

    // 이메일 형식 유효성 검사 함수
    function validateEmail(emailId, feedbackId) {
      var email = $(emailId).val();
      var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

      if (!emailPattern.test(email)) {
        $(feedbackId).text("유효한 이메일 주소를 입력하세요.").show();
        $(emailId).addClass("is-invalid");
        return false;
      } else {
        $(feedbackId).text("").hide();
        $(emailId).removeClass("is-invalid");
        return true;
      }
    }

    // 아이디 찾기 폼 유효성 검사
    validatePhone("#find-id-form", "#phone-id", "#phone-check-result-id");

    // 비밀번호 찾기 폼 유효성 검사
    $("#find-pw-form").on("submit", function(e) {
      e.preventDefault();
      var emailValid = validateEmail("#email", "#email-check-result-pw");
      var phoneValid = validatePhone("#find-pw-form", "#phone-pw", "#phone-check-result-pw");
      
      if (emailValid && phoneValid) {
        e.currentTarget.submit();
      }
    });
  });