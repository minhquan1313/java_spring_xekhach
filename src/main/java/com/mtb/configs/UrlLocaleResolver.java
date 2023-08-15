package com.mtb.configs;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.LocaleResolver;

import com.mtb.myObject.MyCookies;

public class UrlLocaleResolver implements LocaleResolver {

    // private static final String URL_LOCALE_ATTRIBUTE_NAME =
    // "URL_LOCALE_ATTRIBUTE_NAME";

    public static final String COOKIE_NAME_LANGUAGE = "language";

    @Override
    public Locale resolveLocale(HttpServletRequest request) {
        String language = MyCookies.getCookies(request, COOKIE_NAME_LANGUAGE);
        Locale locale = customGetLocale(language);
        return locale;
    }

    @Override
    public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {
        // Nothing
    }

    public Locale customGetLocale(String language) {
        if (language != null) {
            if (language.equals("vi"))
                return new Locale.Builder().setLanguage(language).setRegion("VN").build();
        }

        return Locale.US;
    }
}
