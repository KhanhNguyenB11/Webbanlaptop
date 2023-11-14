package com.devpro.controller.admin;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ASUS
 */
import com.devpro.controller.users.BaseController;
import com.devpro.entities.User;
import com.devpro.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class UserInfoController extends BaseController {
    @Autowired
    UserService userService;

    @RequestMapping(value = "user/{id}", method = RequestMethod.GET)
    public String userInfo(@PathVariable("id") String id, final ModelMap model,final HttpServletRequest request,
                           final HttpServletResponse response) throws Exception {
        int userId = Integer.parseInt(id);
        // Find user by ID
        User user = userService.findUserById(userId);
        System.out.println(user.getRoles());
       if(authUser(userId)){
           model.addAttribute("user", user);
           return "users/UserInfo";
       }
        return "redirect:/home";
    }
    @RequestMapping(value = { "/saveUser" }, method = RequestMethod.POST)
    public String saveGuestUser(@RequestParam("images") MultipartFile[] images, @ModelAttribute("user") User user, final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
            throws Exception {
        userService.saveUser(images,user);
        return "redirect:/home";
    }
    public boolean authUser(int userId){
        String id = "";
        Object principal = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication()
                .getPrincipal();
        if (principal instanceof org.springframework.security.core.userdetails.UserDetails) {
            id = String.valueOf(((User)principal).getId());
            if(userId != Integer.parseInt(id)){
                return false;
            }
        }
        return true;
    }
}
