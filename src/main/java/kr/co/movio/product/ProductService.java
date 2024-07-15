package kr.co.movio.product;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProductService {

    @Autowired
    private SqlSession sqlSession;

    public List<ProductDTO> getProductsByProCode(String proCode) {
        List<ProductDTO> products = sqlSession.selectList("kr.co.movio.product.ProductDAO.listByProCode", proCode);
        System.out.println("DB에서 조회한 제품들: " + products);
        return products;
    }

    public void insert(Map<String, Object> map) {
        sqlSession.insert("kr.co.movio.product.ProductDAO.insert", map);
    }
    
    public String getProCodeByDetailCode(String proDetailCode) {
        return sqlSession.selectOne("kr.co.movio.product.ProductDAO.getProCodeByDetailCode", proDetailCode);
    }
    
    public ProductDTO getProductByDetailCode(String proDetailCode) {
        return sqlSession.selectOne("kr.co.movio.product.ProductDAO.detail", proDetailCode);
    }

}
