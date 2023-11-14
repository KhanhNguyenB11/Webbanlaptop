/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.devpro.controller.users;

/**
 *
 * @author ASUS
 */
public class GenericResponse {

    private String message;
    private String error;

    public GenericResponse(String message) {
        super();
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public GenericResponse(String message, String error) {
        super();
        this.message = message;
        this.error = error;
    }
}
