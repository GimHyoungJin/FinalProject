package kr.co.movio.mypage.vouchers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class VoucherService {

    @Autowired
    private VoucherDAO voucherDAO;

    @Transactional
    public boolean validateAndSaveVoucher(String voucherNumber, String memId) {
        if (voucherNumber.length() == 12 && voucherDAO.isVoucherAvailable(voucherNumber)) {
            voucherDAO.registerVoucher(voucherNumber, memId);
            return true;
        }
        return false;
    }
}
