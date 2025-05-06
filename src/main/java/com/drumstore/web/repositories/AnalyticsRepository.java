package com.drumstore.web.repositories;

import com.drumstore.web.dto.MonthlyRevenueDTO;
import com.drumstore.web.utils.DBConnection;
import org.jdbi.v3.core.Jdbi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Repository class responsible for querying analytics-related data
 * such as revenue, profit, order statistics, product sales, etc.
 */
public class AnalyticsRepository {
    private final Jdbi jdbi;

    public AnalyticsRepository() {
        this.jdbi = DBConnection.getJdbi();
    }

    public List<MonthlyRevenueDTO> getMonthlyRevenueAndProfit(int year) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
            SELECT 
                MONTH(o.orderDate) AS month,
                SUM(totalAmount) AS revenue
            FROM 
                orders o
            WHERE 
                YEAR(o.orderDate) = :year
                AND o.status IN (1, 2)
            GROUP BY 
                MONTH(o.orderDate)
            ORDER BY 
                month
        """)
                        .bind("year", year)
                        .map((rs, ctx) -> {
                            MonthlyRevenueDTO result = new MonthlyRevenueDTO();
                            result.setMonth(rs.getInt("month"));
                            double revenue = rs.getDouble("revenue");
                            result.setRevenue(revenue);
                            result.setProfit(revenue * 0.6);
                            return result;
                        })
                        .list()
        );
    }

    public Map<String, Object> getCustomerStats() {
        return jdbi.withHandle(handle -> {
            /**
             * hard code real time, refactor when update database
             */
            String currentMonth = "2024-06-01";
            String previousMonth = "2024-05-01";

            int currentMonthCustomers = handle.createQuery(
                            "SELECT COUNT(*) FROM users WHERE DATE_FORMAT(createdAt, '%Y-%m-01') =:currentMonth "
                    )
                    .bind("currentMonth", currentMonth)
                    .mapTo(Integer.class)
                    .findOnly();

            int previousMonthCustomers = handle.createQuery(
                            "SELECT COUNT(*) FROM users WHERE DATE_FORMAT(createdAt, '%Y-%m-01') = :previousMonth "
                    )
                    .bind("previousMonth", previousMonth)
                    .mapTo(Integer.class)
                    .findOnly();

            double growthRate = 0.0;
            if (previousMonthCustomers == 0) {
                growthRate = (currentMonthCustomers > 0) ? 100.0 : 0.0;
            } else {
                growthRate = ((double) (currentMonthCustomers - previousMonthCustomers) / previousMonthCustomers) * 100;
            }

            Map<String, Object> stats = new HashMap<>();
            stats.put("currentMonthCustomers", currentMonthCustomers);
            stats.put("previousMonthCustomers", previousMonthCustomers);
            stats.put("growthRate", growthRate);
            return stats;
        });
    }

    public Map<String, Object> getRevenueStats() {
        return jdbi.withHandle(handle -> {

            /**
             * hard code real time, refactor when update database
             */
            String currentMonth = "2024-06-01";
            String previousMonth = "2024-05-01";

            double currentMonthRevenue = handle.createQuery(
                            "SELECT SUM(totalAmount) FROM orders WHERE DATE_FORMAT(orderDate, '%Y-%m-01') = :currentMonth"
                    )
                    .bind("currentMonth", currentMonth)
                    .mapTo(Double.class)
                    .findOne()
                    .orElse(0.0);


            double previousMonthRevenue = handle.createQuery(
                            "SELECT SUM(totalAmount) FROM orders WHERE DATE_FORMAT(orderDate, '%Y-%m-01') = :previousMonth"
                    )
                    .bind("previousMonth", previousMonth)
                    .mapTo(Double.class)
                    .findOne()
                    .orElse(0.0);


            double growthRate = 0.0;
            if (previousMonthRevenue == 0) {
                growthRate = (currentMonthRevenue > 0) ? 100.0 : 0.0;
            } else {
                growthRate = ((currentMonthRevenue - previousMonthRevenue) / previousMonthRevenue) * 100;
            }

            Map<String, Object> stats = new HashMap<>();
            stats.put("currentMonthRevenue", currentMonthRevenue);
            stats.put("previousMonthRevenue", previousMonthRevenue);
            stats.put("growthRate", growthRate);
            return stats;
        });
    }

    public Map<String, Object> getOrderStats() {
        return jdbi.withHandle(handle -> {
            /**
             * Hard code real time, refactor when update database
             */
            String currentMonth = "2024-06-01";
            String previousMonth = "2024-05-01";

            int currentMonthOrders = handle.createQuery(
                            "SELECT COUNT(*) FROM orders WHERE DATE_FORMAT(orderDate, '%Y-%m-01') = :currentMonth"
                    )
                    .bind("currentMonth", currentMonth)
                    .mapTo(Integer.class)
                    .findOnly();

            int previousMonthOrders = handle.createQuery(
                            "SELECT COUNT(*) FROM orders WHERE DATE_FORMAT(orderDate, '%Y-%m-01') = :previousMonth"
                    )
                    .bind("previousMonth", previousMonth)
                    .mapTo(Integer.class)
                    .findOnly();


            double growthRate = 0.0;
            if (previousMonthOrders == 0) {
                growthRate = (currentMonthOrders > 0) ? 100.0 : 0.0;
            } else {
                growthRate = ((double) (currentMonthOrders - previousMonthOrders) / previousMonthOrders) * 100;
            }


            Map<String, Object> stats = new HashMap<>();
            stats.put("currentMonthOrders", currentMonthOrders);
            stats.put("previousMonthOrders", previousMonthOrders);
            stats.put("growthRate", growthRate);
            return stats;
        });
    }

    public Map<String, Object> getGrowthStats() {
        Map<String, Object> customerStats = getCustomerStats();
        Map<String, Object> revenueStats = getRevenueStats();
        Map<String, Object> orderStats = getOrderStats();

        double growthRateCustomers = (double) customerStats.get("growthRate");
        double growthRateRevenue = (double) revenueStats.get("growthRate");
        double growthRateOrders = (double) orderStats.get("growthRate");

        // Tính tăng trưởng tổng hợp (trung bình các tỷ lệ tăng trưởng)
        double currentMonthGrowth = (growthRateCustomers + growthRateRevenue + growthRateOrders) / 3.0;

        double previousMonthGrowth = 0.0;
        double growthRate = (previousMonthGrowth == 0) ? (currentMonthGrowth > 0 ? 100.0 : 0.0) : ((currentMonthGrowth - previousMonthGrowth) / previousMonthGrowth) * 100;

        Map<String, Object> stats = new HashMap<>();
        stats.put("currentMonthGrowth", currentMonthGrowth);
        stats.put("previousMonthGrowth", previousMonthGrowth);
        stats.put("growthRate", growthRate);
        return stats;
    }

}
