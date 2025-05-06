package com.drumstore.web.services;

import com.drumstore.web.dto.MonthlyRevenueDTO;
import com.drumstore.web.repositories.AnalyticsRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AnalyticsService {
    private final AnalyticsRepository analyticsRepository = new AnalyticsRepository();

   public  List<MonthlyRevenueDTO> getMonthlyRevenueAndProfit(int year){
        return analyticsRepository.getMonthlyRevenueAndProfit(year);
    }

    public Map<String, Object> getCustomerStats(){
       return analyticsRepository.getCustomerStats();
    }

    public Map<String, Object> getRevenueStats(){
        return analyticsRepository.getRevenueStats();
    }

    public Map<String, Object> getOrderStats(){
        return analyticsRepository.getOrderStats();
    }

    public Map<String, Object> getGrowthStats(){
        return analyticsRepository.getGrowthStats();
    }
    public List<Map<String, Object>> getBestSellingProducts(){
       return analyticsRepository.getBestSellingProducts();
    }

    public Map<String, List<Map<String, Object>>> getRevenueByCategoryAndBrand() {
        Map<String, List<Map<String, Object>>> result = new HashMap<>();
        result.put("categories", analyticsRepository.getRevenueByCategory());
        result.put("brands", analyticsRepository.getRevenueByBrand());
        return result;
    }
}
