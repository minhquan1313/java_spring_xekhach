package com.mtb.myObject;

import java.util.ArrayList;
import java.util.List;

public class SideBarUI {
    private List<SideBarUIItem> list;

    public SideBarUI() {
        list = new ArrayList<>();
    }

    public void register(SideBarUIItem item) {
        if (list.stream().anyMatch(r -> {
            boolean titleMatch = r.getTitle().equals(item.getTitle());
            boolean codeMatch = r.getCode() == item.getCode();
            return codeMatch || titleMatch;
        }))
            return;

        list.add(item);
    }

    public SideBarUIItem get(int code) {
        for (SideBarUIItem x : list) {
            if (x.getCode() == code)
                return x;
        }

        return null;
    }

    public List<SideBarUIItem> getList() {
        return list;
    }

}
