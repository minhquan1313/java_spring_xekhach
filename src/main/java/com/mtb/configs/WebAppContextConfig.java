package com.mtb.configs;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.env.Environment;
import org.springframework.format.FormatterRegistry;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.mtb.formatter.BusFormatter;
import com.mtb.formatter.RoleFormatter;
import com.mtb.formatter.RouteFormatter;
import com.mtb.formatter.TicketFormatter;
import com.mtb.formatter.TripFormatter;
import com.mtb.formatter.UserFormatter;

@Configuration
@EnableWebMvc
@EnableTransactionManagement
@ComponentScan(basePackages = {
        "com.mtb.controllers",
        "com.mtb.repository",
        "com.mtb.service"
})
@PropertySource("classpath:configs.properties")
public class WebAppContextConfig implements WebMvcConfigurer {

    @Autowired
    private Environment env;

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addFormatter(new RoleFormatter());
        registry.addFormatter(new BusFormatter());
        registry.addFormatter(new RouteFormatter());
        registry.addFormatter(new UserFormatter());
        registry.addFormatter(new TripFormatter());
        registry.addFormatter(new TicketFormatter());
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/js/**").addResourceLocations("/WEB-INF/resources/js/");
        registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/resources/css/");
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setDefaultEncoding("UTF-8");
        return resolver;
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=:START Multi languages part

    @Bean(name = "localeResolver")
    public LocaleResolver getLocaleResolver() {
        LocaleResolver resolver = new UrlLocaleResolver();
        return resolver;

        // CookieLocaleResolver resolver = new CookieLocaleResolver();
        // resolver.setCookieDomain("myAppLocaleCookie");
        // return resolver;
    }

    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageResource = new ReloadableResourceBundleMessageSource();
        messageResource.setBasename("classpath:languages/languages");
        messageResource.setDefaultEncoding("UTF-8");
        return messageResource;

        // ResourceBundleMessageSource m = new ResourceBundleMessageSource();

        // m.setBasenames("messages");

        // return m;
    }
    // -=-=-=-=-=-=-=-=-=-=-=-=-=:END Multi languages part

    @Bean(name = "validator")
    public LocalValidatorFactoryBean validator() {
        LocalValidatorFactoryBean bean = new LocalValidatorFactoryBean();
        bean.setValidationMessageSource(messageSource());
        return bean;
    }

    @Override
    public Validator getValidator() {
        return validator();
    }

}
