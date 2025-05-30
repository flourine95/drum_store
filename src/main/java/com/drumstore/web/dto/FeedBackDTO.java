package com.drumstore.web.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeedBackDTO  {
    private int id;
    private String userName;
    private double rating;
    private String content;
    private int status;
    private String productName;
    private String imageUrl;
    private LocalDateTime createdAt;
}