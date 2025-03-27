import com.drumstore.web.repositories.ProductRepository;
import com.drumstore.web.repositories.UserRepository;

public class Test {
    public static void main(String[] args) {
//        System.out.println(new ProductRepository().findById(2));
        System.out.println(new UserRepository().findUser("email", "ntluc1974@gmail.com"));
    }
}