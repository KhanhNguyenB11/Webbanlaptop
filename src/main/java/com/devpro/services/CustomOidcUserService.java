package com.devpro.services;

import com.devpro.GeneratePassword;
import com.devpro.entities.User;
import com.devpro.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserRequest;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class CustomOidcUserService extends OidcUserService {
    @Autowired
    private final UserRepo userRepository;

    @Autowired
    private final UserService userService;

    public CustomOidcUserService(UserRepo userRepository, UserService userService) {
        this.userRepository = userRepository;
        this.userService = userService;
    }

    @Override
    public OidcUser loadUser(OidcUserRequest userRequest) throws OAuth2AuthenticationException {
        OidcUser oidcUser = super.loadUser(userRequest);

        String email = oidcUser.getEmail();
        String firstName = oidcUser.getName();
        String lastName = oidcUser.getFamilyName();

        // Check if the user already exists in the database based on email
        User existingUser = userRepository.findByEmail(email);
        int id;
        if (existingUser == null) {
            // If the user doesn't exist, create a new user and save to the database
            User newUser = new User();
            newUser.setEmail(email);
            newUser.setUsername(email);
            newUser.setFirstName(firstName);
            newUser.setName(lastName);

            newUser.setCreatedDate(LocalDateTime.now());
            newUser.getRoles().add(userService.findRoleById(2));
            newUser.setStatus(true);
            if(oidcUser.getPhoneNumber() != null)
                newUser.setPhone(oidcUser.getPhoneNumber());
            else{
                newUser.setPhone("123456789");
            }
            if(oidcUser.getAddress() != null){
                newUser.setAddress(oidcUser.getAddress().toString());
            }
            newUser.setPassword(GeneratePassword.GenerPass("123"));
            id = userRepository.save(newUser).getId();
        }
        else{
            id = existingUser.getId();
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();

            ((User) principal).setId(id);
        }
        return oidcUser;
    }
}
