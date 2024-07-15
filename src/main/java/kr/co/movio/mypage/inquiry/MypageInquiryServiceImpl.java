package kr.co.movio.mypage.inquiry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypageInquiryServiceImpl implements MypageInquiryService {

    @Autowired
    private MypageInquiryDAO inquiryDAO;

    @Override
    public List<MypageInquiryDTO> getInquiriesByMemberId(String memId) {
        return inquiryDAO.getInquiriesByMemberId(memId);
    }
}
