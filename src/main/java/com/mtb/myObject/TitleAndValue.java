package com.mtb.myObject;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class TitleAndValue {
    private String title;
    private int value;

    public TitleAndValue(String title, int value) {
        this.title = title;
        this.value = value;
    }

    public static TitleAndValueChartJs parseToChartJsData(List<TitleAndValue> list) {
        TitleAndValueChartJs x = new TitleAndValueChartJs();

        list.forEach(r -> {
            x.addLabel(r.getTitle());
            x.addData(r.getValue());
        });

        return x;
    }

    @Data
    public static class TitleAndValueChartJs {
        private String tableName;
        private List<String> label;
        private List<String> data;
        private String dataPostfix;
        private String dataOf;
        private String chartType;

        public TitleAndValueChartJs() {
            this.label = new ArrayList<>();
            this.data = new ArrayList<>();
        }

        public void addLabel(String label) {
            this.label.add(label);
        }

        public void addData(int data) {
            this.data.add(String.valueOf(data));
        }
    }

}
