package com.devpro.services;

import com.devpro.entities.User;
import com.devpro.repositories.UserRepo;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserRequest;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Service;

@Service
public class CustomOidcUserService extends OidcUserService {
    private final UserRepo userRepository;

    public CustomOidcUserService(UserRepo userRepository) {
        this.userRepository = userRepository;
    }
    @Override
    public OidcUser loadUser(OidcUserRequest userRequest) throws OAuth2AuthenticationException {
        OidcUser oidcUser = super.loadUser(userRequest);

        String email = oidcUser.getEmail();
        String firstName = oidcUser.getName();
        String lastName = oidcUser.getFamilyName();


        // Check if the user already exists in the database based on email
        User existingUser = userRepository.findByEmail(email);

        if (existingUser == null) {
            // If the user doesn't exist, create a new user and save to the database
            User newUser = new User();
            newUser.setEmail(email);
            newUser.setUsername(email);
            newUser.setFirstName(firstName);
            newUser.setName(lastName);
            newUser.setEnabled(true);
            userRepository.save(newUser);
        }

        return oidcUser;
    }
}
