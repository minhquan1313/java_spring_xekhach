package com.mtb.controllers;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.mtb.configs.UrlLocaleResolver;
import com.mtb.myObject.AllLanguages;
import com.mtb.myObject.MyCookies;

@Controller
@ControllerAdvice
public class LanguageController {

    private static final String LANG = UrlLocaleResolver.COOKIE_NAME_LANGUAGE;

    // @Autowired
    // private MessageSource messageResource;

    @Autowired
    private AllLanguages allLanguages;

    @ModelAttribute
    public void commonAttr(Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) {
        // Get text from multi language
        // String x = messageResource.getMessage("ui.index.dashboard_text", null,
        // locale);

        String languageFromCookies = MyCookies.getCookies(request, LANG);
        if (languageFromCookies == null) {
            // First time come to will get English language
            String l = locale.getLanguage();
            MyCookies.setCookies(response, LANG, l);
        }

        model.addAttribute("LANG", LANG);
        model.addAttribute(LANG, languageFromCookies);
        model.addAttribute("allLanguages", allLanguages.getList());
    }
}
