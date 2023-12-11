package com.devpro.controller.users;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devpro.common.ProductSearch;
import com.devpro.entities.Product;
import com.devpro.entities.User;
import com.devpro.services.ProductService;
import com.devpro.services.UserService;
import java.util.Locale;
import java.util.UUID;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController extends BaseController {

    @Autowired
    ProductService productService;
    

//	@Autowired  //lấy bean từ container's spring.
//	private CategoryRepo categoryRepo;
    @RequestMapping(value = {"/home", "/index", "/"}, method = RequestMethod.GET)
    public String index(final ModelMap model, @Param("keyword") String keyword, final HttpServletRequest request,
            final HttpServletResponse response) throws Exception {

//		List<Category> categories = categoryRepo.findAll();
//		for(Category category : categories) {
//			System.out.println(category.getName());
//		}
        ProductSearch productSearch = new ProductSearch();
        String strPage = request.getParameter("page");
        String minprice = request.getParameter("minprice");
        String maxprice = request.getParameter("maxprice");
        String sort = request.getParameter("sort");
        keyword = request.getParameter("keyword");
        productSearch.setStatusProduct(1);
        if (sort != null) {
            productSearch.setSort(sort);
        }
        if (minprice != null) {
            productSearch.setMinprice(minprice);
        }
        if (maxprice != null) {
            productSearch.setMaxprice(maxprice);
        }
        if (keyword != null) {
            productSearch.setKeyword(keyword);
        }
        List<Product> product = productService.search(productSearch);

        int numberOfPage = product.size() / productSearch.SIZE_ITEMS_ON_PAGE + 1;
        System.out.println("numberOfPage: " + numberOfPage);
        ArrayList numberOP = new ArrayList();
        for (int i = 1; i < numberOfPage + 1; i++) {
            numberOP.add(i);
        }

        productSearch.parseRequest(request);
        model.addAttribute("numberOP", numberOP);
        model.addAttribute("numberOfPage", numberOfPage);
        List<Product> list = productService.search(productSearch);
        list.forEach(p ->{
            if(p.getDiscount() > 0){
                p.setPrice(productService.calPriceAfterDiscount(p.getPrice(), p.getDiscount()));
            }
        
        });
        model.addAttribute("products", list);
        return "users/UserHome";
    }

}
