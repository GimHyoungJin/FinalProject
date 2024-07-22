package kr.co.movio.mypage.store_vouchers;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class Store_VouchersDAO {

    @Autowired
    private SqlSession sqlSession;

    public Store_VouchersDTO findByOrderNo(String order_no) {
        return sqlSession.selectOne("kr.co.movio.mypage.store_vouchers.Store_VouchersMapper.findByOrderNo", order_no);
    }

    public void insertVoucher(Store_VouchersDTO voucher) {
        sqlSession.insert("kr.co.movio.mypage.store_vouchers.Store_VouchersMapper.insertVoucher", voucher);
    }

    public void updateVoucher(Store_VouchersDTO voucher) {
        sqlSession.update("kr.co.movio.mypage.store_vouchers.Store_VouchersMapper.updateVoucher", voucher);
    }

    public List<Store_VouchersDTO> findAll() {
        return sqlSession.selectList("kr.co.movio.mypage.store_vouchers.Store_VouchersMapper.findAll");
    }
}
