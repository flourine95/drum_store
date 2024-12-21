package com.drumstore.web.services;

import com.drumstore.web.models.District;
import com.drumstore.web.models.Province;
import com.drumstore.web.models.Ward;
import com.drumstore.web.repositories.DistrictRepository;
import com.drumstore.web.repositories.ProvinceRepository;
import com.drumstore.web.repositories.WardRepository;

import java.util.List;

public class LocationService {
    private ProvinceRepository provinceRepository;
    private DistrictRepository districtRepository;
    private WardRepository wardRepository;

    public LocationService(ProvinceRepository provinceRepository, DistrictRepository districtRepository, WardRepository wardRepository) {
        this.provinceRepository = provinceRepository;
        this.districtRepository = districtRepository;
        this.wardRepository = wardRepository;
    }

    public List<Province> getAllProvinces() {
        return provinceRepository.getAllProvinces();
    }

    public List<District> getDistrictsByProvinceId(int provinceId) {
        return districtRepository.getDistrictsByProvinceId(provinceId);
    }

    public List<Ward> getWardsByDistrictId(int districtId) {
        return wardRepository.getWardsByDistrictId(districtId);
    }
}
