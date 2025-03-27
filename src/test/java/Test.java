import com.drumstore.web.repositories.ProductRepository;

public class Test {
    public static void main(String[] args) {
        System.out.println(new ProductRepository().findById(2));
    }
}