import com.drumstore.web.dto.RoleDTO;
import com.drumstore.web.repositories.*;

public class Test {
    public static void main(String[] args) {
//        System.out.println(new PermissionRepository().createPermission("permissions:create", "description"));
//        System.out.println(new RoleRepository().createRole(RoleDTO.builder().name("ADMIN1").description("asd").build()));
        new ProductSaleRepository().all().forEach(System.out::println);
        System.out.println(new ProductSaleRepository().all().size());
    }

}