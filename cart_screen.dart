import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import '../models/cart_provider.dart';
import '../widgets/luxury_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ivory,
      appBar: const LuxuryAppBar(title: 'YOUR BAG'),
      body: Consumer<CartProvider>(
        builder: (_, cart, __) {
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined,
                      size: 60, color: AppTheme.divider),
                  const SizedBox(height: 20),
                  Text('Your bag is empty',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 22,
                        color: AppTheme.muted,
                      )),
                  const SizedBox(height: 8),
                  Text('Discover our curated collections',
                      style: GoogleFonts.jost(
                        fontSize: 12,
                        color: AppTheme.muted,
                        letterSpacing: 0.5,
                      )),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                          context, AppConstants.routeProducts),
                      child: Text('SHOP NOW',
                          style: GoogleFonts.jost(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3,
                            color: AppTheme.ivory,
                          )),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: AppTheme.divider, thickness: 0.5),
                  itemBuilder: (_, i) {
                    final item = cart.items[i];
                    return Dismissible(
                      key: Key('${item.product.id}_${item.selectedSize}'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: AppTheme.errorRed.withOpacity(0.1),
                        child: const Icon(Icons.delete_outline,
                            color: AppTheme.errorRed),
                      ),
                      onDismissed: (_) =>
                          context.read<CartProvider>().removeItem(i),
                      child: _CartItem(item: item, index: i),
                    );
                  },
                ),
              ),

              // ── Order Summary ──────────────────────────────
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppTheme.surface,
                  border: Border(
                      top: BorderSide(color: AppTheme.divider, width: 0.5)),
                ),
                child: Column(
                  children: [
                    _summaryRow(
                        'Subtotal', '\$${cart.subtotal.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    _summaryRow(
                      'Shipping',
                      cart.shipping == 0
                          ? 'Complimentary'
                          : '\$${cart.shipping.toStringAsFixed(2)}',
                      valueColor: cart.shipping == 0 ? AppTheme.darkGold : null,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: AppTheme.divider, thickness: 0.5),
                    ),
                    _summaryRow(
                      'TOTAL',
                      '\$${cart.total.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                            context, AppConstants.routeCheckout),
                        child: Text('PROCEED TO CHECKOUT',
                            style: GoogleFonts.jost(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.5,
                              color: AppTheme.ivory,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: isBold ? 13 : 12,
            color: isBold ? AppTheme.obsidian : AppTheme.muted,
            letterSpacing: isBold ? 2 : 0.5,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.jost(
            fontSize: isBold ? 16 : 13,
            color: valueColor ?? AppTheme.obsidian,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _CartItem extends StatelessWidget {
  final CartItem item;
  final int index;

  const _CartItem({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 90,
            height: 110,
            decoration: BoxDecoration(
              color: AppTheme.champagne.withOpacity(0.3),
            ),
            child: Image.network(
              item.product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppTheme.champagne.withOpacity(0.3)),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  item.product.name,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 16,
                    color: AppTheme.obsidian,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.selectedColor} · Size ${item.selectedSize}',
                  style: GoogleFonts.jost(
                    fontSize: 11,
                    color: AppTheme.muted,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),

                // Price & Qty
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.jost(
                        fontSize: 14,
                        color: AppTheme.obsidian,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Quantity control
                    Row(
                      children: [
                        _qtyBtn(
                          context,
                          icon: Icons.remove,
                          onTap: () => context
                              .read<CartProvider>()
                              .decrementQuantity(index),
                        ),
                        SizedBox(
                          width: 32,
                          child: Text(
                            '${item.quantity}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.jost(
                              fontSize: 13,
                              color: AppTheme.obsidian,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        _qtyBtn(
                          context,
                          icon: Icons.add,
                          onTap: () => context
                              .read<CartProvider>()
                              .incrementQuantity(index),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(BuildContext context,
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.divider, width: 0.5),
        ),
        child: Icon(icon, size: 14, color: AppTheme.obsidian),
      ),
    );
  }
}
