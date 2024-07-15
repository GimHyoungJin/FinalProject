package kr.co.movio.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductCont {

    private final ProductService productService;
    private final ProductDAO productDao;

    @Autowired
    public ProductCont(ProductService productService, ProductDAO productDao) {
        this.productService = productService;
        this.productDao = productDao;
        System.out.println("-----ProductCont() 객체 생성됨");
    }

    @GetMapping("/list")
    public ModelAndView list() {
        return listByProCode("package", new ModelAndView());
    }

    @GetMapping("/listByProCode")
    public ModelAndView listByProCode(@RequestParam("pro_code") String proCode, ModelAndView mav) {
        List<ProductDTO> products = productService.getProductsByProCode(proCode);
        System.out.println("컨트롤러에서 조회한 제품들: " + products);
        mav.addObject("products", products);
        mav.setViewName("product/list");
        mav.addObject("selectedProCode", proCode);
        return mav;
    }

    @PostMapping("/update")
    public String update(@RequestParam Map<String, Object> params, @RequestParam("pro_photo") MultipartFile file, HttpServletRequest req) {
        String proDetailCode = (String) params.get("pro_detail_code");

        System.out.println("Received params: " + params);
        if (proDetailCode == null || proDetailCode.isEmpty()) {
            System.out.println("Product detail code is missing");
            throw new IllegalArgumentException("Product detail code is missing");
        }

        System.out.println("Updating product with detail code: " + proDetailCode);

        ServletContext application = req.getServletContext();
        String basePath = application.getRealPath("/storage");

        try {
            if (!file.isEmpty()) {
                String originalFilename = file.getOriginalFilename();
                String filename = originalFilename;

                File uploadFile = new File(basePath, originalFilename);
                int i = 1;
                while (uploadFile.exists()) {
                    int lastDot = originalFilename.lastIndexOf(".");
                    filename = originalFilename.substring(0, lastDot) + "_" + i + originalFilename.substring(lastDot);
                    uploadFile = new File(basePath, filename);
                    i++;
                }
                file.transferTo(uploadFile);
                params.put("pro_photo", filename);
            } else {
                ProductDTO product = productDao.detail(proDetailCode);
                if (product == null) {
                    throw new IllegalArgumentException("Product not found with detail code: " + proDetailCode);
                }
                params.put(proDetailCode, basePath);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        productDao.update(params);

        String proCode = productService.getProCodeByDetailCode(proDetailCode);
        return "redirect:/product/listByProCode?pro_code=" + proCode;
    } 
    
    @GetMapping("/detail")
    public ModelAndView detail(@RequestParam("pro_detail_code") String proDetailCode, ModelAndView mav) {
        ProductDTO product = productService.getProductByDetailCode(proDetailCode);
        if (product == null) {
            throw new IllegalArgumentException("Product not found with detail code: " + proDetailCode);
        }
        mav.addObject("product", product);
        mav.setViewName("product/detail");
        return mav;
    }

}
