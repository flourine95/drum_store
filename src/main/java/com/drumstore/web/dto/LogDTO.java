package com.drumstore.web.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LogDTO implements Serializable {
    private int id;
    private int userId;
    private String action;
    private String oldData;
    private String newData;
    private Timestamp timestamp;
}
