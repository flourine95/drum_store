import com.drumstore.web.repositories.ProductRepository;
import com.drumstore.web.repositories.UserRepository;

import java.util.Arrays;

public class Test {
    public static void main(String[] args) {
//        System.out.println(new ProductRepository().findById(2));
//        System.out.println(new UserRepository().findUser("email", "ntluc1974@gmail.com"));
        System.out.println(Arrays.toString(getPathParts("http://localhost:8080/dashboard/products")));
    }

    public static String[] getPathParts(String pathInfo) {
        if (pathInfo == null) return new String[0];
        return pathInfo.substring(1).split("/");
    }
    public static String parsePermissionFromUrl(String requestURI) {
        // Bỏ tiền tố "/dashboard/"
        String path = requestURI.replaceFirst("^/dashboard/", "");
        String[] parts = path.split("/");

        if (parts.length == 0) return null;

        // Module là phần đầu tiên (products, orders, etc.)
        String module = parts[0];

        // Mặc định action là "list"
        String action = "index";

        // Nếu URL có nhiều phần
        if (parts.length > 1) {
            String lastPart = parts[parts.length - 1];

            if (lastPart.equalsIgnoreCase("edit")) {
                action = "edit";
            } else if (lastPart.matches("\\d+")) { // Nếu phần cuối là số
                if (parts.length > 2 && parts[parts.length - 2].equalsIgnoreCase("edit")) {
                    action = "edit";
                } else {
                    action = "show";
                }
            } else {
                action = lastPart; // Nếu không phải số thì là action trực tiếp (VD: create, delete)
            }
        }

        // Trả về định dạng module:action
        return String.format("%s:%s", module.toLowerCase(), action.toLowerCase());
    }
}