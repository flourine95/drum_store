package com.drumstore.web.repositories;

import com.drumstore.web.dto.CategoryDTO;
import com.drumstore.web.dto.LogDTO;
import com.drumstore.web.models.Log;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class LogRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<Log> all() {
        System.out.println();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM logs order by id desc")
                        .mapToBean(Log.class)
                        .list()
        );
    }

    public void create(LogDTO log) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("INSERT INTO logs VALUES (:id, :userId, :action, :oldData, :newData, :timestamp)")
                    .bindBean(log)
                    .execute();
        });
    }

    public LogDTO findById(Integer id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM logs WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(LogDTO.class)
                        .findFirst()
                        .orElse(null)
        );
    }

//    public void update(LogDTO log) {
//        jdbi.useHandle(handle -> {
//            handle.createUpdate("UPDATE logs SET name = :name, description = :description, image = :image WHERE id = :id")
//                    .bindBean(log)
//                    .execute();
//        });
//    }

    public void delete(Integer id) {
        jdbi.useHandle(handle -> {
            handle.createUpdate("DELETE FROM logs WHERE id = :id")
                    .bind("id", id)
                    .execute();
        });
    }
}
