/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.mtb.repository;

import com.lowagie.text.DocumentException;
import com.lowagie.text.pdf.codec.Base64.OutputStream;
import com.mtb.pojo.User;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Duc Hung
 */
public interface UserRepository {
    List<User> getUsers(Map<String, String> params);
    List<User> searchUsers(Map<String, String> params,String id, String kw, String role);
    int countUser();
    boolean addOrUpdateUser(User u);
    User getUserById(int id);
    boolean deleteUser(int id);
}
