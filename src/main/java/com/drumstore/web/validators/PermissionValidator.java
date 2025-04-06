package com.drumstore.web.validators;

import com.drumstore.web.dto.PermissionDTO;

import java.util.HashMap;
import java.util.Map;

public class PermissionValidator {
    public Map<String, String> validate(PermissionDTO permissionRequest) {
        Map<String, String> errors = new HashMap<>();

        if (permissionRequest.getName() == null || permissionRequest.getName().isEmpty()) {
            errors.put("name", "Permission name is required.");
        } else if (permissionRequest.getName().length() < 3) {
            errors.put("name", "Permission name must be at least 3 characters long.");
        }

        if (permissionRequest.getDescription() == null || permissionRequest.getDescription().isEmpty()) {
            errors.put("description", "Permission description is required.");
        } else if (permissionRequest.getDescription().length() < 5) {
            errors.put("description", "Permission description must be at least 5 characters long.");
        }

        return errors;
    }
}
