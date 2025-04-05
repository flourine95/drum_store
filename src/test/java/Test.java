import com.drumstore.web.repositories.PermissionRepository;

public class Test {
    public static void main(String[] args) {
        System.out.println(new PermissionRepository().createPermission("permissions:create", "description"));
    }

}