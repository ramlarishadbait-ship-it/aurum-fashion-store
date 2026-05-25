// lib/utils/constants.dart

class AppConstants {
  // App Info
  static const String appName = 'AURUM';
  static const String tagline = 'Wear the Extraordinary';

  // Routes
  static const String routeSplash = '/';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeHome = '/home';
  static const String routeProducts = '/products';
  static const String routeDetail = '/product-detail';
  static const String routeCart = '/cart';
  static const String routeCheckout = '/checkout';
  static const String routeProfile = '/profile';
}

// ─── Models ────────────────────────────────────────────────────

class ProductModel {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String category;
  final String imageUrl;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.sizes,
    required this.colors,
    required this.rating,
    required this.reviewCount,
    this.isNew = false,
    this.isFeatured = false,
  });
}

class CartItem {
  final ProductModel product;
  int quantity;
  String selectedSize;
  String selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.selectedSize,
    required this.selectedColor,
  });
}

class CategoryModel {
  final String name;
  final String imageUrl;
  final String label;

  const CategoryModel({
    required this.name,
    required this.imageUrl,
    required this.label,
  });
}

// ─── Dummy Data ────────────────────────────────────────────────

class DummyData {
  static const List<CategoryModel> categories = [
    CategoryModel(
      name: 'Women',
      label: 'WOMEN',
      imageUrl:
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400',
    ),
    CategoryModel(
      name: 'Men',
      label: 'MEN',
      imageUrl:
          'https://images.unsplash.com/photo-1488161628813-04466f872be2?w=400',
    ),
    CategoryModel(
      name: 'Accessories',
      label: 'ACCESSORIES',
      imageUrl:
          'https://images.unsplash.com/photo-1611085583191-a3b181a88401?w=400',
    ),
    CategoryModel(
      name: 'Shoes',
      label: 'SHOES',
      imageUrl:
          'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=400',
    ),
  ];

  static const List<ProductModel> products = [
    ProductModel(
      id: '1',
      name: 'Silk Wrap Dress',
      brand: 'AURUM',
      price: 485.00,
      category: 'Women',
      imageUrl:
          'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=600',
      description:
          'Crafted from the finest mulberry silk, this wrap dress drapes effortlessly over the body. The deep v-neckline and adjustable belt create a silhouette that is both timeless and modern.',
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      colors: ['Ivory', 'Noir', 'Champagne'],
      rating: 4.8,
      reviewCount: 124,
      isNew: true,
      isFeatured: true,
    ),
    ProductModel(
      id: '2',
      name: 'Cashmere Overcoat',
      brand: 'AURUM',
      price: 1250.00,
      category: 'Women',
      imageUrl:
          'https://images.unsplash.com/photo-1539533018447-63fcce2678e3?w=600',
      description:
          'A masterpiece of tailoring in pure Scottish cashmere. Double-breasted with horn buttons, this overcoat is an investment in enduring elegance.',
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['Camel', 'Charcoal', 'Cream'],
      rating: 4.9,
      reviewCount: 87,
      isFeatured: true,
    ),
    ProductModel(
      id: '3',
      name: 'Tailored Wool Blazer',
      brand: 'AURUM',
      price: 620.00,
      category: 'Men',
      imageUrl:
          'https://images.unsplash.com/photo-1593030761757-71fae45fa0e7?w=600',
      description:
          'Impeccably tailored from Italian wool, this blazer features hand-stitched lapels and a slim silhouette that commands attention in any room.',
      sizes: ['36', '38', '40', '42', '44'],
      colors: ['Navy', 'Charcoal', 'Midnight'],
      rating: 4.7,
      reviewCount: 63,
      isNew: true,
    ),
    ProductModel(
      id: '4',
      name: 'Leather Tote Bag',
      brand: 'AURUM',
      price: 890.00,
      category: 'Accessories',
      imageUrl:
          'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=600',
      description:
          'Hand-stitched from full-grain Italian leather, this structured tote ages beautifully over time. Gold-plated hardware and suede interior lining.',
      sizes: ['One Size'],
      colors: ['Cognac', 'Black', 'Burgundy'],
      rating: 4.9,
      reviewCount: 201,
      isFeatured: true,
    ),
    ProductModel(
      id: '5',
      name: 'Strappy Heeled Sandal',
      brand: 'AURUM',
      price: 345.00,
      category: 'Shoes',
      imageUrl:
          'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=600',
      description:
          'Delicate leather straps and a sculpted block heel make these sandals the perfect marriage of comfort and elegance.',
      sizes: ['36', '37', '38', '39', '40', '41'],
      colors: ['Nude', 'Black', 'Gold'],
      rating: 4.6,
      reviewCount: 58,
      isNew: true,
    ),
    ProductModel(
      id: '6',
      name: 'Silk Pleated Trousers',
      brand: 'AURUM',
      price: 380.00,
      category: 'Women',
      imageUrl:
          'https://images.unsplash.com/photo-1594938298603-f8d9d0c0f7a2?w=600',
      description:
          'High-waisted with elegant pleats, these silk trousers flow beautifully. An effortless piece for both day and evening.',
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      colors: ['Ivory', 'Champagne', 'Black'],
      rating: 4.7,
      reviewCount: 95,
    ),
    ProductModel(
      id: '7',
      name: 'Gold Chain Necklace',
      brand: 'AURUM',
      price: 290.00,
      category: 'Accessories',
      imageUrl:
          'https://images.unsplash.com/photo-1611085583191-a3b181a88401?w=600',
      description:
          '18K gold-plated sterling silver chain. A timeless piece that elevates any look from simple to extraordinary.',
      sizes: ['16"', '18"', '20"'],
      colors: ['Gold', 'Rose Gold', 'Silver'],
      rating: 4.8,
      reviewCount: 147,
      isFeatured: true,
    ),
    ProductModel(
      id: '8',
      name: 'Oxford Brogues',
      brand: 'AURUM',
      price: 520.00,
      category: 'Shoes',
      imageUrl:
          'https://images.unsplash.com/photo-1614252235316-8c857d38b5f4?w=600',
      description:
          'Handcrafted from burnished calfskin leather with Goodyear-welted construction for unmatched durability and comfort.',
      sizes: ['40', '41', '42', '43', '44', '45'],
      colors: ['Tan', 'Dark Brown', 'Black'],
      rating: 4.9,
      reviewCount: 78,
    ),
  ];

  static const List<String> bannerImages = [
    'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=800',
    'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800',
    'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800',
  ];
}
