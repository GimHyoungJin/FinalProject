package kr.co.movio.member;


public class SocialMemberDTO {
    /* 기존 카카오 로그인
	private String socialId;
    private String memId;
    private String provider;
    private String nickname;
    private String email;
    private String regdate;
    */
	
	//카카오 로그인과 구글 로그인을 합쳐서 관리할 때 사용할 필드
	private String socialId;	//소셜 고유  id
    private String provider;	//naver, google등 어느 소셜의 아이디인지 분류
    private String nickname;	//닉네임
    private String email;		//이메일
    private String profileImage;//프로필 이미지
    private String regdate;		//가입일
    private String gender;		//성별 (M,F)
    private String birth; 		//생일
    private String ageRange;	//연령대 ex) 10대, 20대, 30대
    private String birthYear;	//태어난년도
    private String phone;		//핸드폰 번호
	public String getSocialId() {
		return socialId;
	}
	public void setSocialId(String socialId) {
		this.socialId = socialId;
	}
	public String getProvider() {
		return provider;
	}
	public void setProvider(String provider) {
		this.provider = provider;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAgeRange() {
		return ageRange;
	}
	public void setAgeRange(String ageRange) {
		this.ageRange = ageRange;
	}
	public String getBirthYear() {
		return birthYear;
	}
	public void setBirthYear(String birthYear) {
		this.birthYear = birthYear;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Override
	public String toString() {
		return "SocialMemberDTO [socialId=" + socialId + ", provider=" + provider + ", nickname=" + nickname
				+ ", email=" + email + ", profileImage=" + profileImage + ", regdate=" + regdate + ", gender=" + gender
				+ ", birth=" + birth + ", ageRange=" + ageRange + ", birthYear=" + birthYear + ", phone=" + phone + "]";
	}
    
    
}
