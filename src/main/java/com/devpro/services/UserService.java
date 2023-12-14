package com.devpro.services;

import java.io.File;
import java.util.*;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.devpro.GeneratePassword;
import com.devpro.entities.PasswordResetToken;
import com.devpro.entities.Role;
import com.devpro.entities.User;
import com.devpro.repositories.RoleRepo;
import com.devpro.repositories.UserRepo;
import com.devpro.repositories.passwordTokenRepo;

@Service
public class UserService {

    @PersistenceContext
    protected EntityManager entityManager;
    @Autowired
    public UserRepo userRepo;
    @Autowired
    public RoleRepo roleRepo;
    @Autowired
    public passwordTokenRepo pwdTokenRepo;
    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private CustomOidcUserService  oidcUserService;

    public User findUserById(final int id) {
        Optional<User> user = userRepo.findById(id);
        if (user.isPresent()) {
            return user.get();
        }
        throw new RuntimeException("Can't find User");
    }

    public Role findRoleById(final int id) {
        Optional<Role> role = roleRepo.findById(id);
        if (role.isPresent()) {
            return role.get();
        }
        throw new RuntimeException("Can't find role");
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

    public User findUserByEmail(String email) {
        User user = userRepo.findByEmail(email);
        return user;
    }
    public void saveOauth2User(){


    }
    public User findUserByUsername(String username){
        return userRepo.findByUsername(username);
    }
    public void sendConfirmationEmail(User user){
        String contextPath = "http://localhost:8080";
        String token = UUID.randomUUID().toString();
        createEmailConfirmationToken(user,token);
        mailSender.send(constructConfirmationEmail(contextPath,token,user));

    }

    private SimpleMailMessage constructConfirmationEmail(
            String contextPath, String token, User user) {
        String url = contextPath + "/verify?token=" + token;
        String message = "Click here to confirm your email";
        return constructEmail("Confirm email", message + " \r\n" + url, user);
    }

    private SimpleMailMessage constructEmail(String subject, String body,
                                             User user) {
        SimpleMailMessage email = new SimpleMailMessage();
        email.setSubject(subject);
        email.setText(body);
        email.setTo(user.getEmail());
        email.setFrom("KhanhLaptop");
        return email;
    }
    public void createEmailConfirmationToken(User user, String token){
        user.setConfirmationToken(token);
        userRepo.save(user);
    }

    public void createPasswordResetTokenForUser(User user, String token) {
        PasswordResetToken myToken = new PasswordResetToken(token, user);
        pwdTokenRepo.save(myToken);
    }

    public String validatePasswordResetToken(String token) {
        final PasswordResetToken passToken = pwdTokenRepo.findByToken(token);

        return !isTokenFound(passToken) ? "invalidToken"
                : isTokenExpired(passToken) ? "expired"
                : null;
    }

    private boolean isTokenFound(PasswordResetToken passToken) {
        return passToken != null;
    }

    private boolean isTokenExpired(PasswordResetToken passToken) {
        final Calendar cal = Calendar.getInstance();
        return passToken.getExpiryDate().before(cal.getTime());
    }
    public User findUserByToken(String token){
        PasswordResetToken passToken = pwdTokenRepo.findByToken(token);
        return passToken.getUser();
    }
    public User findUserByEmailToken(String token){
        return userRepo.findByConfirmationToken(token);
    }

    public User loadUserByUsername(String userName) {
        try {
            String jpql = "From User u Where u.username='" + userName + "'";
            Query query = entityManager.createQuery(jpql, User.class);
            return (User) query.getResultList().get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Transactional(rollbackOn = Exception.class)
    public void saveUser(MultipartFile[] images, User user) throws Exception {
        try {
            if (user.getId() != null) { // chỉnh sửa
                // lấy dữ liệu cũ của sản phẩm
                User userInDb = userRepo.findById(user.getId()).get();
                // lấy danh sách ảnh của user cũ
                String avatar = userInDb.getAvatar();
                if (!isEmptyUploadFile(images)) { // nếu admin sửa ảnh sản phẩm
                    // xoá ảnh cũ đi
                    new File("D:/JavaWeb10_VuTheKhoa_Day27/com.devpro.shop/upload_avt/" + user.getAvatar()).delete();

                } else { // ảnh phải giữ nguyên
                    user.setAvatar(avatar);
                }
            }
            if (!isEmptyUploadFile(images)) { // nếu admin upload ảnh
                for (MultipartFile image : images) {
                    // Lưu file vào host.
                    image.transferTo(new File(
                            "D:/JavaWeb10_VuTheKhoa_Day27/com.devpro.shop/upload_avt/" + image.getOriginalFilename()));
                    user.setAvatar(image.getOriginalFilename());
                }
            }
            if (user.getCreatedDate() != null) {
                user.setUpdatedDate(java.time.LocalDateTime.now());
            } else {
                user.setCreatedDate(java.time.LocalDateTime.now());
            }

            userRepo.save(user);
        } catch (Exception e) {
            throw e;
        }
    }

    @Transactional(rollbackOn = Exception.class)
    public void saveGuestUser(User user) throws Exception {
        try {
            user.setPassword(GeneratePassword.GenerPass(user.getPassword()));
            user.getRoles().add(findRoleById(2));
            user.setUpdatedDate(java.time.LocalDateTime.now());
            user.setCreatedDate(java.time.LocalDateTime.now());
            user.setStatus(false);
            userRepo.save(user);
        } catch (Exception e) {
            throw e;
        }
    }
}
