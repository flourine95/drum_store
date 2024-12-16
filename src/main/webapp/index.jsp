<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Drum Store</title>
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@400;600&display=swap"
            rel="stylesheet">
    <link rel="icon" href="assets/images/logos/logo.png" type="image/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="assets/css/custom.css">
    <link rel="stylesheet" type="text/css" href="assets/css/header-footer.css">
</head>

<body>
<jsp:include page="includes/header.html"/>

<main>
    <div id="carouselExampleIndicators" class="carousel slide">
        <div class="carousel-indicators" id="carouselIndicators"></div>
        <div class="carousel-inner" id="carouselItems"></div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-3 mb-4">
                <div class="custom-box h-100 text-decoration-none">
                    <div class="me-3 fs-1">
                        <i class="bi bi-credit-card"></i>
                    </div>
                    <div class="text-start">
                        <h5 class="fs-5 fw-medium">Trả góp</h5>
                        <p class="fs-6 text-muted mt-2">Mua hàng với lãi suất 0%</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="custom-box h-100 text-decoration-none">
                    <div class="me-3 fs-1">
                        <i class="bi bi-truck"></i>
                    </div>
                    <div class="text-start">
                        <h5 class="fs-5 fw-medium">Vận chuyển</h5>
                        <p class="fs-6 text-muted mt-2">Chuyên nghiệp - Tốc độ</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="custom-box h-100 text-decoration-none">
                    <div class="me-3 fs-1">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <div class="text-start">
                        <h5 class="fs-5 fw-medium">Bảo hành</h5>
                        <p class="fs-6 text-muted mt-2">Hiệu quả - Chất lượng</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="custom-box h-100 text-decoration-none">
                    <div class="me-3 fs-1">
                        <i class="bi bi-shop"></i>
                    </div>
                    <div class="text-start">
                        <h5 class="fs-5 fw-medium">Đại lý</h5>
                        <p class="fs-6 text-muted mt-2">Trải rộng khắp Việt Nam</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- Featured Products-->
    <div class="container mt-5">
        <h2 class="text-start mb-4">SẢN PHẨM NỔI BẬT</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4" id="featuredProducts"></div>
    </div>
    <!-- Instruments -->
    <div class="container mt-5">
        <h2 class="text-start mb-4">DANH MỤC SẢN PHẨM</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4" id="categories"></div>
    </div>

    <!-- Posts-->
    <div class="container mt-5">
        <h2 class="text-start mb-4">TIN TỨC - SỰ KIỆN</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4" id="posts"></div>
    </div>

    <section id="about" class="py-5 bg-primary mt-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <img src="assets/images/helpers/about.jpg" class="img-fluid rounded shadow" alt="About Us">
                </div>
                <div class="col-md-6">
                    <h2 class="mb-4">VỀ CHÚNG TÔI</h2>
                    <p>Drum Store tự hào là đơn vị hàng đầu trong lĩnh vực cung cấp nhạc cụ trống tại Việt Nam. Với
                        hơn
                        20 năm kinh nghiệm, chúng tôi cam kết mang đến những sản phẩm chất lượng nhất từ các thương
                        hiệu
                        uy tín trên thế giới.</p>
                    <ul class="list-unstyled">
                        <li class="mb-2">✓ 100% sản phẩm chính hãng</li>
                        <li class="mb-2">✓ Đội ngũ tư vấn chuyên nghiệp</li>
                        <li class="mb-2">✓ Chế độ bảo hành tốt nhất</li>
                        <li class="mb-2">✓ Giao hàng toàn quốc</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
</main>
<jsp:include page="includes/footer.html"/>

