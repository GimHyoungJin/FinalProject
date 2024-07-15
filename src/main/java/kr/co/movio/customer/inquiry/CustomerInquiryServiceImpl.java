package kr.co.movio.customer.inquiry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CustomerInquiryServiceImpl implements CustomerInquiryService {

    @Autowired
    private CustomerInquiryDAO inquiryDAO;

    @Override
    @Transactional
    public void saveInquiry(CustomerInquiryDTO inquiryDTO) {
        inquiryDAO.save(inquiryDTO);
    }

    @Override
    @Transactional
    public CustomerInquiryDTO getInquiryById(String inq_num) {
        return inquiryDAO.findById(inq_num);
    }

    @Override
    @Transactional
    public boolean checkDuplicateMemberId(String mem_id) {
        return inquiryDAO.countByMemberId(mem_id) > 0;
    }

    @Override
    @Transactional
    public boolean checkDuplicateTheaterId(String theater_id) {
        return inquiryDAO.countByTheaterId(theater_id) > 0;
    }

    // 추가적으로 필요할 수 있는 메소드들
}
