package com.devpro.controller.users;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devpro.entities.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devpro.common.ProductSearch;
import com.devpro.repositories.CategoryRepo;
import com.devpro.services.ProductService;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;

@Controller
public class DetailController extends BaseController {

	@Autowired
	ProductService productService;

	@RequestMapping(value = { "/detail-product/{seo}" }, method = RequestMethod.GET)
	public String detailProduct(@PathVariable("seo") String seo, final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) throws Exception {
		ProductSearch productSearch = new ProductSearch();
		productSearch.setSeoProduct(seo);
		Product product =  productService.search(productSearch).get(0);
		if(product.getDiscount() > 0){
			//Calculate the price after discount
			BigDecimal discountAmount = product.getPrice().multiply(BigDecimal.valueOf(product.getDiscount()).divide(BigDecimal.valueOf(100)));
			BigDecimal priceAfterDiscount = product.getPrice().subtract(discountAmount);
			Locale locale = new Locale("vi", "VN");
			NumberFormat fmt = NumberFormat.getCurrencyInstance(locale);
			model.addAttribute("priceAfterDiscount",fmt.format(priceAfterDiscount));

		}

		model.addAttribute("categories", categoryRepo.findAll());
		model.addAttribute("product",product);

		return "users/UserDetail";
	}
}
