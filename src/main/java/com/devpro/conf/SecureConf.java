package com.devpro.conf;

import com.devpro.repositories.UserRepo;
import com.devpro.services.CustomOidcUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserRequest;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;

@Configuration
@EnableWebSecurity
public class SecureConf extends WebSecurityConfigurerAdapter {
	
	@Autowired private UserDetailsService userDetailsService;
	@Autowired private UserRepo userRepo;

	@Autowired
	CustomOidcUserService customOidcUserService;
	@Override
	protected void configure(final HttpSecurity http) throws Exception {
		http.csrf().disable().authorizeRequests() // thực hiện xác thực request ngưười dùng gửi lên.
			
			// không thực hiện xác thực đối với các ur/ này.
            .antMatchers("/css/**", "/js/**", "/img/**", "/vendor/**"
            		, "/font-awesome/**", "/summernote/**", "/files/**").permitAll()
            
            // thực hiện xác thực với các url kiểu ..../admin/....
            .antMatchers("/admin/**").hasAnyAuthority("ADMIN","Nhan Vien")
//            .antMatchers("/admin/**").authenticated()
            
            .and() // kết hợp với điều kiện.
            
            // khi click vào button logout thì không cần login.
            // khi click vào button này thì dữ liệu user trên session sẽ bị xoá.
            .logout()
            .logoutUrl("/logout")
            .logoutSuccessUrl("/home")
            .invalidateHttpSession(true) // xoá hết dữ liệu trên seesion
            .deleteCookies("JSESSIONID") // xoá hết dữ liệu trên cokies.
            .permitAll()
            
            .and() // kết hợp với điều kiện.
            
            .formLogin() // thực hiện xác thực qua form(username và password)
            .loginPage("/login") // trang login do mình thiết kế.
            .loginProcessingUrl("/perform_login") // link action for form post.
            .defaultSuccessUrl("/home", true) // when user success authenticated then go to this url.
            .failureUrl("/login?login_error=true") // nhập username, password sai thì redirect về trang nào.
            .permitAll()
				.and()
				.oauth2Login().userInfoEndpoint()
				.oidcUserService(customOidcUserService)
				.and()
				.loginPage("/login") // Redirect to your custom login page
				.defaultSuccessUrl("/home") // Redirect after successful OAuth login
				.failureUrl("/login?login_error=true"); // Redirect after failed OAuth login;



	}
	
	@Bean
    public PasswordEncoder passwordEncoder() {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(16);
		return encoder;
    }
	
	@Autowired public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}

	
}
