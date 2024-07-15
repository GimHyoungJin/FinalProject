package kr.co.movio.member;

public interface MemberService {
	//해당 메소드들을 사용하기 위한 추상메소드 껍데기만 선언함
    boolean checkId(String id); //아이디 중복확인	
    boolean checkEmail(String email);//이메일 중복확인
    boolean checkPhone(String phone);//전화번호 중복확인
    boolean login(String mem_id, String passwd);//로그인
    boolean register(MemberDTO memberDTO); //회원가입 로직
    MemberDTO findUserByUsernameAndPhone(String username, String phone); //아이디 찾기 로직
    MemberDTO findUserByIdEmailAndPhone(String mem_id, String email, String phone);
    boolean updatePassword(String mem_id, String newPassword);//새로 설정한 비밀번호를 업데이트
    boolean checkSocialId(String socialId, String provider);//소셜 로그인 테이블 중복확인 로직
    boolean regSocialMember(SocialMemberDTO socialMemberDTO); //소셜 등록 로직
    String getMemberGrade(String mem_id); //멤버 등급을 확인하는 로직
}