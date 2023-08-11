/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.repository;

import com.mtb.pojo.Feedback;
import com.mtb.pojo.Ticket;
import java.util.List;
import java.util.Map;


/**
 *
 * @author Duc Hung
 */
public interface FeedbackRepository {
    List<Feedback> getFeedbacks(Map<String, String> params);
    List<Feedback> getFeedbacksForTrip(Map<String, String> params,String id);
    boolean addOrUpdateFeedback(Feedback f);
    Feedback getFeedbackById(int id);
    boolean deleteFeedback(int id);
}
