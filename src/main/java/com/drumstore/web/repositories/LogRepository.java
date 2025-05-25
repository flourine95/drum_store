package com.drumstore.web.repositories;

import com.drumstore.web.dto.CategoryDTO;
import com.drumstore.web.dto.LogDTO;
import com.drumstore.web.models.Log;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class LogRepository {
    private final Jdbi jdbi = DBConnection.getJdbi();

    public List<LogDTO> all() {
        System.out.println();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT l.id, " +
                                "l.userId," +
                                "concat(l.userId, '_', u.fullname) as userName, " +
                                "l.level, " +
                                "l.action, " +
                                "l.oldData, " +
                                "l.newData, " +
                                "l.timestamp FROM logs l left join users u on l.userId = u.id  " +
                                "order by l.id desc")
                        .mapToBean(LogDTO.class)
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
                handle.createQuery("SELECT l.id, " +
                                "l.userId," +
                                "concat(l.userId, '_', u.fullname) as userName, " +
                                "l.level, " +
                                "l.action, " +
                                "l.oldData, " +
                                "l.newData, " +
                                "l.timestamp FROM logs l left join users u on l.userId = u.id  " +
                                " WHERE l.id = :id")
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
