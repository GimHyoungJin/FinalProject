package kr.co.movio.mypage.vouchers;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class VouchersDAO {

    @Autowired
    private SqlSession sqlSession;

    public boolean isVoucherAvailable(String voucherNumber) {
        int count = sqlSession.selectOne("vouchers.isVoucherAvailable", voucherNumber);
        return count > 0;
    }

    public void registerVoucher(String voucherNumber, String memId) {
        sqlSession.update("vouchers.registerVoucher", Map.of("voucherNumber", voucherNumber, "memId", memId));
    }

    public void deleteUnusedVoucher(String voucherNumber) {
        sqlSession.delete("vouchers.deleteUnusedVoucher", voucherNumber);
    }

    public void insertUnusedVoucher(String voucherNumber) {
        sqlSession.insert("vouchers.insertUnusedVoucher", voucherNumber);
    }
}
