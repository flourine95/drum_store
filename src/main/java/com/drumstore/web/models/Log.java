package com.drumstore.web.models;

import java.sql.Timestamp;

public class Log {
    private int id;
    private int userId;
    private int level;
    private String action;
    private String oldData;
    private String newData;
    private Timestamp timestamp;

    public Log(int id, int userId, int level, String action, String oldData, String newData, Timestamp timestamp) {
        this.id = id;
        this.userId = userId;
        this.level = level;
        this.action = action;
        this.oldData = oldData;
        this.newData = newData;
        this.timestamp = timestamp;
    }


    public Log() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getOldData() {
        return oldData;
    }

    public void setOldData(String oldData) {
        this.oldData = oldData;
    }

    public String getNewData() {
        return newData;
    }

    public void setNewData(String newData) {
        this.newData = newData;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", userId=" + userId +
                ", action='" + action + '\'' +
                ", oldData='" + oldData + '\'' +
                ", newData='" + newData + '\'' +
                ", timestamp=" + timestamp +
                '}';
    }

}
