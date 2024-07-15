package kr.co.movio.mypage.vouchers;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class VouchersService {

    @Autowired
    private VouchersDAO vouchersDAO;
/*
    @Transactional
    public boolean validateAndSaveVoucher(String voucherNumber, String memId) {
        if (voucherNumber.matches("[a-zA-Z0-9]{12}")) {
          //  if (vouchersDAO.isVoucherAlreadyRegistered(voucherNumber)) {
                return false; // 이미 등록된 번호
            }
            if (vouchersDAO.isVoucherAvailableInUnused(voucherNumber)) {
                vouchersDAO.registerVoucher(voucherNumber, memId);
                vouchersDAO.deleteUnusedVoucher(voucherNumber); // 등록 후 unused_vouchers 테이블에서 삭제
                return true; // 성공적으로 등록됨
            }
        }
        return false; // 유효하지 않은 번호
    }

    public String generateShortUUID() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 12);
    }

    public void saveUnusedVoucher(String voucherNumber) {
        vouchersDAO.insertUnusedVoucher(voucherNumber);
    }
    */
}
