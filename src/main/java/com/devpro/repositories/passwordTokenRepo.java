/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.devpro.repositories;

import com.devpro.entities.PasswordResetToken;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author ASUS
 */
public interface passwordTokenRepo extends JpaRepository<PasswordResetToken,Integer>{
    
}
