package com.drumstore.web.utils;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Utility class for managing forced logouts with context awareness.
 * Tracks user IDs that need to be logged out along with the reason/context.
 */
public class ForceLogoutCache {
    // Constants for logout reasons
    public static final String REASON_USER_ROLE_CHANGE = "USER_ROLE_CHANGE";
    public static final String REASON_ROLE_PERMISSION_CHANGE = "ROLE_PERMISSION_CHANGE";
    public static final String REASON_ROLE_UPDATE = "ROLE_UPDATE";
    public static final String REASON_ROLE_DELETE = "ROLE_DELETE";
    
    // Map to store user IDs and their logout reasons
    private static Map<Integer, String> forceLogoutUserIds = new ConcurrentHashMap<>();

    /**
     * Mark a user for logout with a specific reason
     * @param userId The user ID to mark for logout
     * @param reason The reason for logout (use constants defined in this class)
     */
    public static void markForLogout(Integer userId, String reason) {
        if (userId != null) {
            forceLogoutUserIds.put(userId, reason);
        }
    }
    
    /**
     * Mark a user for logout without specifying a reason (backward compatibility)
     * @param userId The user ID to mark for logout
     */
    public static void markForLogout(Integer userId) {
        markForLogout(userId, REASON_USER_ROLE_CHANGE);
    }

    /**
     * Remove a user from the logout list
     * @param userId The user ID to remove
     */
    public static void removeFromLogout(Integer userId) {
        forceLogoutUserIds.remove(userId);
    }

    /**
     * Get all user IDs marked for logout
     * @return Set of user IDs
     */
    public static Set<Integer> all() {
        return forceLogoutUserIds.keySet();
    }

    /**
     * Check if a user should be logged out
     * @param userId The user ID to check
     * @return true if the user should be logged out
     */
    public static boolean shouldLogout(Integer userId) {
        return forceLogoutUserIds.containsKey(userId);
    }
    
    /**
     * Check if a user should be logged out for a specific reason
     * @param userId The user ID to check
     * @param reason The reason to check for
     * @return true if the user should be logged out for the specified reason
     */
    public static boolean shouldLogout(Integer userId, String reason) {
        String storedReason = forceLogoutUserIds.get(userId);
        return storedReason != null && storedReason.equals(reason);
    }
    
    /**
     * Get the reason why a user is marked for logout
     * @param userId The user ID to check
     * @return The reason string or null if user is not marked for logout
     */
    public static String getLogoutReason(Integer userId) {
        return forceLogoutUserIds.get(userId);
    }
}
