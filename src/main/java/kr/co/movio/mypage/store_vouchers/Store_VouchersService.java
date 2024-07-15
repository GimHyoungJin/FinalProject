package kr.co.movio.mypage.store_vouchers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class Store_VouchersService {

    @Autowired
    private Store_VouchersDAO storeVouchersDAO;

    @Transactional
    public boolean validateAndSaveVoucher(String voucherNumber, String memId) {
        if (voucherNumber.length() == 16 && storeVouchersDAO.isVoucherAvailable(voucherNumber)) {
            storeVouchersDAO.registerVoucher(voucherNumber, memId);
            return true;
        }
        return false;
    }
}
