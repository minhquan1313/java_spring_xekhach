package com.mtb.repository;

import java.util.List;

import com.mtb.myObject.BusSeats;
import com.mtb.pojo.BusSeatTemplate;

public interface BusSeatTemplateRepository {
    BusSeats getBusSeatsByBusId(int id);

    List<BusSeatTemplate> getListByBusId(int busId);

    boolean makeMultipleSeatTemplate(List<BusSeatTemplate> list);

    boolean delMultipleSeatTemplateByBusId(int busId);

    int countSeatByBusId(int id);
}
