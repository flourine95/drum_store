package com.drumstore.web.utils;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.Reader;
import java.lang.reflect.Type;

public class GsonUtils {
    private static final Gson gson = new Gson();
    
    public static JsonObject fromJson(Reader reader) {
        return gson.fromJson(reader, JsonObject.class);
    }
    
    public static <T> T fromJson(Reader reader, Class<T> classOfT) {
        return gson.fromJson(reader, classOfT);
    }
    
    public static <T> T fromJson(String json, Class<T> classOfT) {
        return gson.fromJson(json, classOfT);
    }
    
    public static String toJson(Object src) {
        return gson.toJson(src);
    }

    public static <T> T fromJson(String json, Type typeOfT) {
        return gson.fromJson(json, typeOfT);
    }
} 