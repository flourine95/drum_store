package com.drumstore.web.utils;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.io.Serializable;


@Data
@AllArgsConstructor
@Builder
public class OperationResult<T> implements Serializable {
    private final boolean success;
    private final String message;
    private final T data;

    public static <T> OperationResult<T> success(String message, T data) {
        return OperationResult.<T>builder()
                .success(true)
                .message(message)
                .data(data)
                .build();
    }

    public static <T> OperationResult<T> success(String message) {
        return OperationResult.<T>builder()
                .success(true)
                .message(message)
                .build();
    }

    public static <T> OperationResult<T> failure(String message) {
        return OperationResult.<T>builder()
                .success(false)
                .message(message)
                .build();
    }
}