<script>
    const adjustDesktopPadding = () => {
        if (window.innerWidth >= 992) {
            const header = document.querySelector('.fixed-top');
            const main = document.querySelector('main');
            if (header && main) {
                const headerHeight = header.offsetHeight - 85;
                main.style.paddingTop = headerHeight + 'px';
            }
        }
    };

    // Hàm điều chỉnh padding cho mobile
    const adjustMobilePadding = () => {
        if (window.innerWidth < 992) {
            const mobileHeader = document.querySelector('.mobile-header');
            const main = document.querySelector('main');
            if (mobileHeader && main) {
                const headerHeight = mobileHeader.offsetHeight;
                document.documentElement.style.setProperty('--header-height', `${headerHeight}px`);
                main.style.paddingTop = `${headerHeight}px`;
            }
        }
    };

    const adjustLayoutPadding = () => {
        const main = document.querySelector('main');
        if (main) {
            main.style.paddingTop = '0';
        }

        if (window.innerWidth >= 992) {
            adjustDesktopPadding();
        } else {
            adjustMobilePadding();
        }
    };

    const initMobileMenu = () => {
        const menuToggle = document.getElementById('menuToggle');
        const sideMenu = document.getElementById('sideMenu');
        const menuOverlay = document.getElementById('menuOverlay');

        if (menuToggle && sideMenu && menuOverlay) {
            menuToggle.addEventListener('click', () => {
                sideMenu.classList.add('active');
                menuOverlay.classList.add('active');
                document.body.style.overflow = 'hidden';
            });

            menuOverlay.addEventListener('click', () => {
                sideMenu.classList.remove('active');
                menuOverlay.classList.remove('active');
                document.body.style.overflow = '';
            });
        }
    };

    window.addEventListener('load', () => {
        adjustLayoutPadding();
        initMobileMenu();

        const headerImages = document.querySelectorAll('header img');
        headerImages.forEach(img => {
            img.addEventListener('load', adjustLayoutPadding);
        });
    });

    window.addEventListener('resize', () => {
        adjustLayoutPadding();
    });
</script>

