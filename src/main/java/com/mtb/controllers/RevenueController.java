package com.mtb.controllers;

import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.myObject.TitleAndValue;
import com.mtb.myObject.TitleAndValue.TitleAndValueChartJs;
import com.mtb.myObject.Utils;
import com.mtb.service.StatsService;

@Controller
public class RevenueController {

        @Autowired
        private StatsService statsService;

        @Autowired
        private MessageSource messageResource;

        @RequestMapping("/revenue")
        public String index(Model model, @RequestParam Map<String, String> params, Locale locale) {
                String year = params.get("year");
                String yearStart = params.get("yearStart");
                String yearEnd = params.get("yearEnd");

                String multiLangDoanhThu = messageResource.getMessage("ui.revenue.chart.revenue", null, locale);
                String multiLangDoanhThuNam = messageResource.getMessage("con.revenue.chart.revenue_months_of_year",
                                null,
                                locale);
                String multiLangDoanhThuTuNamDenNay = messageResource.getMessage(
                                "con.revenue.chart.revenue_in_years_from_to_now",
                                null, locale);
                String multiLangDoanhThuTuNamDenNam = messageResource.getMessage(
                                "con.revenue.chart.revenue_in_years_from_to",
                                null, locale);
                String multiLangDoanhCacQuy = messageResource.getMessage("con.revenue.chart.revenue_quarters_of_year",
                                null, locale);
                String multiLangDoanhThuCacQuyTrongNam = messageResource.getMessage(
                                "con.revenue.chart.revenue_quarter_and_year",
                                null, locale);
                String multiLangDoanhThuCacThangTrongNam = messageResource
                                .getMessage("con.revenue.chart.revenue_month_and_year", null, locale);

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

                                if (yearStart == null || yearStart.isEmpty()) {
                                        _yearStart = _yearEnd - 5;
                                }
                        } catch (Exception e) {
                        }
                }

                List<TitleAndValue> revenueByMonthsCurrentY = statsService.revenueByMonthsInYear(_year,
                                multiLangDoanhThuCacThangTrongNam);
                TitleAndValueChartJs revenueByMonthsCurrentYChartJs = TitleAndValue
                                .parseToChartJsData(revenueByMonthsCurrentY);
                revenueByMonthsCurrentYChartJs.setDataOf(multiLangDoanhThu);
                revenueByMonthsCurrentYChartJs
                                .setTableName(Utils.replaceFromMessageBean(multiLangDoanhThuNam,
                                                String.valueOf(_year)));
                revenueByMonthsCurrentYChartJs.setDataPostfix("VND");
                model.addAttribute("revenueByMonthsCurrentYChartJs", revenueByMonthsCurrentYChartJs);

                List<TitleAndValue> revenueByMonthsIn5Years = statsService.revenueByYears(_yearStart, _yearEnd,
                                multiLangDoanhThuCacThangTrongNam);
                TitleAndValueChartJs revenueByMonthsIn5YearsChartJs = TitleAndValue
                                .parseToChartJsData(revenueByMonthsIn5Years);
                revenueByMonthsIn5YearsChartJs.setDataOf(multiLangDoanhThu);
                if (_yearEnd == yearNow) {
                        // till now
                        revenueByMonthsIn5YearsChartJs
                                        .setTableName(
                                                        Utils.replaceFromMessageBean(multiLangDoanhThuTuNamDenNay,
                                                                        String.valueOf(_yearEnd - _yearStart),
                                                                        String.valueOf(_yearStart)));
                } else {
                        // till a year
                        revenueByMonthsIn5YearsChartJs
                                        .setTableName(
                                                        Utils.replaceFromMessageBean(multiLangDoanhThuTuNamDenNam,
                                                                        String.valueOf(_yearEnd - _yearStart),
                                                                        String.valueOf(_yearStart),
                                                                        String.valueOf(_yearEnd)));
                }
                revenueByMonthsIn5YearsChartJs.setDataPostfix("VND");
                model.addAttribute("revenueByMonthsIn5YearsChartJs", revenueByMonthsIn5YearsChartJs);

                List<TitleAndValue> revenueByQuarters = statsService.revenueByQuarters(_year,
                                multiLangDoanhThuCacQuyTrongNam);
                TitleAndValueChartJs revenueByQuartersChartJs = TitleAndValue.parseToChartJsData(revenueByQuarters);
                revenueByQuartersChartJs.setDataOf(multiLangDoanhThu);
                revenueByQuartersChartJs
                                .setTableName(Utils.replaceFromMessageBean(multiLangDoanhCacQuy,
                                                String.valueOf(_year)));
                revenueByQuartersChartJs.setChartType("pie");
                revenueByQuartersChartJs.setDataPostfix("VND");
                model.addAttribute("revenueByQuartersChartJs", revenueByQuartersChartJs);

                return "revenue";
        }
}
