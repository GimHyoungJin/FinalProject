package kr.co.movio.product;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<Map<String, Object>> list() {
        return sqlSession.selectList("kr.co.movio.product.ProductDAO.list");
    }

    public List<Map<String, Object>> search(String productName) {
        return sqlSession.selectList("kr.co.movio.product.ProductDAO.search", productName);
    }

    public ProductDTO detail(String proDetailCode) {
        return sqlSession.selectOne("kr.co.movio.product.ProductDAO.detail", proDetailCode);
    }

    public boolean update(Map<String, Object> params) {
        int result = sqlSession.update("kr.co.movio.product.ProductDAO.update", params);
        return result > 0;
    }

    public boolean delete(String proDetailCode) {
        int result = sqlSession.delete("kr.co.movio.product.ProductDAO.delete", proDetailCode);
        return result > 0;
    }

    public String getCategoryNameByProCode(String proCode) {
        return sqlSession.selectOne("kr.co.movio.product.ProductDAO.getCategoryNameByProCode", proCode);
    }

    public int getMaxProDetailCode(String proCode) {
        return sqlSession.selectOne("kr.co.movio.product.ProductDAO.getMaxProDetailCode", proCode);
    }

    public List<ProductDTO> getProductsByProCode(String proCode) {
        List<ProductDTO> products = sqlSession.selectList("kr.co.movio.product.ProductDAO.listByProCode", proCode);
        System.out.println("DAO에서 조회한 제품들: " + products);
        return products;
    }

    public Product getProductByDetailCode(String proDetailCode) {
        return sqlSession.selectOne("kr.co.movio.product.ProductDAO.getProductByDetailCode", proDetailCode);
    }
    
    public String getProCodeByDetailCode(String proDetailCode) {
        return sqlSession.selectOne("kr.co.movio.product.ProductDAO.getProCodeByDetailCode", proDetailCode);
    }

    public void updateProductStock(ProductDTO product) {
        sqlSession.update("kr.co.movio.product.ProductMapper.updateProductStock", product);
    }
}
