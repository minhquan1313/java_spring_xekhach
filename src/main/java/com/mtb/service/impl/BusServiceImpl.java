package com.mtb.service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.mtb.pojo.Bus;
import com.mtb.repository.BusRepository;
import com.mtb.service.BusService;

@Service
public class BusServiceImpl implements BusService {

    @Autowired
    BusRepository busRepository;

    @Autowired
    private Cloudinary cloudinary;

    @Override
    public List<Bus> getList(Map<String, String> params) {
        return busRepository.getList(params);
    }

    @Override
    public Bus getById(int id) {
        return busRepository.getById(id);
    }

    @Override
    public boolean addOrUpdate(Bus item) {
        if (item.getFile() != null && !item.getFile().isEmpty()) {
            try {
                Map res = this.cloudinary
                        .uploader()
                        .upload(item.getFile().getBytes(), ObjectUtils.asMap("resource_type", "auto"));

                item.setImage(res.get("secure_url").toString());
            } catch (IOException ex) {
                Logger.getLogger(BusServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return busRepository.addOrUpdate(item);
    }

    @Override
    public boolean deleteById(int id) {
        return busRepository.deleteById(id);
    }

    @Override
    public int countSeat(int id) {
        return busRepository.countSeat(id);
    }
}
