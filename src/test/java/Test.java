import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        // Giả sử bạn có danh sách các giá trị từ form
        List<String> imageOrder = Arrays.asList(
                "img_1743561736959_5",
                "img_1743561736960_1",
                "img_1743561736961_3",
                "img_1743561736962_2",
                "img_1743561736962_1",
                "img_1743561736964_5"
        );

        // Sắp xếp theo index (tách lấy phần cuối của chuỗi và chuyển sang int để sắp xếp)
        List<String> sortedImages = imageOrder.stream()
                .sorted(Comparator.comparingInt(image -> Integer.parseInt(image.split("_")[2]))) // Lấy phần index để sắp xếp
                .toList();

        // In kết quả đã được sắp xếp
        sortedImages.forEach(System.out::println);
    }

}