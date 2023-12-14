package com.devpro.services;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.*;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import com.devpro.entities.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.devpro.common.Utilities;
import com.devpro.repositories.ProductRepo;
import com.devpro.repositories.SaleOrderProductsRepo;
import com.devpro.repositories.SaleOrderRepo;

@Service
public class SaleOrderService {
	@Autowired
	ProductRepo productRepo;
	@PersistenceContext
	protected EntityManager entityManager;
	@Autowired
	SaleOrderRepo saleOrderRepo;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	SaleOrderProductsRepo saleOrderProductsRepo;
	@Autowired
	ProductService productService;

	public List<SaleOrderProducts> findOrderProductByOrderId(int id) {
		SaleOrderProducts saleOrderProducts = saleOrderProductsRepo.findById(id).get();
		List<SaleOrderProducts> list = new ArrayList<>();
		list.add(saleOrderProducts);
		return list;
	}

	public SaleOrder findSaleOrderById(int id) {

//		String jpql = "Select p from Product p where p.seo = '" + seo + "'";
//		Query query = entityManager.createQuery(jpql, Product.class);

		return saleOrderRepo.findById(id);
	}
	public SaleOrder findSaleOrderByCode(String code) {

//		String jpql = "Select p from Product p where p.seo = '" + seo + "'";
//		Query query = entityManager.createQuery(jpql, Product.class);

		return saleOrderRepo.findByCode(code);
	}
	public List<SaleOrder> findByEmail(String email){
		return saleOrderRepo.findByCustomerEmail(email);
	}
	public List<SaleOrderProducts> findSaleOrderProductbyCode(String code) {

		String sql = "select * from tbl_saleorder_products where saleorder_id = (select id from tbl_saleorder where code='" + code
				+ "')";
		Query query = entityManager.createNativeQuery(sql, SaleOrderProducts.class);
		return query.getResultList();
	}
	public List<SaleOrder> findSaleOrderByUserId(int id) {

//		String jpql = "Select p from Product p where p.seo = '" + seo + "'";
//		Query query = entityManager.createQuery(jpql, Product.class);

		return saleOrderRepo.findByUserId(id);
	}

	@Transactional(rollbackOn = Exception.class)
	public void saveSaleOrder(SaleOrder saleOrder) throws Exception {

		try {
			saleOrder.setStatus(false);
			saleOrderRepo.save(saleOrder);
		} catch (Exception e) {
			throw e;
		}
	}

	// gửi email khi đặt hàng xong
	@Transactional(rollbackOn = Exception.class)
	public void sendEmail(SaleOrder saleOrder, List<CartItem> cartItems)
			throws UnsupportedEncodingException, MessagingException {

		String subject = "Thông báo xác nhận đơn hàng";
		String senderName = "Shop ABC";
		String mailContent = "<p> Dear " + saleOrder.getCustomerName() + "</p>";
		mailContent += "<h2> Thông tin đơn hàng " + saleOrder.getCode() + "</h2>";

		for (CartItem cartItem : cartItems) {
			mailContent += "<p> " + cartItem.getProductName() + " X " + cartItem.getQuantity()
					+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + cartItem.getUnitPriceVN()
					+ "</p>";
		}
		mailContent += "<h4> Tổng Cộng:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+ saleOrder.getTotalVN() + "</h4>";
		mailContent += "<p>-------------------------------------------------------------</p>";
		mailContent += "<h2> Thông tin khách hàng </h2>";
		mailContent += "<p> Tên Khách Hàng: " + saleOrder.getCustomerName() + "</p>";
		mailContent += "<p> Số điện thoại liên lạc: " + saleOrder.getCustomerPhone() + "</p>";
		mailContent += "<p> Địa chỉ: " + saleOrder.getCustomerAddress() + "</p>";
		mailContent += "<p>Cám ơn bạn đã mua hàng!</p>";
		mailContent += "<p>Shop ABC</p>";
		
		 Properties props = new Properties(); 
		 props.put("mail.smtp.starttls.enable", "true"); 
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);
		helper.setFrom("dantedmc1134@gmail.com", senderName);
		helper.setTo(saleOrder.getCustomerEmail());
		helper.setSubject(subject);
		helper.setText(mailContent, true);

		mailSender.send(message);

	}

	@Transactional(rollbackOn = Exception.class)
	public void saveOrderProduct(int userid, String customerAddress, String customerName, String customerPhone,
			String customerEmail, HttpSession httpSession) throws Exception {
		SaleOrder saleOrder = new SaleOrder();
		saleOrder.setCode("ORDER-" + System.currentTimeMillis());
		saleOrder.setSeo("ORDER-" + System.currentTimeMillis());
		saleOrder.setCustomerName(customerName);
		saleOrder.setCustomerAddress(customerAddress);
		saleOrder.setCustomerPhone(customerPhone);
		saleOrder.setCustomerEmail(customerEmail);
		saleOrder.setStatus(true);
                if(userid==0){
                    
                }else
                    saleOrder.setUserId(userid);

		Cart cart = (Cart) httpSession.getAttribute("GIO_HANG");
		List<CartItem> cartItems = cart.getCartItems();

		BigDecimal sum = new BigDecimal(0);

		for (CartItem item : cartItems) {
			SaleOrderProducts saleOrderProducts = new SaleOrderProducts();
			Product product = productRepo.getOne(item.getProductId());
			saleOrderProducts.setPrice(product.getPrice());
			saleOrderProducts.setDiscount(product.getDiscount());
			saleOrderProducts.setProduct(product);
			saleOrderProducts.setQuantity(item.getQuantity());
			saleOrder.addSaleOrderProducts(saleOrderProducts);
			saleOrderProducts.setStatus(true);
			for (int i = 1; i <= item.getQuantity(); i++) {
				BigDecimal price = saleOrderProducts.getProduct().getPrice();
				int discount = saleOrderProducts.getProduct().getDiscount();
				BigDecimal priceAfterDiscount = productService.calPriceAfterDiscountNoFormat(price,discount);
				sum = sum.add(priceAfterDiscount);
			}

		}
		saleOrder.setCreatedDate(java.time.LocalDateTime.now());
		saleOrder.setTotal(sum);
		saleOrderRepo.save(saleOrder);
		sendEmail(saleOrder, cartItems);
		httpSession.setAttribute("SL_SP_GIO_HANG", 0);
		httpSession.setAttribute("GIO_HANG", null);
	}
}
