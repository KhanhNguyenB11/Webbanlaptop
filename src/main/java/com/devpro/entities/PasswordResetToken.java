/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.devpro.entities;

import java.util.Date;
import javax.persistence.*;

/**
 *
 * @author ASUS
 */
@Entity
@Table(name = "tbl_passwordresettokens")
public class PasswordResetToken extends BaseEntity{

    public PasswordResetToken(String token, User user) {
        this.token = token;
        this.user = user;
    }
 
    private static final int EXPIRATION = 60 * 24;
 
   @Column(name = "token", nullable = true)
    private String token;
 
    @OneToOne(targetEntity = User.class, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "user_id")
    private User user;
 
    @Column(name = "expirydate", nullable = true)
    private Date expiryDate;
}