import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final bool compact;

  const ProductCard({super.key, required this.product, this.compact = false});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _wishlisted = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppConstants.routeDetail,
        arguments: p,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: widget.compact ? 3 : 4,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: AppTheme.champagne.withOpacity(0.3),
                  child: Image.network(
                    p.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppTheme.champagne.withOpacity(0.3),
                      child: const Icon(Icons.image_outlined,
                          color: AppTheme.muted, size: 36),
                    ),
                  ),
                ),

                // NEW badge
                if (p.isNew)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      color: AppTheme.obsidian,
                      child: Text(
                        'NEW',
                        style: GoogleFonts.jost(
                          fontSize: 9,
                          color: AppTheme.ivory,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                // Wishlist
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => setState(() => _wishlisted = !_wishlisted),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppTheme.surface.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _wishlisted ? Icons.favorite : Icons.favorite_border,
                        size: 14,
                        color: _wishlisted ? AppTheme.errorRed : AppTheme.muted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 14,
                    color: AppTheme.obsidian,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${p.price.toStringAsFixed(0)}',
                  style: GoogleFonts.jost(
                    fontSize: 12,
                    color: AppTheme.smoke,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
