package com.drumstore.web.tags;

import com.drumstore.web.models.User;
import com.drumstore.web.services.UserService;
import jakarta.servlet.jsp.tagext.TagSupport;

public class SecurityTag extends TagSupport {
    private String permission;
    private static final UserService userService = new UserService();

    public void setPermission(String permission) {
        this.permission = permission;
    }

    @Override
    public int doStartTag() {
        try {
            Object user = pageContext.getSession().getAttribute("user");
            if (user != null) {
                int userId = ((User) user).getId();
                if (userService.hasPermission(userId, permission)) {
                    return EVAL_BODY_INCLUDE;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SKIP_BODY;
    }
}
