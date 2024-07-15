package kr.co.movio.member;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//MemberServiceImpl 클래스: MemberService 인터페이스를 구현하는 서비스 클래스
@Service
public class MemberServiceImp implements MemberService {

 //MemberDAO 빈을 주입받음(의존성 주입)
 //AutoWired는 이미 선언된 객체를 끌어다가 사용한다.(밧줄을 사용해서 서로 연결하는 것이라고 생각하면 됨)
 @Autowired
 private MemberDAO memberDAO;
 
 //의존성 주입은 한개의 autoWired 당 하나씩만 가능하다.
 @Autowired
 private SocialMemberDAO socialMemberDAO;

 //아이디 중복 여부를 확인하는 메소드
 @Override
 public boolean checkId(String id) {
     //폼에 작성된 아이디로 회원 데이터를 조회하여 조회한 값이 0보다 크면 중복된 아이디로 간주
     return memberDAO.countById(id) > 0;
 }

 //이메일 중복 여부를 확인하는 메소드
 @Override
 public boolean checkEmail(String email) {
     //폼에 작성된 이메일로 회원 데이터를 조회하여 조회한 결과값이 0보다 크면 중복된 이메일로 간주
     return memberDAO.countByEmail(email) > 0;
 }

 //전화번호 중복 여부를 확인하는 메소드
 @Override
 public boolean checkPhone(String phone) {
     // 폼에 작성된 전화번호로 회원 데이터를 조회하여 조회한 결과값이 0보다 크면 중복된 전화번호로 간주
     return memberDAO.countByPhone(phone) > 0;
 }
 
 // 로그인 처리를 담당하는 메소드
 @Override
 public boolean login(String mem_id, String passwd) {
     //폼에 작성된 아이디로 회원 정보를 조회
     MemberDTO memberDTO = memberDAO.findById(mem_id);
     //회원 정보가 이미 존재하고 비밀번호가 일치하면 로그인 성공으로 간주
     return memberDTO != null && memberDTO.getPasswd().equals(passwd);
 }
 
 // 회원 가입을 처리하는 메서드
 @Override
 public boolean register(MemberDTO member) {
     /* 회원 등급을 기본값으로 설정 (예: "1" : 일반유저)
     member.setMem_grade("1");  기본값 설정 */
     //모든 유효성 검사를 통과하면 회원 정보를 저장
	 memberDAO.save(member);
     // 회원 가입 성공으로 간주하고 true 반환
     return true;
 }
 
 //해당 유저 이름과, 핸드폰 번호에 맞는 아이디를 찾는 메서드
 @Override
 public MemberDTO findUserByUsernameAndPhone(String username, String phone) {
     MemberDTO memberDTO = new MemberDTO();
     memberDTO.setUsername(username);
     memberDTO.setPhone(phone);
     return memberDAO.findUserByUsernameAndPhone(memberDTO);
 }
 
 //입력한 아이디, 이메일 폰번호로 맞는 데이터를 처리하는 서비스 메소드
 @Override
 public MemberDTO findUserByIdEmailAndPhone(String mem_id, String email, String phone) {
     MemberDTO memberDTO = new MemberDTO();
     memberDTO.setMem_id(mem_id);
     memberDTO.setEmail(email);
     memberDTO.setPhone(phone);
     return memberDAO.findUserByIdEmailAndPhone(memberDTO);
 }
 
 
 //해당 id와 그 id와 매칭되는 passwd를 재설정에 쓰는 메서드
 @Override
 public boolean updatePassword(String mem_id, String newPassword) {
     MemberDTO memberDTO = new MemberDTO();
     memberDTO.setMem_id(mem_id);
     memberDTO.setPasswd(newPassword);
     return memberDAO.updatePassword(memberDTO) > 0;
 }
 
 
 //중복된 소셜 아이디인지 확인
 @Override
 @Transactional
 public boolean checkSocialId(String socialId, String provider) {
     SocialMemberDTO socialMemberDTO = new SocialMemberDTO();
     socialMemberDTO.setSocialId(socialId);
     socialMemberDTO.setProvider(provider);
     int count = socialMemberDAO.countBySocialIdAndProvider(socialMemberDTO);
     return count > 0;
 }

 //새로운 소셜 멤버 정보를 DB에 저장(소설 회원가입)
 @Override
 @Transactional
 public boolean regSocialMember(SocialMemberDTO socialMemberDTO) {
     int result = socialMemberDAO.saveSocialMember(socialMemberDTO);
     return result > 0;
 }
 
//멤버 등급 확인 로직 
 @Override
 public String getMemberGrade(String mem_id) {
     return memberDAO.getMemberGrade(mem_id);
 }

}