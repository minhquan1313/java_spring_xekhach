/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mtb.service.impl;

import com.mtb.pojo.Feedback;
import com.mtb.repository.FeedbackRepository;
import com.mtb.service.FeedbackService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Duc Hung
 */
@Service
public class FeedbackServiceImpl implements FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;

    @Override
    public List<Feedback> getFeedbacks(Map<String, String> params) {
        return this.feedbackRepository.getFeedbacks(params);
    }

    @Override
    public Feedback getFeedbackById(int id) {
        return this.feedbackRepository.getFeedbackById(id);
    }

    @Override
    public boolean addOrUpdateFeedback(Feedback f) {
        return this.feedbackRepository.addOrUpdateFeedback(f);
    }

    @Override
    public boolean deleteFeedback(int id) {
        return this.feedbackRepository.deleteFeedback(id);
    }

    @Override
    public List<Feedback> getFeedbacksForTrip(Map<String, String> params, String id) {
          return this.feedbackRepository.getFeedbacksForTrip(params,id);
    }
}
