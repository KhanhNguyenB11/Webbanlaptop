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
    @Autowired
    UserService userService;
    @Autowired
    private JavaMailSender mailSender;

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
        model.addAttribute("products", productService.search(productSearch));
        return "users/UserHome";
    }

    @RequestMapping(value = {"/resetpwd"}, method = RequestMethod.GET)
    public String resetpwd(final ModelMap model, @Param("keyword") String keyword, final HttpServletRequest request,
            final HttpServletResponse response) throws Exception {
        return "users/resetpwd";

    }

    @PostMapping("/resetpwd")
    public GenericResponse resetPassword(HttpServletRequest request, @RequestParam("email") String userEmail) {
        User user = userService.findUserByEmail(userEmail);
        if (user == null) {
            return null;
        }
        String token = UUID.randomUUID().toString();
        userService.createPasswordResetTokenForUser(user, token);
        mailSender.send(constructResetTokenEmail(getAppUrl(request),
                request.getLocale(), token, user));
        return new GenericResponse("message.resetPasswordEmail", null);
    }

    private String getAppUrl(HttpServletRequest request) {
        return "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
    }

    private SimpleMailMessage constructResetTokenEmail(
            String contextPath, Locale locale, String token, User user) {
        String url = contextPath + "/user/changePassword?token=" + token;
        String message = "message.resetPassword";
        return constructEmail("Reset Password", message + " \r\n" + url, user);
    }

    private SimpleMailMessage constructEmail(String subject, String body,
            User user) {
        SimpleMailMessage email = new SimpleMailMessage();
        email.setSubject(subject);
        email.setText(body);
        email.setTo(user.getEmail());
        email.setFrom("dantedmc1134@gmail.com");
        return email;
    }

}
