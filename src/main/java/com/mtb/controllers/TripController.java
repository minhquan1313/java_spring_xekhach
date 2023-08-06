package com.mtb.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.Bus;
import com.mtb.pojo.Route;
import com.mtb.pojo.Trip;
import com.mtb.pojo.User;
import com.mtb.service.BusSeatTripService;
import com.mtb.service.BusService;
import com.mtb.service.RouteService;
import com.mtb.service.TripService;
import com.mtb.service.UserService;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TripController {

    @Autowired
    private TripService tripService;

    @Autowired
    private BusSeatTripService busSeatTripService;

    @Autowired
    private RouteService routeService;

    @Autowired
    private BusService busService;

    @Autowired
    private UserService userService;

    /**
     * 
     * @param model
     * @param params
     *               startLocation | endLocation | busId | fromPrice | toPrice |
     *               driverId | timeFrom | timeTo
     * @return
     */
    @RequestMapping("/trips")
    public String index(Model model, @RequestParam Map<String, String> params) {
        List<Trip> list = tripService.getList(params);
        model.addAttribute("trips", list);

        return "trips";
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    /**
     * 
     * @param model
     * @param id    = 0 | ...
     * @return
     */
    private String addOrEditForm(Model model, int id) {
        Trip trip = id == 0 ? new Trip() : tripService.getById(id);
        model.addAttribute("trip", trip);

        Map<String, String> params = new HashMap<>();
        params.put("orderBy", "startLocation");
        params.put("orderByAlt", "endLocation");
        params.put("order", "asc");
        List<Route> routes = routeService.getList(params);
        model.addAttribute("routes", routes);

        Map<String, String> busParams = new HashMap<>();
        busParams.put("getSeats", "");
        List<Bus> busList = busService.getList(busParams);
        model.addAttribute("buses", busList);

        Map<String, String> userParams = new HashMap<>();
        userParams.put("roleId", "3");
        List<User> drivers = userService.getUsers(userParams);
        model.addAttribute("drivers", drivers);

        return "trips.addOrUpdate";
    }

    @GetMapping("/trips/add")
    public String addForm(Model model) {
        return addOrEditForm(model, 0);
    }

    @GetMapping("/trips/edit/{id}")
    public String editForm(Model model, @PathVariable(value = "id") int id) {
        return addOrEditForm(model, id);
    }

    @PostMapping(value = "/trips/add")
    public String addOrUpdate(@ModelAttribute(value = "trip") @Valid Trip item,
            BindingResult rs) {
        if (!rs.hasErrors()) {
            if (tripService.add(item)) {
                return "redirect:/trips";
            }
        }

        return "trips.addOrUpdate";
    }

    @GetMapping("/trips/{id}")
    public String detailForm(Model model, @PathVariable(value = "id") int id) {
        Trip item = tripService.getById(id);
        BusSeats busSeats = busSeatTripService.getBusSeats(item.getBusId().getId(), item.getId());
        int count = busSeatTripService.countSeatById(item.getBusId().getId(), item.getId());

        model.addAttribute("trip", item);
        model.addAttribute("seats", busSeats);
        model.addAttribute("seatCount", count);

        return "trips.detail";
    }

    @GetMapping("/trips/find")
    public String findForm(Model model) {
        List<Route> routesStart = routeService.getListStart();
        model.addAttribute("routesStart", routesStart);

        List<Route> routesEnd = routeService.getListEnd();
        model.addAttribute("routesEnd", routesEnd);

        Map<String, String> busParams = new HashMap<>();
        busParams.put("getSeats", "");
        List<Bus> busList = busService.getList(busParams);
        model.addAttribute("buses", busList);

        Map<String, String> userParams = new HashMap<>();
        userParams.put("roleId", "3");
        List<User> drivers = userService.getUsers(userParams);
        model.addAttribute("drivers", drivers);

        model.addAttribute("fromPrice", 0);

        int hightestPrice = tripService.getHightestPrice();
        int toPrice = (int) Math.floor((0.0 + hightestPrice) / 1000) * 1000;
        model.addAttribute("toPrice", toPrice);

        return "trips.find";
    }
    

}
