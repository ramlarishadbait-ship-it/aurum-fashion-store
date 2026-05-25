import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import '../widgets/product_card.dart';
import '../widgets/luxury_app_bar.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});
  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String _selectedCategory = 'All';
  String _sortBy = 'Featured';
  final _categories = ['All', 'Women', 'Men', 'Accessories', 'Shoes'];

  List<ProductModel> get _filtered {
    var list = _selectedCategory == 'All'
        ? DummyData.products
        : DummyData.products
            .where((p) => p.category == _selectedCategory)
            .toList();

    switch (_sortBy) {
      case 'Price: Low–High':
        list = [...list]..sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High–Low':
        list = [...list]..sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        list = [...list]..sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        list = [...list]..sort(
            (a, b) => (b.isFeatured ? 1 : 0).compareTo(a.isFeatured ? 1 : 0));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String?;
    if (category != null && _selectedCategory == 'All') {
      Future.microtask(() => setState(() => _selectedCategory = category));
    }

    return Scaffold(
      backgroundColor: AppTheme.ivory,
      appBar: LuxuryAppBar(
        title: 'SHOP',
        showCart: true,
        onCartTap: () => Navigator.pushNamed(context, AppConstants.routeCart),
      ),
      body: Column(
        children: [
          // ── Category Filter Chips ──────────────────────────
          Container(
            height: 52,
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              border: Border(
                  bottom: BorderSide(color: AppTheme.divider, width: 0.5)),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _categories.length,
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final selected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.obsidian : Colors.transparent,
                      border: Border.all(
                        color: selected ? AppTheme.obsidian : AppTheme.divider,
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      cat.toUpperCase(),
                      style: GoogleFonts.jost(
                        fontSize: 10,
                        color: selected ? AppTheme.ivory : AppTheme.muted,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Sort Bar ───────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filtered.length} ITEMS',
                  style: GoogleFonts.jost(
                    fontSize: 11,
                    color: AppTheme.muted,
                    letterSpacing: 1.5,
                  ),
                ),
                GestureDetector(
                  onTap: _showSortSheet,
                  child: Row(
                    children: [
                      Text(
                        'SORT: $_sortBy',
                        style: GoogleFonts.jost(
                          fontSize: 11,
                          color: AppTheme.obsidian,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.unfold_more,
                          size: 14, color: AppTheme.obsidian),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Product Grid ───────────────────────────────────
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Text(
                      'No products found',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 18,
                        color: AppTheme.muted,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) => ProductCard(product: _filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }

  void _showSortSheet() {
    final options = [
      'Featured',
      'Price: Low–High',
      'Price: High–Low',
      'Rating'
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SORT BY',
              style: GoogleFonts.jost(
                fontSize: 12,
                letterSpacing: 3,
                fontWeight: FontWeight.w600,
                color: AppTheme.obsidian,
              ),
            ),
            const SizedBox(height: 4),
            Container(width: 24, height: 1.5, color: AppTheme.gold),
            const SizedBox(height: 16),
            ...options.map(
              (opt) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  opt,
                  style: GoogleFonts.jost(
                    fontSize: 14,
                    color: AppTheme.obsidian,
                  ),
                ),
                trailing: _sortBy == opt
                    ? const Icon(Icons.check,
                        size: 16, color: AppTheme.obsidian)
                    : null,
                onTap: () {
                  setState(() => _sortBy = opt);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
