package kr.co.movio.mypage.store_vouchers;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Store_VouchersDAO {

    @Autowired
    private SqlSession sqlSession;

    public boolean isVoucherAvailable(String voucherNumber) {
        int count = sqlSession.selectOne("store_vouchers.isVoucherAvailable", voucherNumber);
        return count > 0;
    }

    public void registerVoucher(String voucherNumber, String memId) {
        sqlSession.update("store_vouchers.registerVoucher", Map.of("voucherNumber", voucherNumber, "memId", memId));
    }
}
