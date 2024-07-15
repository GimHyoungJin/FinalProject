package kr.co.movio.mypage.inquiry;

import java.util.List;

public interface MypageInquiryService {
    List<MypageInquiryDTO> getInquiriesByMemberId(String memId);
}
