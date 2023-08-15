package com.mtb.service;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.Route;

public interface RouteService {
    /**
     * 
     * @param params
     *               end_location:string
     *               start_location: string
     *               orderBy : string #
     *               orderByAlt : string #
     *               order : asc | desc #
     * @return
     */
    List<Route> getList(Map<String, String> params);

    Route getById(int id);

    List<Route> getListStart();

    List<Route> getListEnd();

    boolean addOrUpdate(Route item);

    boolean deleteById(int id);
}