<!--     render elements-->
<script>
    const slides = [
        {src: "assets/images/banners/banner0.png", alt: "Slide 1"},
        {src: "assets/images/banners/banner1.png", alt: "Slide 2"},
        {src: "assets/images/banners/banner2.png", alt: "Slide 3"},
        {src: "assets/images/banners/banner3.png", alt: "Slide 4"},
        {src: "assets/images/banners/banner4.png", alt: "Slide 5"},
        {src: "assets/images/banners/banner5.png", alt: "Slide 6"},
        {src: "assets/images/banners/banner6.png", alt: "Slide 7"}
    ];
    const categories = [
        {
            title: "Trống Jazz",
            image: "assets/images/categories/images.jpg",
            description: "Khám phá các bộ trống jazz chất lượng, phù hợp cho những người yêu thích âm nhạc sôi động.",
            link: "pages/products/products.html"
        },
        {
            title: "Trống Điện Tử",
            image: "assets/images/categories/electronic-drum.webp",
            description: "Tìm hiểu những mẫu trống điện tử với tính năng vượt trội, thích hợp cho mọi không gian.",
            link: "pages/products/products.html"
        },
        {
            title: "Trống Cơ",
            image: "assets/images/categories/acoustic-drum.avif",
            description: "Khám phá các bộ trống cơ với âm thanh mạnh mẽ, được thiết kế dành cho các buổi biểu diễn chuyên nghiệp.",
            link: "pages/products/products.html"
        },
        {
            title: "Trống Bộ Pearl",
            image: "assets/images/categories/Aierai-Brand-colorful-5PCS-Set-Jazz-Drum-for-Professional.avif",
            description: "Các bộ trống Pearl chất lượng cao, mang lại âm thanh tuyệt vời và độ bền vượt trội.",
            link: "pages/products/products.html"
        },
        {
            title: "Trống Marching",
            image: "assets/images/categories/marching-drum.webp",
            description: "Khám phá các bộ trống marching phù hợp cho các đội nhạc, trường học và sự kiện.",
            link: "pages/products/products.html"
        },
        {
            title: "Phụ Kiện Trống",
            image: "assets/images/categories/drum-accessories.avif",
            description: "Các phụ kiện trống cần thiết như dùi trống, đệm trống, vỏ trống,...",
            link: "pages/products/products.html"
        }
    ];

    const featuredProducts = [
        {
            title: "Trống điện Roland TD-27KV",
            image: "assets/images/products/18757201_800.jpg",
            description: "Trống điện Roland TD-27KV với âm thanh sống động, đáp ứng nhu cầu chơi trống chuyên nghiệp.",
            originalPrice: "40,000,000 VND",
            discountedPrice: "36,000,000 VND",
            link: "pages/products/product-detail.html"
        },
        {
            title: "Trống Ludwig Breakbeats",
            image: "assets/images/products/images (1).jpg",
            description: "Trống Ludwig Breakbeats thiết kế nhỏ gọn, âm thanh mạnh mẽ, phù hợp cho những người mới bắt đầu.",
            originalPrice: "15,000,000 VND",
            discountedPrice: "13,500,000 VND",
            link: "pages/products/product-detail.html"
        },
        {
            title: "Trống điện Alesis Nitro Mesh Kit",
            image: "assets/images/products/images (2).jpg",
            description: "Trống điện Alesis Nitro Mesh Kit với bộ trống mesh đáp ứng mọi nhu cầu luyện tập và biểu diễn.",
            originalPrice: "10,000,000 VND",
            discountedPrice: "9,500,000 VND",
            link: "pages/products/product-detail.html"
        },
        {
            title: "Trống Pearl Export",
            image: "assets/images/products/images (3).jpg",
            description: "Trống Pearl Export nổi bật với thiết kế đẹp mắt, âm thanh mạnh mẽ, phù hợp cho các buổi biểu diễn.",
            originalPrice: "20,000,000 VND",
            discountedPrice: "18,000,000 VND",
            link: "pages/products/product-detail.html"
        },
        {
            title: "Trống điện Yamaha DTX6K-X",
            image: "assets/images/products/images (4).jpg",
            description: "Trống điện Yamaha DTX6K-X với chất lượng âm thanh cực kỳ chân thực, dễ sử dụng cho mọi cấp độ người chơi.",
            originalPrice: "35,000,000 VND",
            discountedPrice: "30,000,000 VND",
            link: "pages/products/product-detail.html"
        },
        {
            title: "Trống Tama Imperialstar",
            image: "assets/images/products/trong-co-ludwig-breakbeats-lc279-16101314-viet-music.webp",
            description: "Trống Tama Imperialstar với âm thanh chất lượng cao và thiết kế đẹp mắt, thích hợp cho những người yêu thích trống truyền thống.",
            originalPrice: "25,000,000 VND",
            discountedPrice: "22,500,000 VND",
            link: "pages/products/product-detail.html"
        }
    ];

    const posts = [
        {
            image: "assets/images/posts/sinh-nhat-resize-555x310-360x240.jpg",
            alt: "Sinh nhật rộn ràng",
            title: "Sinh nhật rộn ràng - Nhận ngay ưu đãi 10% tại Việt Thương Music",
            description: "Sinh nhật sắp đến, bạn đã sẵn sàng đón tuổi mới đầy ý nghĩa chưa? Hãy để Việt Thương Music đồng hành cùng bạn với chương trình khuyến mãi đặc biệt – giảm ngay 10% trên tất cả sản phẩm!",
            link: "pages/posts/post-detail.html"
        },
        {
            image: "assets/images/posts/555x3101-360x240.png",
            alt: "Pre-order đàn piano điện Casio AP-300",
            title: "Pre-order đàn piano điện Casio AP-300 và Casio AP-S200 mới nhất",
            description: "Đón đầu xu hướng âm nhạc với chương trình Pre-order đàn piano điện Casio AP-300 và Casio AP-S200 diễn ra từ ngày 22/10 đến hết 30/11/2024.",
            link: "pages/posts/post-detail.html"
        },
        {
            image: "assets/images/posts/Artboard_5-360x240.png",
            alt: "Workshop guitar: Secret of Rhythm",
            title: "Workshop guitar: Secret of Rhythm",
            description: "Workshop đệm hát cùng guitarist nổi tiếng.",
            link: "pages/posts/post-detail.html"
        },
        {
            image: "assets/images/posts/L1110399-360x240.jpg",
            alt: "Chương trình pre-order sản phẩm Boss Gx-10",
            title: "Chương trình pre-order sản phẩm Boss Gx-10",
            description: "Bạn là một guitarist đam mê và luôn tìm kiếm những công cụ âm nhạc hiện đại để nâng cao chất lượng âm thanh? Vậy thì Boss GX-10 chính là cái tên không thể bỏ qua.",
            link: "pages/posts/post-detail.html"
        },
        {
            image: "assets/images/posts/MIC-555x310-360x240.png",
            alt: "Sự kiện: Music Corner in the City",
            title: "Sự kiện: Music Corner in the City",
            description: "Vào 3 ngày 08, 09, 10/11/2024 tại Vincom Đồng Khởi, 72 Lê Thánh Tôn, phường Bến Nghé, quận 1 sẽ diễn ra sự kiện Music Corner in the City.",
            link: "pages/posts/post-detail.html"
        },
        {
            image: "assets/images/posts/RAW_0373-360x240.jpg",
            alt: "Siêu phẩm Shigeru Kawai SK-5",
            title: "Siêu phẩm Shigeru Kawai SK-5 xuất hiện trong họp báo",
            description: "Shigeru Kawai SK-5 là một trong những cây đàn grand piano hàng đầu thế giới được sản xuất bởi thương hiệu Kawai nổi tiếng của Nhật Bản.",
            link: "pages/posts/post-detail.html"
        }
    ];

    const indicatorsContainer = document.getElementById('carouselIndicators');
    const itemsContainer = document.getElementById('carouselItems');

    // Duyệt qua mảng slides và tạo các phần tử HTML
    slides.forEach((slide, index) => {
        // Tạo nút indicator
        const indicatorButton = document.createElement('button');
        indicatorButton.type = 'button';
        indicatorButton.classList.add('carousel-indicator');
        indicatorButton.setAttribute('data-bs-target', 'pages/posts/post-detail.htmlcarouselExampleIndicators');
        indicatorButton.setAttribute('data-bs-slide-to', index);
        indicatorButton.setAttribute('aria-label', `Slide \${index + 1}`);
        if (index === 0) indicatorButton.classList.add('active'); // Đánh dấu slide đầu tiên là active
        indicatorsContainer.appendChild(indicatorButton);

        // Tạo slide item
        const slideItem = document.createElement('div');
        slideItem.classList.add('carousel-item');
        if (index === 0) slideItem.classList.add('active'); // Đánh dấu slide đầu tiên là active

        const img = document.createElement('img');
        img.src = slide.src;
        img.classList.add('d-block', 'w-100');
        img.alt = slide.alt;
        slideItem.appendChild(img);

        itemsContainer.appendChild(slideItem);
    });


    const container = document.querySelector('#categories');

    categories.forEach(instrument => {
        const card = `
        <div class="col">
            <div class="card h-100">
                <img src="\${instrument.image}" class="card-img-top" alt="\${instrument.title}">
                <div class="card-body">
                    <h5 class="card-title">\${instrument.title}</h5>
                    <p class="card-text">\${instrument.description}</p>
                    <a href="\${instrument.link}" class="btn btn-primary text-black mt-auto">Xem thêm</a>
                </div>
            </div>
        </div>
    `;
        container.innerHTML += card;
    });


    const productContainer = document.querySelector("#featuredProducts");

    featuredProducts.forEach(product => {
        const productCol = document.createElement("div");
        productCol.className = "col";

        productCol.innerHTML = `
            <div class="card h-100">
                <img src="\${product.image}" class="card-img-top" alt="\${product.alt}">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><a href="\${product.link}" class="text-decoration-none">\${product.title}</a></h5>
                    <p class="card-text">\${product.description}</p>
                    <p class="card-text"><span style="text-decoration: line-through;">\${product.originalPrice}</span> <strong class="text-danger">\${product.discountedPrice}</strong></p>
                    <a href="\${product.link}" class="btn btn-primary text-black mt-auto">Xem thêm</a>
                </div>
            </div>
        `;

        productContainer.appendChild(productCol);
    });


    const postsContainer = document.querySelector("#posts");

    posts.forEach(post => {
        const postElement = document.createElement("div");
        postElement.classList.add("col");

        postElement.innerHTML = `
            <div class="card h-100">
                <img src="\${post.image}" class="card-img-top" alt="\${post.alt}">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">\${post.title}</h5>
                    <p class="card-text">\${post.description}</p>
                    <a href="\${post.link}" class="btn btn-primary mt-auto w-100 text-black">Xem chi tiết</a>
                </div>
            </div>
        `;

        postsContainer.appendChild(postElement);
    });
</script>
</body>

</html>
