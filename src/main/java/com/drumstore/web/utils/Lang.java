package com.drumstore.web.utils;

import lombok.experimental.UtilityClass;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Random;

@UtilityClass
public class Lang {

    public static <T> T coalesce(T value, T fallback) {
        return value != null ? value : fallback;
    }

    public static void echo(String message) {
        System.out.print(message);
    }

    public static void println(String message) {
        System.out.println(message);
    }

    public static boolean isNullOrEmpty(String str) {
        return str == null || str.isEmpty();
    }

    public static boolean isNullOrBlank(String str) {
        return str == null || str.trim().isEmpty();
    }

    public static String strCapitalize(String s) {
        if (isNullOrEmpty(s)) return s;
        return s.substring(0, 1).toUpperCase() + s.substring(1);
    }

    public static String repeat(String s, int count) {
        return s.repeat(count);
    }

    public static String join(List<String> list, String delimiter) {
        return String.join(delimiter, list);
    }

    public static String randomString(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(RANDOM.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public static String now() {
        return ZonedDateTime.now().toString();
    }

}
