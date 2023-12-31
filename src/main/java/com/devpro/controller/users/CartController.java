package com.devpro.controller.users;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.devpro.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.devpro.entities.AjaxResponse;
import com.devpro.entities.Cart;
import com.devpro.entities.CartItem;
import com.devpro.entities.Product;
import com.devpro.entities.SaleOrder;
import com.devpro.entities.SaleOrderProducts;
import com.devpro.entities.User;
import com.devpro.repositories.ProductRepo;
import com.devpro.repositories.SaleOrderRepo;
import com.devpro.services.ProductService;
import com.devpro.services.SaleOrderService;

@Controller
public class CartController extends BaseController {

	@Autowired
	ProductRepo productRepo;
	@Autowired
	SaleOrderRepo saleOrderRepo;
	@Autowired
	ProductService productService;
	@Autowired
	SaleOrderService saleOrderService;
	@Autowired
	UserService userService;

	@RequestMapping(value = { "/cart/finish" }, method = RequestMethod.POST)
	public String finish(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		HttpSession httpSession = request.getSession();
		String customerName = null;
		String customerAddress = null;
		String customerPhone = null;
		String customerEmail = null;
		int id = 0;
		if (SecurityContextHolder.getContext().getAuthentication().getPrincipal() != null) {
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			if (principal instanceof org.springframework.security.core.userdetails.UserDetails) {
				customerPhone = ((User) principal).getPhone();
				customerName = ((User) principal).getName();
				customerAddress = ((User) principal).getAddress();
				customerEmail = ((User) principal).getEmail();
				id = ((User) principal).getId();
				model.addAttribute("customerName", ((User) principal).getName());
				model.addAttribute("customerAddress", ((User) principal).getAddress());
				model.addAttribute("customerPhone", ((User) principal).getPhone());
				model.addAttribute("customerEmail", ((User) principal).getEmail());
			} else {
				if(principal instanceof OidcUser){
					OidcUser oidcUser = (OidcUser) principal;
					String email = oidcUser.getEmail();
					User user = userService.findUserByEmail(email);
					customerName = user.getName();
					customerAddress = user.getAddress();
					customerPhone = user.getPhone();
					customerEmail = user.getEmail();
					id = user.getId();
					model.addAttribute("customerName", (user.getName()));
					model.addAttribute("customerAddress", (user.getAddress()));
					model.addAttribute("customerPhone", (user.getPhone()));
					model.addAttribute("customerEmail", (user.getEmail()));

				}
				else{
				customerPhone = request.getParameter("customerPhone");
				customerAddress = request.getParameter("customerAddress");
				customerName = request.getParameter("customerName");
				customerEmail = request.getParameter("customerEmail");
				model.addAttribute("customerName", request.getParameter("customerName"));
				model.addAttribute("customerAddress", request.getParameter("customerAddress"));
				model.addAttribute("customerPhone", request.getParameter("customerPhone"));
				model.addAttribute("customerEmail", request.getParameter("customerEmail"));
				}
			}
		}

		SaleOrder saleOrder = new SaleOrder();
		Cart cart = (Cart) httpSession.getAttribute("GIO_HANG");
		if(cart == null){
			return "users/checkout";
		}
		else {
			List<CartItem> cartItems = cart.getCartItems();
			BigDecimal sum = new BigDecimal(0);
			String sumVN = null;
			for (CartItem item : cartItems) {
				SaleOrderProducts saleOrderProducts = new SaleOrderProducts();
				Product product = productRepo.getOne(item.getProductId());
				saleOrderProducts.setPrice(product.getPrice());
				saleOrderProducts.setDiscount(product.getDiscount());
				saleOrderProducts.setQuantity(item.getQuantity());
				saleOrder.addSaleOrderProducts(saleOrderProducts);
				for (int i = 1; i <= item.getQuantity(); i++) {
					sum = sum.add(item.getUnitPrice());
				}
				Locale locale = new Locale("vi", "VN");
				NumberFormat fmt = NumberFormat.getCurrencyInstance(locale);
				sumVN = fmt.format(sum);
			}
			model.addAttribute("quantityCart", cartItems.size());
			model.addAttribute("cartItems", cartItems);
			model.addAttribute("sumVN", sumVN);
			saleOrderService.saveOrderProduct(id,customerAddress, customerName, customerPhone, customerEmail, httpSession);
			return "users/finish";
		}
	}

	@RequestMapping(value = { "/cart/check-out" }, method = RequestMethod.GET)
	public String index(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		if (SecurityContextHolder.getContext().getAuthentication().getPrincipal() != null) {
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			if(principal instanceof OidcUser){
				OidcUser oidcUser = (OidcUser) principal;
				String email = oidcUser.getEmail();
				User user = userService.findUserByEmail(email);
				model.addAttribute("customerName", (user.getName()));
				model.addAttribute("customerAddress", (user.getAddress()));
				model.addAttribute("customerPhone", (user.getPhone()));
				model.addAttribute("customerEmail", (user.getEmail()));

			}
		}
		return "users/checkout";
	}

	@RequestMapping(value = {
			"/cart/check-out/delete-product-cart-with-ajax/{productId}" }, method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> subscribe(@RequestBody CartItem data, @PathVariable("productId") int productId,
			final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {

		HttpSession httpSession = request.getSession();
		Cart cart = null;
		if (httpSession.getAttribute("GIO_HANG") != null) {
			cart = (Cart) httpSession.getAttribute("GIO_HANG");
		} else {
			cart = new Cart();
			httpSession.setAttribute("GIO_HANG", cart);
		}

		List<CartItem> cartItems = cart.getCartItems();

		for (int a = 0; a < cartItems.size(); a++) {
			if (cartItems.get(a).getProductId() == productId) {
				cartItems.remove(a);
			}
		}

		return ResponseEntity.ok(new AjaxResponse(200, "Success"));
	}

	@RequestMapping(value = { "/cart/mua-hang" }, method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> muaHang(@RequestBody CartItem data, final ModelMap model,
			final HttpServletRequest request, final HttpServletResponse response) throws IOException {
		HttpSession httpSession = request.getSession();

		Cart cart = null;

		if (httpSession.getAttribute("GIO_HANG") != null) {
			cart = (Cart) httpSession.getAttribute("GIO_HANG");
		} else {
			cart = new Cart();
			httpSession.setAttribute("GIO_HANG", cart);
		}

		List<CartItem> cartItems = cart.getCartItems();
		boolean isExists = false;
		int quantity = 0;
		for (CartItem item : cartItems) {
			if (item.getProductId() == data.getProductId()) {
				isExists = true;
				item.setQuantity(item.getQuantity() + data.getQuantity());
			}
		}
		if (!isExists) {
			Product product = productRepo.getOne(data.getProductId());
			data.setProductName(product.getTitle());
                        if(product.getDiscount() > 0){
                            BigDecimal priceAfterDiscount = productService.calPriceAfterDiscountNoFormat(product.getPrice(),product.getDiscount());
                            product.setPrice(priceAfterDiscount);
                        }
			data.setUnitPrice(product.getPrice());
			cart.getCartItems().add(data);
		}
		for (CartItem item : cartItems) {
			quantity += item.getQuantity();
		}

		httpSession.setAttribute("SL_SP_GIO_HANG", quantity);

		return ResponseEntity.ok(new AjaxResponse(200, String.valueOf(quantity)));
	}

}
