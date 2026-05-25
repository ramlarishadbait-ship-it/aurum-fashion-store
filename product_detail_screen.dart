import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import '../models/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedSize;
  String? _selectedColor;
  bool _wishlisted = false;
  final bool _descExpanded = false;
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  void _addToCart(ProductModel product) {
    if (_selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.obsidian,
          behavior: SnackBarBehavior.floating,
          content: Text('Please select a size',
              style: GoogleFonts.jost(fontSize: 13, color: AppTheme.ivory)),
        ),
      );
      return;
    }
    context.read<CartProvider>().addItem(
          product,
          _selectedSize!,
          _selectedColor ?? product.colors.first,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.obsidian,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.check, color: AppTheme.gold, size: 16),
            const SizedBox(width: 8),
            Text('Added to bag',
                style: GoogleFonts.jost(fontSize: 13, color: AppTheme.ivory)),
          ],
        ),
        action: SnackBarAction(
          label: 'VIEW BAG',
          textColor: AppTheme.gold,
          onPressed: () => Navigator.pushNamed(context, AppConstants.routeCart),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)?.settings.arguments as ProductModel? ??
            DummyData.products.first;

    return Scaffold(
      backgroundColor: AppTheme.ivory,
      body: CustomScrollView(
        slivers: [
          // ── Hero Image ─────────────────────────────────────
          SliverAppBar(
            expandedHeight: 480,
            pinned: true,
            backgroundColor: AppTheme.ivory,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.surface.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    size: 14, color: AppTheme.obsidian),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.surface.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _wishlisted ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                    color: _wishlisted ? AppTheme.errorRed : AppTheme.obsidian,
                  ),
                ),
                onPressed: () => setState(() => _wishlisted = !_wishlisted),
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.surface.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.ios_share_outlined,
                      size: 16, color: AppTheme.obsidian),
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: AppTheme.champagne.withOpacity(0.5)),
                  ),
                  if (product.isNew)
                    Positioned(
                      top: 80,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        color: AppTheme.obsidian,
                        child: Text('NEW ARRIVAL',
                            style: GoogleFonts.jost(
                              fontSize: 9,
                              color: AppTheme.ivory,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.surface,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.brand,
                        style: GoogleFonts.jost(
                          fontSize: 10,
                          color: AppTheme.gold,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 12, color: AppTheme.gold),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating}',
                            style: GoogleFonts.jost(
                              fontSize: 12,
                              color: AppTheme.obsidian,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '  (${product.reviewCount})',
                            style: GoogleFonts.jost(
                                fontSize: 11, color: AppTheme.muted),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Product Name
                  Text(
                    product.name,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.obsidian,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.jost(
                      fontSize: 20,
                      color: AppTheme.obsidian,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppTheme.divider, thickness: 0.5),
                  const SizedBox(height: 20),

                  // ── Color Selection ──────────────────────────
                  Text(
                    'COLOUR',
                    style: GoogleFonts.jost(
                      fontSize: 10,
                      color: AppTheme.muted,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: product.colors.map((color) {
                      final selected = _selectedColor == color ||
                          (_selectedColor == null &&
                              color == product.colors.first);
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = color),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppTheme.obsidian
                                : Colors.transparent,
                            border: Border.all(
                              color: selected
                                  ? AppTheme.obsidian
                                  : AppTheme.divider,
                              width: selected ? 1 : 0.5,
                            ),
                          ),
                          child: Text(
                            color,
                            style: GoogleFonts.jost(
                              fontSize: 11,
                              color: selected ? AppTheme.ivory : AppTheme.smoke,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // ── Size Selection ───────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SIZE',
                        style: GoogleFonts.jost(
                          fontSize: 10,
                          color: AppTheme.muted,
                          letterSpacing: 2,
                        ),
                      ),
                      GestureDetector(
                        onTap: _showSizeGuide,
                        child: Text(
                          'SIZE GUIDE',
                          style: GoogleFonts.jost(
                            fontSize: 10,
                            color: AppTheme.gold,
                            letterSpacing: 1.5,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.gold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes.map((size) {
                      final selected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 52,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? AppTheme.obsidian
                                : Colors.transparent,
                            border: Border.all(
                              color: selected
                                  ? AppTheme.obsidian
                                  : AppTheme.divider,
                              width: selected ? 1 : 0.5,
                            ),
                          ),
                          child: Text(
                            size,
                            style: GoogleFonts.jost(
                              fontSize: 12,
                              color: selected ? AppTheme.ivory : AppTheme.smoke,
                              fontWeight:
                                  selected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),

                  // ── Add to Bag Button ────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.obsidian,
                        foregroundColor: AppTheme.ivory,
                        shape: const RoundedRectangleBorder(),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shopping_bag_outlined, size: 18),
                          const SizedBox(width: 10),
                          Text(
                            'ADD TO BAG',
                            style: GoogleFonts.jost(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 3,
                              color: AppTheme.ivory,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () =>
                          setState(() => _wishlisted = !_wishlisted),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.obsidian,
                        side: const BorderSide(
                            color: AppTheme.obsidian, width: 0.5),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _wishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 16,
                            color: _wishlisted
                                ? AppTheme.errorRed
                                : AppTheme.obsidian,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _wishlisted
                                ? 'SAVED TO WISHLIST'
                                : 'ADD TO WISHLIST',
                            style: GoogleFonts.jost(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Tab Section ──────────────────────────────
                  TabBar(
                    controller: _tabCtrl,
                    labelColor: AppTheme.obsidian,
                    unselectedLabelColor: AppTheme.muted,
                    indicatorColor: AppTheme.gold,
                    indicatorWeight: 1.5,
                    labelStyle: GoogleFonts.jost(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                    tabs: const [
                      Tab(text: 'DETAILS'),
                      Tab(text: 'CARE'),
                      Tab(text: 'DELIVERY'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: TabBarView(
                      controller: _tabCtrl,
                      children: [
                        // Details
                        Text(
                          product.description,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 15,
                            color: AppTheme.smoke,
                            height: 1.7,
                          ),
                        ),
                        // Care
                        Text(
                          'Dry clean only. Do not bleach. Iron on low heat with a pressing cloth. Store in the provided garment bag away from direct sunlight.',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 15,
                            color: AppTheme.smoke,
                            height: 1.7,
                          ),
                        ),
                        // Delivery
                        Text(
                          'Complimentary standard delivery on orders over \$500. Express delivery available. Free returns within 14 days. All orders arrive in our signature AURUM packaging.',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 15,
                            color: AppTheme.smoke,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSizeGuide() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surface,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SIZE GUIDE',
                style: GoogleFonts.jost(
                  fontSize: 12,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.obsidian,
                )),
            Container(
                margin: const EdgeInsets.only(top: 4, bottom: 16),
                width: 24,
                height: 1.5,
                color: AppTheme.gold),
            Table(
              border: TableBorder.all(color: AppTheme.divider, width: 0.5),
              children: [
                _tableRow(['SIZE', 'BUST', 'WAIST', 'HIPS'], isHeader: true),
                _tableRow(['XS', '79–81', '61–63', '87–89']),
                _tableRow(['S', '83–85', '65–67', '91–93']),
                _tableRow(['M', '87–89', '69–71', '95–97']),
                _tableRow(['L', '91–93', '73–75', '99–101']),
                _tableRow(['XL', '95–97', '77–79', '103–105']),
              ],
            ),
            const SizedBox(height: 16),
            Text('All measurements in centimetres.',
                style: GoogleFonts.jost(fontSize: 11, color: AppTheme.muted)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration:
          isHeader ? const BoxDecoration(color: AppTheme.champagne) : null,
      children: cells
          .map((c) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(c,
                    style: GoogleFonts.jost(
                      fontSize: 11,
                      fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
                      color: AppTheme.obsidian,
                      letterSpacing: 0.5,
                    )),
              ))
          .toList(),
    );
  }
}
