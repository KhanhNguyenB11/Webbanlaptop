package com.devpro.services;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.devpro.common.ProductSearch;
import com.devpro.common.Utilities;
import com.devpro.entities.Product;
import com.devpro.entities.ProductImages;
import com.devpro.repositories.ProductRepo;
import com.devpro.repositories.SaleOrderRepo;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class ProductService {

    private static final Logger logger = LoggerFactory.getLogger(ProductService.class);
    @Autowired
    ProductRepo productRepo;
    @PersistenceContext
    protected EntityManager entityManager;
    @Autowired
    SaleOrderRepo saleOrderRepo;

    @SuppressWarnings("unchecked")
    public List<Product> search(final ProductSearch productSearch) {
        String jpql = "Select p from Product p where 1=1";
        if (productSearch.getSeoCategory() != null && !productSearch.getSeoCategory().isEmpty()) {
            jpql += " and p.category.seo= '" + productSearch.getSeoCategory() + "'";

        }
        if (productSearch.getSeoProduct() != null && !productSearch.getSeoProduct().isEmpty()) {
            jpql += " and p.seo= '" + productSearch.getSeoProduct() + "'";

        }
        if (productSearch.getKeyword() != null && !productSearch.getKeyword().isEmpty()) {
            jpql += " and p.status= " + productSearch.getStatusProduct() + " and CONCAT(p.title, ' ', p.shortDes, ' ',p.category.seo,' ',p.category.name,' ', p.seo, ' ', p.price) LIKE '%"
                    + productSearch.getKeyword() + "%'";

        }
        if (productSearch.getStatusProduct() == 1) {
            jpql += " and p.status= " + productSearch.getStatusProduct();

        }
        if (productSearch.getMinprice() != null && !productSearch.getMinprice().isEmpty()) {
            jpql += " and p.status= " + productSearch.getStatusProduct() + " and price >= " + productSearch.getMinprice();
        }
        if (productSearch.getMaxprice() != null && !productSearch.getMaxprice().isEmpty()) {
            jpql += " and p.status= " + productSearch.getStatusProduct() + " and price <= " + productSearch.getMaxprice();

        }

        Query query = entityManager.createQuery(jpql, Product.class);

        if (productSearch.getCurrentPage() != null && productSearch.getCurrentPage() > 0) { // phân trang
            query.setFirstResult((productSearch.getCurrentPage() - 1) * ProductSearch.SIZE_ITEMS_ON_PAGE);
            query.setMaxResults(ProductSearch.SIZE_ITEMS_ON_PAGE);
        }

        return query.getResultList();
    }
    //	@SuppressWarnings("unchecked")
    //	public List<Product> findProductByCategory(final String seo) {
    //
    //		String jpql = "Select p from Product p where p.category.seo = '" + seo + "'";
    //		Query query = entityManager.createQuery(jpql, Product.class);
    //
    ////		String sql = "select * from tbl_products where category_id = (select id from tbl_category where seo='" + seo
    ////				+ "')";
    ////		Query query = entityManager.createNativeQuery(sql, Product.class);
    //		return query.getResultList();
    //	}
    //
    //	public Product findProductBySeo(final String seo) {
    //
    ////		String jpql = "Select p from Product p where p.seo = '" + seo + "'";
    ////		Query query = entityManager.createQuery(jpql, Product.class);
    //
    //		String sql = "select * from tbl_products where seo = '" + seo + "'";
    //		Query query = entityManager.createNativeQuery(sql, Product.class);
    //		return (Product) query.getSingleResult();
    //	}

    public List<Product> findProductByStatus() {
        try {
            return productRepo.findAll();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Product findProductById(int id) {
        Optional<Product> product = productRepo.findById(id);
        if (product.isPresent()) {
            return product.get();
        }
        throw new RuntimeException("Không tìm thấy sản phẩm");
    }

    public BigDecimal calPriceAfterDiscount(BigDecimal price, int discount) {
        BigDecimal discountAmount = price.multiply(BigDecimal.valueOf(discount).divide(BigDecimal.valueOf(100)));
        BigDecimal priceAfterDiscount = price.subtract(discountAmount);
        return priceAfterDiscount;

    }

    private boolean isEmptyUploadFile(MultipartFile[] images) {
        if (images == null || images.length <= 0) {
            return true;
        }
        if (images.length == 1 && images[0].getOriginalFilename().isEmpty()) {
            return true;
        }
        return false;
    }

    @Transactional(rollbackOn = Exception.class)
    public void saveProduct(MultipartFile[] images, Product product) throws Exception {

        try {
            product.setSeo(Utilities.createSeoLink(product.getTitle()));

            if (product.getId() != null) { // chỉnh sửa
                // lấy dữ liệu cũ của sản phẩm
                Product productInDb = productRepo.findById(product.getId()).get();
                if (productInDb != null) {
                    if (!isEmptyUploadFile(images)) { // nếu admin sửa ảnh sản phẩm
                        // lấy danh sách ảnh của sản phẩm cũ
                        List<ProductImages> productImages = productInDb.getProductImages();
                        // xoá ảnh cũ đi
                        for (ProductImages _images : productImages) {
                            new File("D:\\IDM\\ShopLaptop-master_2\\ShopLaptop-master\\src\\main\\resources\\META-INF\\upload\\" + _images.getPath()).delete();
                        }
                        product.clearProductImages();
                    } else { // ảnh phải giữ nguyên
                        product.setProductImages(productInDb.getProductImages());
                    }
                }
            }

            if (!isEmptyUploadFile(images)) { // nếu admin upload ảnh
                List<ProductImages> newProductImages = new ArrayList<>();

                for (MultipartFile image : images) {
                    // Lưu file vào host.
                    image.transferTo(new File("D:\\IDM\\ShopLaptop-master_2\\ShopLaptop-master\\src\\main\\resources\\META-INF\\upload\\" + image.getOriginalFilename()));

                    ProductImages productImages = new ProductImages();
                    productImages.setTitle(image.getOriginalFilename());
                    productImages.setPath(image.getOriginalFilename());
                    productImages.setProduct(product);

                    // cho quan hệ 1 - n
                    newProductImages.add(productImages);
                }
               
                product.setProductImages(newProductImages);
                System.out.println("imgzzz: " + product.getProductImages().size());
            }

            productRepo.save(product);
        } catch (Exception e) {
            throw e;
        }
    }

}
