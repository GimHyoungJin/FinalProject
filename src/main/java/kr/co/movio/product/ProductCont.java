package kr.co.movio.product;

import java.util.List;
import java.util.Map;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

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
        mav.addObject("products", products);
        mav.setViewName("product/list");
        mav.addObject("selectedProCode", proCode); // 현재 선택된 pro_code를 뷰에 추가
        return mav;
    }

    @GetMapping("/write")
    public String write() {
        return "product/write";
    }

    @PostMapping("/insert")
    public String insert(@RequestParam Map<String, Object> map, @RequestParam("pro_photo") MultipartFile proPhoto, HttpServletRequest req) {
        ServletContext application = req.getServletContext();
        String basePath = application.getRealPath("/storage");

        String filename = "-";
        long filesize = 0;

        if (proPhoto != null && !proPhoto.isEmpty()) {
            filesize = proPhoto.getSize();
            try {
                String originalFilename = proPhoto.getOriginalFilename();
                filename = originalFilename;

                File file = new File(basePath, originalFilename);
                int i = 1;
                while (file.exists()) {
                    int lastDot = originalFilename.lastIndexOf(".");
                    filename = originalFilename.substring(0, lastDot) + "_" + i + originalFilename.substring(lastDot);
                    file = new File(basePath, filename);
                    i++;
                }
                proPhoto.transferTo(file);
            } catch (Exception e) {
                System.out.println(e);
            }
        }

        map.put("pro_photo", filename);
        map.put("filesize", filesize);

        String proCode = (String) map.get("pro_code");
        String proDetailCode = generateProDetailCode(proCode);
        map.put("pro_detail_code", proDetailCode);

        if (map.get("pro_stock") != null) {
            map.put("pro_stock", Integer.parseInt((String) map.get("pro_stock")));
        }

        // original_price가 없으면 pro_price로 설정
        if (map.get("original_price") == null || map.get("original_price").equals("")) {
            map.put("original_price", Integer.parseInt((String) map.get("pro_price")));
        }

        productService.insert(map);

        return "redirect:/product/listByProCode?pro_code=" + proCode;
    }



    @GetMapping("/search")
    public ModelAndView search(@RequestParam(defaultValue = "") String product_name) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("product/list");
        mav.addObject("list", productDao.search(product_name));
        mav.addObject("product_name", product_name);
        return mav;
    }

    @GetMapping("/detail")
    public ModelAndView detail(@RequestParam("pro_detail_code") String pro_detail_code) {
        System.out.println("pro detail code" + pro_detail_code);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("product/detail");
        ProductDTO product = productDao.detail(pro_detail_code);
        mav.addObject("product", product);
        return mav;
    }

    @PostMapping("/update")
    public String update(@RequestParam Map<String, Object> params, @RequestParam("pro_photo") MultipartFile file, HttpServletRequest req) {
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
                ProductDTO product = productDao.detail((String) params.get("pro_detail_code"));
                params.put("pro_photo", product.getPro_photo());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // original_price가 없으면 pro_price로 설정
        if (params.get("original_price") == null || params.get("original_price").equals("")) {
            params.put("original_price", params.get("pro_price"));
        }

        productDao.update(params);

        String proCode = (String) params.get("pro_code");
        return "redirect:/product/listByProCode?pro_code=" + proCode;
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("pro_detail_code") String pro_detail_code) {
        ProductDTO product = productDao.detail(pro_detail_code);
        String proCode = product.getPro_code();
        
        boolean isDeleted = productDao.delete(pro_detail_code);
        
        if (isDeleted) {
            return "redirect:/product/listByProCode?pro_code=" + proCode;
        } else {
            throw new IllegalArgumentException("Failed to delete the product");
        }
    }

    @GetMapping("/getCategoryName")
    public Map<String, String> getCategoryName(@RequestParam String pro_code) {
        String categoryName = productDao.getCategoryNameByProCode(pro_code);
        Map<String, String> response = new HashMap<>();
        response.put("categoryName", categoryName);
        return response;
    }
    
    private String generateProDetailCode(String proCode) {
        int maxNumber = productDao.getMaxProDetailCode(proCode);
        String nextNumber = String.format("%02d", maxNumber + 1);
        return proCode + nextNumber;
    }
}
