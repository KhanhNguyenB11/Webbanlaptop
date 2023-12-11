/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.devpro.controller.users;

import com.devpro.entities.User;
import com.devpro.services.UserService;
import java.util.Locale;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.devpro.GeneratePassword;
/**
 *
 * @author ASUS
 */
@Controller
public class ForgotPasswordController {

    @Autowired
    UserService userService;
    @Autowired
    private JavaMailSender mailSender;

    @RequestMapping(value = {"/resetpwd"}, method = RequestMethod.GET)
    public String resetpwd(final ModelMap model, @Param("keyword") String keyword, final HttpServletRequest request,
            final HttpServletResponse response) throws Exception {
        return "users/resetpwd";

    }

    @GetMapping("/user/changePassword")
    public String showChangePasswordPage(Locale locale, final ModelMap model,
            @RequestParam("token") String token) {
        String result = userService.validatePasswordResetToken(token);
        if (result != null) {
            String message ="auth.message." + result;
            return "redirect:/login?message="+message;
        } else {
            model.addAttribute("token", token);
            return "users/updatePassword";
        }
    }

    @PostMapping("/resetpwd")
    public String resetPassword(HttpServletRequest request, @RequestParam("email") String userEmail, final ModelMap model) {
        User user = userService.findUserByEmail(userEmail);
        if (user == null) {
            return null;
        }
        String token = UUID.randomUUID().toString();
        userService.createPasswordResetTokenForUser(user, token);
        mailSender.send(constructResetTokenEmail(getAppUrl(request),
                request.getLocale(), token, user));
        model.addAttribute("email", userEmail);
        model.addAttribute("message","Check your email, token expires in 3 minutes.");
        return "users/resetpwd";
    }

   
    @PostMapping("/savePassword")
    public String savePassword(HttpServletRequest request, @RequestParam("newp") String password,@RequestParam("token") String token,final ModelMap model) throws Exception {
        User user = userService.findUserByToken(token);
        user.setPassword(GeneratePassword.GenerPass(password));
        userService.saveUser(null, user);
        return "login";
    }
     private String getAppUrl(HttpServletRequest request) {
        return "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
    }

    private SimpleMailMessage constructResetTokenEmail(
            String contextPath, Locale locale, String token, User user) {
        String url = contextPath + "/user/changePassword?token=" + token;
        String message = "Click here to reset your password";
        return constructEmail("Reset Password", message + " \r\n" + url, user);
    }

    private SimpleMailMessage constructEmail(String subject, String body,
            User user) {
        SimpleMailMessage email = new SimpleMailMessage();
        email.setSubject(subject);
        email.setText(body);
        email.setTo(user.getEmail());
        email.setFrom("dragonxxl1134@gmail.com");
        return email;
    }

}
