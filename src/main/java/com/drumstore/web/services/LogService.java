package com.drumstore.web.services;

import com.drumstore.web.dto.LogDTO;
import com.drumstore.web.models.Log;
import com.drumstore.web.repositories.LogRepository;

import java.util.List;

public class LogService {
    private final LogRepository logRepository = new LogRepository();

    public List<Log> all() {
        return logRepository.all();
    }
    public void create(LogDTO log) {
        logRepository.create(log);
    }
    public LogDTO findById(Integer id) {
        return logRepository.findById(id);
    }
//    public void update(LogDTO log) {
//        logRepository.update(log);
//    }
    public void delete(Integer id) {
        logRepository.delete(id);
    }
}
