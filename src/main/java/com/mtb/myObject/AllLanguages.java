package com.mtb.myObject;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class AllLanguages {
    List<String> list;

    public AllLanguages(List<String> list) {
        this.list = list;
    }

    public AllLanguages() {
        this.list = new ArrayList<>();
    }
}
