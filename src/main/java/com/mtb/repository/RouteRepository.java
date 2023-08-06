package com.mtb.repository;

import java.util.List;
import java.util.Map;

import com.mtb.pojo.Route;

public interface RouteRepository {
    List<Route> getList(Map<String, String> params);

    Route getById(int id);

    List<Route> getListStart();

    List<Route> getListEnd();

    boolean addOrUpdate(Route item);

    boolean deleteById(int id);
}
