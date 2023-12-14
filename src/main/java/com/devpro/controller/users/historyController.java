package com.devpro.controller.users;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devpro.entities.SaleOrderProducts;
import com.devpro.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devpro.services.SaleOrderService;
import com.devpro.services.UserService;

import java.math.BigDecimal;
import java.util.List;

@Controller
public class historyController extends BaseController{
	@Autowired
	SaleOrderService saleOrderService;
	@Autowired
	ProductService productService;
	
	@RequestMapping(value = { "/history/{id}"}, method = RequestMethod.GET)
	public String history(@PathVariable("id") String id,final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) throws Exception {
		if(id.contains("@")){
			model.addAttribute("saleOrders",saleOrderService.findByEmail(id));
		}
		else{
			int userId = Integer.parseInt(id);
			model.addAttribute("saleOrders", saleOrderService.findSaleOrderByUserId(userId));
		}

		return "users/history";
	}
	@RequestMapping(value = { "/order/view/{code}"}, method = RequestMethod.GET)
	public String saleOrderProduct(@PathVariable("code") String code,final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) throws Exception {
		List<SaleOrderProducts> list = saleOrderService.findSaleOrderProductbyCode(code);
		for(SaleOrderProducts saleOrderProducts:list){
			if(saleOrderProducts.getDiscount() > 0){
				BigDecimal priceAfterDiscount = productService.calPriceAfterDiscountNoFormat(saleOrderProducts.getPrice(), saleOrderProducts.getDiscount());
				saleOrderProducts.setPriceAfterDiscount(priceAfterDiscount);
				saleOrderProducts.setTotal(priceAfterDiscount.multiply(BigDecimal.valueOf(saleOrderProducts.getQuantity())));
			}

		}
		model.addAttribute("saleOrderProducts", list);
		model.addAttribute("saleOrders", saleOrderService.findSaleOrderByCode(code));
		return "users/orderView";
	}
}
