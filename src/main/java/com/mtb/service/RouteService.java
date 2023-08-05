package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.Route;

public interface RouteService {
    /**
     * 
     * @param params
     *               orderBy : string #
     *               orderByAlt : string #
     *               order : asc | desc #
     * @return
     */
    List<Route> getList(Map<String, String> params);

    Route getById(int id);

    boolean addOrUpdate(Route item);

    boolean deleteById(int id);
}
