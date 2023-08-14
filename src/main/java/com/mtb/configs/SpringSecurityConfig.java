package com.mtb.configs;

import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.mtb.myObject.SideBarUI;
import com.mtb.myObject.SideBarUIItem;

@Configuration
@EnableWebSecurity
@EnableTransactionManagement
@ComponentScan(basePackages = {
        "com.mtb.controllers",
        "com.mtb.repository",
        "com.mtb.service"
})
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private Environment env;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.formLogin()
                // .loginPage("/login")
                .usernameParameter("username")
                .passwordParameter("password");

        http.formLogin().defaultSuccessUrl("/").failureUrl("/login?error");

        http.logout().logoutSuccessUrl("/");

        http.exceptionHandling().accessDeniedPage("/login?accessDenied");

        // http.authorizeRequests()
        // .antMatchers("/").permitAll()
        // .antMatchers("/**/add").access("hasRole('ROLE_ADMIN')")
        // .antMatchers("/**/pay").access("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')");

        http.csrf().disable();
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @Bean
    public Cloudinary cloudinary() {
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", this.env.getProperty("cloudinary.cloud_name"),
                "api_key", this.env.getProperty("cloudinary.api_key"),
                "api_secret", this.env.getProperty("cloudinary.api_secret"),
                "secure", true));
        return cloudinary;
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @Bean
    public SimpleDateFormat simpleDateFormat() {
        return new SimpleDateFormat("yyyy/MM/dd");
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @Bean
    public SideBarUI sideBarUi() {
        SideBarUI x = new SideBarUI();
        x.register(new SideBarUIItem(0, "bi bi-house fs-5", "Trang chủ", "/"));
        x.register(new SideBarUIItem(6, "bi bi-graph-up-arrow fs-5", "Doanh thu", "/revenue"));
        x.register(new SideBarUIItem(1, "bi bi-people-fill fs-5", "Người dùng", "/users"));
        x.register(new SideBarUIItem(5, "bi bi-key fs-5", "Vai trò", "/roles"));
        x.register(new SideBarUIItem(2, "bi bi-signpost-2 fs-5", "Tuyến xe", "/routes"));
        x.register(new SideBarUIItem(4, "bi bi-pin-map fs-5", "Chuyến xe", "/trips"));
        x.register(new SideBarUIItem(3, "bi bi-tags fs-5", "Vé xe", "/tickets"));
        x.register(new SideBarUIItem(7, "bi bi-graph-up-arrow fs-5", "Xe khách", "/buses"));
        x.register(new SideBarUIItem(8, "bi bi-chat-heart fs-5", "Phản hồi", "/feedbacks"));
        return x;
    }
}
