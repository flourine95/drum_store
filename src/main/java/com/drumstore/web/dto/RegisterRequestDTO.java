package com.drumstore.web.dto;


import com.drumstore.web.models.User;

public class RegisterRequestDTO {
    private String fullname;
    private String email;
    private String phone;
    private String password;
    private String confirmPassword;

    public RegisterRequestDTO(String fullname, String email, String phone, String password, String confirmPassword) {
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.confirmPassword = confirmPassword;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public User toModel() {
        return new User(fullname, email, phone, password);
    }
}

