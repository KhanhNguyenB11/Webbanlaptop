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
    
    private int check = 0;
    @PostMapping("/sortChange")
    public String choose(final ModelMap model, @RequestParam("check") String value, final HttpServletRequest request,
            final HttpServletResponse response) throws Exception {
        if("1".equals(value)){
            check = 1;
        }else if ("2".equals(value)){
            check =2;
        }
        return "redirect:/home";
    }
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
        List<Product> flashSale = productService.findFlashSale();
        model.addAttribute("flashSale",flashSale);
<<<<<<< HEAD
        List<Product> list;
        switch (check) {
            default:
                list = productService.search(productSearch);
                break;
            case 1:
                list = productService.findProductsMaxToMin();
                break;
            case 2:
                list = productService.findProductsMinToMax();
                break;
        }
=======
        List<Product> list = productService.search(productSearch);
>>>>>>> 6f6ef0b75b0e176815964fc80e21be4fb703f423
        list.forEach(p ->{
            if(p.getDiscount() > 0){
                p.setPriceAfterDiscount(productService.calPriceAfterDiscount(p.getPrice(), p.getDiscount()));
            }
            else{
                p.setPriceAfterDiscount(p.getPriceVN());
            }
        
        });

        model.addAttribute("products", list);
        return "users/UserHome";
    }



}
