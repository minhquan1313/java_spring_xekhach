package com.mtb.myObject;

import lombok.Data;

@Data
public class SideBarUIItem {
    private int code;
    private String icon;
    private String title;
    private String url;

    public SideBarUIItem(int code, String title) {
        this.code = code;
        this.title = title;
    }

    public SideBarUIItem(int code, String icon, String title) {
        this.code = code;
        this.icon = icon;
        this.title = title;
    }

    public SideBarUIItem(int code, String icon, String title, String url) {
        this.code = code;
        this.icon = icon;
        this.title = title;
        this.url = url;
    }
}
