//package com.drumstore.web.repositories;
//
//import com.drumstore.web.dto.UserDTO;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpSession;
//
//import java.util.Set;
//
//public class AuthorizationService {
//    private final UserRepository userRepository;
//    private final RoleRepository roleRepository;
//    private final PermissionRepository permissionRepository;
//
//    public AuthorizationService() {
//        this.userRepository = new UserRepository();
//        this.roleRepository = new RoleRepository();
//        this.permissionRepository = new PermissionRepository();
//    }
//
//    public boolean hasPermission(int userId, String permissionName) {
//        return userRepository.hasPermission(userId, permissionName);
//    }
//
//    public boolean hasRole(int userId, String roleName) {
//        Set<String> roles = roleRepository.getRoleNamesByUserId(userId);
//        return roles.contains(roleName);
//    }
//
//    public UserDTO getUserWithRolesAndPermissions(int userId) {
//        return userRepository.find2(userId);
//    }
//
//    public UserDTO getCurrentUserDTO(HttpServletRequest request) {
//        HttpSession session = request.getSession(false);
//        if (session == null) {
//            return null;
//        }
//
//        // Try to get from session first
//        UserDTO userDTO = (UserDTO) session.getAttribute("userDTO");
//        if (userDTO != null) {
//            return userDTO;
//        }
//
//        // If not in session, get user and load roles/permissions
//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            return null;
//        }
//
//        userDTO = getUserWithRolesAndPermissions(user.getId());
//        // Cache in session
//        session.setAttribute("userDTO", userDTO);
//        return userDTO;
//    }
//}
