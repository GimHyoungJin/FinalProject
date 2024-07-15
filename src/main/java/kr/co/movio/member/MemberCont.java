package kr.co.movio.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;


import org.springframework.ui.Model;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;


//회원 가입 및 로그인을 담당하는 컨트롤러
@Controller
@RequestMapping("/member")
public class MemberCont {
	
	//객체가 생성됬는지 안됬는지 확인용
    public MemberCont() {
        System.out.println("-----MemberCont() 객체 생성");
    }

    //MemberService 빈을 가져다 씀
    @Autowired
    private MemberService memberService;
    
    /* 엔드포인트: 서버에서 특정 기능을 수행하기 위해 설정된 URL 
     * ex)/member/login은 로그인 요청을 처리하는 엔드포인트임 */
    
    // 이용 약관 동의 페이지를 보여주는 엔드포인트
    @GetMapping("/agreement")
    // 이용약관 페이지로 리다이렉트
    // 브라우저에서 "/member/agreement"로 get 요청을 하면 "/member/form"으로 리다이렉트됨
    public String agreement() {
        return "member/agreement";
    }

    //아이디 비밀번호 찾기 페이지를 보여주는 엔드포인트
    @GetMapping("/findIdPw")
    //아이디 비밀번호 찾기 페이지로 리다이렉트
    public String findIdPw() {
    	return "member/findIdPw";
    }
    
    
    // 이용 약관 동의 후 회원 가입 폼으로 리다이렉트하는 엔드포인트
    @PostMapping("/agreement")
    // "member/agreement" 뷰 템플릿을 반환하여 이용 약관 동의 페이지를 표시
    // 브라우저에서 "/member/agreement"로 post 요청을 하면 "member/agreement.jsp" 파일이 렌더링됨
    public String processAgreement() {
        return "redirect:/member/form";
    }
    
    
    // 회원 가입 폼을 보여주는 엔드포인트
    @GetMapping("/form")
    public String form() {
    	// "member/memberForm" 뷰 템플릿을 반환하여 회원 가입 폼 페이지를 표시
        // 동작: 브라우저에서 "/member/form"으로 GET 요청을 하면 "member/memberForm.jsp" 파일이 렌더링됨
        return "member/memberForm";
    }
    
    
    // 아이디 중복 확인을 처리하는 엔드포인트
    @PostMapping("/checkId")
    public ResponseEntity<?> checkId(@RequestBody Map<String, String> requestBody) {
    	// 요청 바디에서 "mem_id" 값을 추출
        String mem_id = requestBody.get("mem_id");
        // 아이디 중복 여부를 확인
        boolean isDuplicate = memberService.checkId(mem_id);
        // 중복 여부를 JSON 형태로 응답
        // 브라우저에서 "/member/checkId"로 POST 요청을 보내고, 요청 바디에 JSON 형태로 "mem_id"를 포함하면,
        // JSON 형태로 {"isDuplicate": true/false} 응답을 받음
        return ResponseEntity.ok(Map.of("isDuplicate", isDuplicate));
    }

    
    // 이메일 중복 확인을 처리하는 엔드포인트
    @PostMapping("/checkEmail")
    public ResponseEntity<?> checkEmail(@RequestBody Map<String, String> requestBody) {
    	// 요청 바디에서 "email" 값을 추출
        String email = requestBody.get("email");
        // 이메일 중복 여부를 확인
        boolean isDuplicate = memberService.checkEmail(email);
        // 중복 여부를 JSON 형태로 응답
        // 브라우저에서 "/member/checkEmail"로 POST 요청을 보내고, 요청 바디에 JSON 형태로 "email"을 포함하면,
        // JSON 형태로 {"isDuplicate": true/false} 응답을 받음
        return ResponseEntity.ok(Map.of("isDuplicate", isDuplicate));
    }

    
    // 전화번호 중복확인을 처리하는 엔드포인트
    @PostMapping("/checkPhone")
    public ResponseEntity<?> checkPhone(@RequestBody Map<String, String> requestBody) {
    	//요청 바디에서 "phone"을 출력
        String phone = requestBody.get("phone");
        //중복 여부를 확인함
        boolean isDuplicate = memberService.checkPhone(phone);
        // 중복 여부를 JSON 형태로 응답
        // 브라우저에서 "/member/checkPhone"로 POST 요청을 보내고, 요청 바디에 JSON 형태로 "phone"을 포함하면,
        // JSON 형태로 {"isDuplicate": true/false} 응답을 받음
        return ResponseEntity.ok(Map.of("isDuplicate", isDuplicate));
    }
    
    
    //회원가입을 처리하는 엔드포인트
    @PostMapping(value = "/register", consumes = "application/json", produces = "application/json")
    public ResponseEntity<?> register(@RequestBody MemberDTO member, HttpSession session) {
    	// 회원 등록 처리
        boolean isRegistered = memberService.register(member);
        // 회원 등록 성공 시
        if (isRegistered) {
        	// 성공 응답 반환
            // 브라우저에서 "/member/register"로 JSON 형태의 회원 정보를 POST 요청으로 보내면,
            // JSON 형태로 {"success": true} 응답을 받음
        	 session.setAttribute("username", member.getUsername());
            return ResponseEntity.ok(Map.of("success", true));
        } else {
        	// 실패 응답 반환
            // 동작: 회원 가입 실패 시 JSON 형태로 {"success": false, "message": "회원가입에 실패하였습니다."} 응답을 받음
            return ResponseEntity.ok(Map.of("success", false, "message", "회원가입에 실패하였습니다."));
        }
    }

    
    // 회원 가입 성공 페이지를 보여주는 엔드포인트
    @GetMapping("/success")
    public String registerSuccess() {
    	// "member/success" 뷰 템플릿을 반환하여 회원 가입 성공 페이지를 표시
        // 브라우저에서 "/member/success"로 GET 요청을 하면 "member/success.jsp" 파일이 렌더링됨(사용자에게 보여줌)
        return "member/success";
    }

    
    // 로그인 요청을 처리하는 엔드포인트
    @PostMapping(value = "/login", consumes = "application/json", produces = "application/json")
    public ResponseEntity<?> login(@RequestBody Map<String, String> loginData, HttpSession session) {
    	// 요청 바디에서 "mem_id"와 "passwd" 값을 추출
        String mem_id = loginData.get("mem_id");
        String passwd = loginData.get("passwd");
        
        // 로그인 처리
        if (memberService.login(mem_id, passwd)) {
        	// 성공 응답 반환
            // 브라우저에서 "/member/login"로 JSON 형태의 로그인 데이터를 POST 요청으로 보내면,
            // JSON 형태로 {"success": true} 응답을 받음
            session.setAttribute("mem_id", mem_id);
            return ResponseEntity.ok(Map.of("success", true));
        } else {
        	// 로그인 실패 시 실패 응답 반환
            // 로그인 실패 시 JSON 형태로 {"success": false, "message": "아이디 또는 비밀번호가 잘못되었습니다."} 응답을 받음
            return ResponseEntity.ok(Map.of("success", false, "message", "아이디 또는 비밀번호가 잘못되었습니다."));
        }
    }
    
    
    // 로그아웃 요청을 처리하는 엔드포인트
    @GetMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        session.invalidate(); // 세션 무효화
        // 성공 응답 반환
        // 브라우저에서 "/member/logout"으로 GET 요청을 보내면,
        // JSON 형태로 {"success": true} 응답을 받음
        return ResponseEntity.ok(Map.of("success", true));
    }
  
    
    //카카오 로그인 처리하는 서버 엔드 포인트
    @PostMapping("/kakaoLogin")
    @ResponseBody
    public ResponseEntity<?> kakaoLogin(@RequestBody Map<String, Object> requestBody, HttpSession session) {
        // 클라이언트에서 전달된 액세스 토큰 추출
        String accessToken = (String) requestBody.get("accessToken");
        //액세스 토큰이 없거나 비어있는 경우 잘못된 요청에 대한 응답을 출력
        if (accessToken == null || accessToken.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "액세스 토큰이 필요합니다."));
        }
        //받아온 엑세스 토큰이 무엇인지 콘솔창에 출력
        System.out.println("accessToken: " + accessToken);

        // 액세스 토큰을 사용하여 카카오 API 호출
        RestTemplate restTemplate = new RestTemplate();//API에 요청을 보내기 위한 도구를 준비하는 것이고
        HttpHeaders headers = new HttpHeaders();//요청을 보낼 때 추가정보를 설정하는데, 이 요청은 누가 보낸 것이고, 내 권한을 증명하는 토큰은 여기있다는 정보를 포함함
        headers.set("Authorization", "Bearer " + accessToken);//Bearer 토큰 형식으로 인증정보를 추가하는데, 카카오 API에서 이 정보를 활용해 요청자를 식별함
        HttpEntity<String> entity = new HttpEntity<>(headers);//1,2,3의 정보를 하나의 객체로 모아 모든 정보를 포함해 전송함

        ResponseEntity<Map> response; //위의 데이터를 가지고 요청을 보내고 그것에 대한 응답을 해당 객체에 저장함(response)
        try {
            // 카카오 API 호출
            response = restTemplate.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.GET,
                entity,
                Map.class
            );
        } catch (HttpClientErrorException e) {
            // 4xx 에러 처리, 유효하지 않은 액세스 토큰의 경우 
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("success", false, "message", "유효하지 않은 액세스 토큰입니다."));
        } catch (Exception e) {
            // 기타 다른 예외 처리들을 처리함
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false, "message", "카카오 API 호출 중 오류가 발생했습니다."));
        }

        // 카카오 API 응답에서 사용자 정보 추출
        Map<String, Object> userInfo = response.getBody();
        if (userInfo == null) {
            // 사용자 정보가 없을 경우 응답
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("success", false, "message", "사용자 정보를 가져오지 못했습니다."));
        }

        // 받아온 정보를 각각 추출하여 로그 출력
        //사용자의 카카오 ID를 추출하여 출력함
        String kakaoId = String.valueOf(userInfo.get("id"));
        System.out.println("카카오 ID: " + kakaoId);

        // 사용자 닉네임 추출
        Map<String, Object> properties = (Map<String, Object>) userInfo.get("properties");
        String nickname = properties != null ? String.valueOf(properties.get("nickname")) : "N/A";
        System.out.println("닉네임: " + nickname);

        // 사용자 이메일 추출
        Map<String, Object> kakaoAccount = (Map<String, Object>) userInfo.get("kakao_account");
        String email = kakaoAccount != null ? String.valueOf(kakaoAccount.get("email")) : "N/A";
        System.out.println("이메일: " + email);

        // 디버그용 전체 사용자 정보 로그
        System.out.println("카카오 전체 사용자 정보: " + userInfo);

        try {
            // 소셜 회원 테이블에 사용자 정보 저장
            if (!memberService.checkSocialId(kakaoId, "kakao")) {
                SocialMemberDTO socialMemberDto = new SocialMemberDTO();
                socialMemberDto.setSocialId(kakaoId);
                socialMemberDto.setProvider("kakao");
                socialMemberDto.setNickname(nickname);
                socialMemberDto.setEmail(email);

                boolean isRegistered = memberService.regSocialMember(socialMemberDto);

                // 디버그용 로그
                System.out.println("소셜 회원 등록 결과: " + isRegistered);
            }
        } catch (Exception e) {
            // 사용자 정보 저장 실패 시 예외 처리
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false, "message", "사용자 정보를 저장하는데 실패했습니다."));
        }

        // 세션에 사용자 정보 저장
        session.setAttribute("mem_id", kakaoId);
        session.setAttribute("nickname", nickname);
        session.setAttribute("email", email);

        // 로그인 성공 응답 반환
        return ResponseEntity.ok(Map.of("success", true));
    }

    
    //OAuth 2.0 클라이언트의 id로  애플리케이션을 Oauth 서비스와 식별하는데 사용
    private String CLIENT_ID = "1051773193513-6ue0j504qgi80d191t7si0bpoahig155.apps.googleusercontent.com"; 

    //구글 로그인, 클라이언트에서 전송한 구글 토큰을 검증하여, 사용자 정보를 세션에 저장 필요하고 필요시 소셜회원으로 등록한다.
    @PostMapping("/googleLogin")
    public ResponseEntity<?> googleLogin(@RequestBody Map<String, String> requestBody, HttpSession session) {
        try {
            String token = requestBody.get("token");//본문에서 요청한 본문인데 여기에 구글 토큰이 포함됨
            
            //구글 토큰 검증기를 초기화함
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), JacksonFactory.getDefaultInstance())
                    .setAudience(Collections.singletonList(CLIENT_ID))//검증기의 대상이 되는 클라이언트 ID 설정
                    .build();
            
            //가져온 토큰을 검증하고 유효한 ID 토근 객체를 가져온다.
            GoogleIdToken idToken = verifier.verify(token);
            if (idToken != null) {
            	//ID 토큰의 페이로드를 추출함
            	//페이로드란 JWT 형식으로 헤더, 페이로드 서명으로 구성, 사용자와 관련된 데이터가 포함된다.(페이로드가 곧 사용자의 데이터를 의미)
                Payload payload = idToken.getPayload();
                
                //사용자 정보를 추출함
                String googleId = payload.getSubject();//google id
                String name = (String) payload.get("name");//사용자 이름
                String email = payload.getEmail();//email
                String picture = (String) payload.get("picture");//프로필 사진

                // 추출한 사용자 정보를 로그로 출력
                System.out.println("구글 ID: " + googleId);
                System.out.println("닉네임: " + name);
                System.out.println("이메일: " + email);
                System.out.println("프로필 이미지 URL: " + picture);

                // 소셜 회원 테이블에 사용자 정보 저장(중복된 소셜 아이디가 있는지 체크 후)
                if (!memberService.checkSocialId(googleId, "google")) {
                    //새로운 소셜 회원 DTO를 생성하여 정보를 설정함
                	SocialMemberDTO socialMemberDto = new SocialMemberDTO();
                    socialMemberDto.setSocialId(googleId);
                    socialMemberDto.setProvider("google");
                    socialMemberDto.setNickname(name);
                    socialMemberDto.setEmail(email);
                    socialMemberDto.setProfileImage(picture);
                    
                    //소셜 회원 등록 서비스 호출
                    boolean isRegistered = memberService.regSocialMember(socialMemberDto);

                    // 디버그용 로그(소셜 회원 등록 결과 반환) true/false
                    System.out.println("소셜 회원 등록 결과: " + isRegistered);
                }

                // 세션에 사용자 정보 저장
                session.setAttribute("mem_id", googleId);
                session.setAttribute("nickname", name);
                session.setAttribute("email", email);

                // 로그인 성공 응답 반환
                return ResponseEntity.ok(Map.of("success", true));
            } else {
            	//실패시, ID 토큰을 찾을 수없다는 메시지 출력
                System.out.println("Invalid ID token.");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("success", false, "message", "Invalid ID token"));
            }
        } catch (Exception e) {
            e.printStackTrace(); // 에러 로그를 출력하여 원인 파악
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("success", false, "message", "Token validation error"));
        }
    }
    
    
    // 아이디 찾기 요청을 처리하는 엔드포인트 추가,아이디와 이메일을 알려줌
    @PostMapping("/findId")
    public String findId(@RequestParam String username, @RequestParam String phone, Model model) {
        //사용자가 입력한 이름과 전화번호 데이터로 db에서 사용자를 찾음
    	MemberDTO memberDTO = memberService.findUserByUsernameAndPhone(username, phone);
        //만약에 입력한 데이터를 통해 값이 존재한다면
    	if (memberDTO != null) {
    		//뷰에 해당 id와, 이메일 데이터를 전달해서 보여줌
            model.addAttribute("userId", memberDTO.getMem_id());
            model.addAttribute("userEmail", memberDTO.getEmail());
        }
    	//그리고 해당 뷰 페이지를 반환함
        return "member/findIdResult";
    }
    
    //비밀번호 찾기 탭에서 입력한 아이디, 이메일, 핸드폰 번호에 맞는지 비밀번호 찾기에서 동작하는 로직
    //model - 뷰에 데이터를 전달하기 위한 모델 객체
    @PostMapping("/findPassword")
    public String findPassword(@RequestParam String mem_id, @RequestParam String email, @RequestParam String phone, Model model) {
        //사용자가 입력한 아이디, 이메일 , 핸드폰 번호를 토대로 memeber를 찾음
    	MemberDTO user = memberService.findUserByIdEmailAndPhone(mem_id, email, phone);
        //사용자에 대한 데이터가 존재하는 경우, 성공메시지 반호낳과 동시에 사용자 아이디를 model에 추가
    	if (user != null) {
            model.addAttribute("success", true);
            model.addAttribute("mem_id", user.getMem_id());
        } else {
        	//사용자가 존재하지 않는 경우 실패메세지를 모델에 추가
            model.addAttribute("success", false);
        }
    	//비밀번호 찾기 결과 페이지의 뷰를 반환한다.
        return "member/findPwResult";
    }
    
    //비밀번호 찾기 탭에서 해당 데이터가 전부 맞다면 새로운 비밀번호를 입력해서 업데이트 하는 로직
    @PostMapping("/updatePassword")
    public ResponseEntity<Map<String, Object>> updatePassword(@RequestParam String mem_id, @RequestParam String newPassword, @RequestParam String confirmPassword, Model model) {
        Map<String, Object> response = new HashMap<>();
        
        //유효성 검사 비밀번호의 길이가 최소 5자에서 최대 15자인가 아닐경우 메세지 출력
        if (newPassword.length() < 5 || newPassword.length() > 15) {
            response.put("success", false);
            response.put("message", "비밀번호는 5자에서 15자 사이여야 합니다.");
            return ResponseEntity.ok(response);
        }
        
        //새로운 비밀번호가 비밀번호를 다시 확인하는 입력폼과 맞는지 확인, 아닐경우 메시지 출력
        if (!newPassword.equals(confirmPassword)) {
            response.put("success", false);
            response.put("message", "비밀번호가 일치하지 않습니다.");
            return ResponseEntity.ok(response);
        }
        
        //그리고 해당 아이디의 비밀번호를 업데이트 핵서 저장함
        boolean updated = memberService.updatePassword(mem_id, newPassword);
        response.put("success", updated);
        return ResponseEntity.ok(response);
    }
    
    // 처음 홈페이지를 로드하면 로그인 상태를 확인하는 엔드포인트
    @GetMapping("/status")
    public ResponseEntity<?> loginStatus(HttpSession session) {
        // 세션에서 "mem_id" 값을 가져옴
        String mem_id = (String) session.getAttribute("mem_id");
        // 로그인 상태 확인
        // 브라우저에서 "/member/status"로 GET 요청을 보내면,
        // JSON 형태로 {"loggedIn": true, "mem_id": "회원 아이디"} 응답을 받음
        if (mem_id != null) {
            // 관리자 여부 확인
            // "isAdmin" 필드를 추가하여 관리자 여부를 클라이언트에 전달
            String memberGrade = memberService.getMemberGrade(mem_id);
            boolean isAdmin = "0".equals(memberGrade);
            return ResponseEntity.ok(Map.of("loggedIn", true, "mem_id", mem_id, "isAdmin", isAdmin));
        } else {
            // 로그아웃 상태일 때 응답
            // 로그아웃 상태일 때 JSON 형태로 {"loggedIn": false} 응답을 받음
            return ResponseEntity.ok(Map.of("loggedIn", false));
        }
    }
        
}