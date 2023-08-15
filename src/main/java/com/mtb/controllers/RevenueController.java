package com.mtb.controllers;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.myObject.TitleAndValue;
import com.mtb.myObject.TitleAndValue.TitleAndValueChartJs;
import com.mtb.service.StatsService;

@Controller
public class RevenueController {

    @Autowired
    private StatsService statsService;

    @RequestMapping("/revenue")
    public String index(Model model, @RequestParam Map<String, String> params) {
        String year = params.get("year");
        String yearStart = params.get("yearStart");
        String yearEnd = params.get("yearEnd");

        int yearNow = Calendar.getInstance().get(Calendar.YEAR);
        int _year = yearNow;
        int _yearStart = yearNow - 5;
        int _yearEnd = yearNow;

        if (year != null && !year.isEmpty()) {
            try {
                _year = Integer.parseInt(year);
                model.addAttribute("year", _year);
            } catch (Exception e) {
            }
        }

        if (yearStart != null && !yearStart.isEmpty()) {
            try {
                _yearStart = Integer.parseInt(yearStart);
                model.addAttribute("yearStart", _yearStart);
            } catch (Exception e) {
            }
        }
        if (yearEnd != null && !yearEnd.isEmpty()) {
            try {
                _yearEnd = Integer.parseInt(yearEnd);
                model.addAttribute("yearEnd", _yearEnd);
            } catch (Exception e) {
            }
        }

        List<TitleAndValue> revenueByMonthsCurrentY = statsService.revenueByMonthsInYear(_year);
        TitleAndValueChartJs revenueByMonthsCurrentYChartJs = TitleAndValue.parseToChartJsData(revenueByMonthsCurrentY);
        revenueByMonthsCurrentYChartJs.setDataOf("Doanh thu");
        revenueByMonthsCurrentYChartJs.setTableName("Doanh thu năm " + _year);
        revenueByMonthsCurrentYChartJs.setDataPostfix("VND");
        model.addAttribute("revenueByMonthsCurrentYChartJs", revenueByMonthsCurrentYChartJs);

        List<TitleAndValue> revenueByMonthsIn5Years = statsService.revenueByYears(_yearStart, _yearEnd);
        TitleAndValueChartJs revenueByMonthsIn5YearsChartJs = TitleAndValue.parseToChartJsData(revenueByMonthsIn5Years);
        revenueByMonthsIn5YearsChartJs.setDataOf("Doanh thu");
        revenueByMonthsIn5YearsChartJs
                .setTableName("Doanh thu trong " + (_yearEnd - _yearStart) + " năm từ " + (_yearStart) + " đến "
                        + (_yearEnd == yearNow ? "nay" : _yearEnd));
        revenueByMonthsIn5YearsChartJs.setDataPostfix("VND");
        model.addAttribute("revenueByMonthsIn5YearsChartJs", revenueByMonthsIn5YearsChartJs);

        List<TitleAndValue> revenueByQuarters = statsService.revenueByQuarters(_year);
        TitleAndValueChartJs revenueByQuartersChartJs = TitleAndValue.parseToChartJsData(revenueByQuarters);
        revenueByQuartersChartJs.setDataOf("Doanh thu");
        revenueByQuartersChartJs.setTableName("Doanh thu trong các quý của năm " + _year);
        revenueByQuartersChartJs.setChartType("pie");
        revenueByQuartersChartJs.setDataPostfix("VND");
        model.addAttribute("revenueByQuartersChartJs", revenueByQuartersChartJs);

        return "revenue";
    }
}
