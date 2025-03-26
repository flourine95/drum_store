package com.drumstore.web.dto;


public class RegisterRequestDTO {
    private String fullname;
    private String phone;
    private String email;
    private String password;

    public RegisterRequestDTO(String fullname, String phone, String email, String password) {
        this.fullname = fullname;
        this.phone = phone;
        this.email = email;
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }
}

