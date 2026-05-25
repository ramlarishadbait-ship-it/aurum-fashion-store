import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import '../models/cart_provider.dart';

class LuxuryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showCart;
  final bool showSearch;
  final VoidCallback? onCartTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onProfileTap;
  final String? title;

  const LuxuryAppBar({
    super.key,
    this.showCart = false,
    this.showSearch = false,
    this.onCartTap,
    this.onSearchTap,
    this.onProfileTap,
    this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.ivory,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: AppTheme.ivory,
            border: Border(
              bottom: BorderSide(color: AppTheme.divider, width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left actions
              Row(
                children: [
                  if (showSearch)
                    IconButton(
                      onPressed: onSearchTap,
                      icon: const Icon(Icons.search,
                          size: 22, color: AppTheme.obsidian),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                ],
              ),

              // Center wordmark
              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppConstants.routeHome,
                  (r) => false,
                ),
                child: Text(
                  title ?? AppConstants.appName,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.obsidian,
                    letterSpacing: 8,
                  ),
                ),
              ),

              // Right actions
              Row(
                children: [
                  if (showCart)
                    Consumer<CartProvider>(
                      builder: (_, cart, __) => GestureDetector(
                        onTap: onCartTap,
                        child: Badge(
                          isLabelVisible: cart.itemCount > 0,
                          label: Text('${cart.itemCount}',
                              style: const TextStyle(
                                  fontSize: 9, color: AppTheme.ivory)),
                          backgroundColor: AppTheme.obsidian,
                          child: const Icon(Icons.shopping_bag_outlined,
                              size: 22, color: AppTheme.obsidian),
                        ),
                      ),
                    ),
                  const SizedBox(width: 12),
                  if (onProfileTap != null)
                    IconButton(
                      onPressed: onProfileTap,
                      icon: const Icon(Icons.person_outline,
                          size: 22, color: AppTheme.obsidian),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
