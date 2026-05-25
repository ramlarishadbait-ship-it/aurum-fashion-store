import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import '../models/cart_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/luxury_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _bannerCtrl = PageController();
  int _bannerIndex = 0;

  @override
  void dispose() {
    _bannerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featured = DummyData.products.where((p) => p.isFeatured).toList();

    return Scaffold(
      backgroundColor: AppTheme.ivory,
      appBar: LuxuryAppBar(
        showCart: true,
        showSearch: true,
        onCartTap: () => Navigator.pushNamed(context, AppConstants.routeCart),
        onSearchTap: () {},
        onProfileTap: () =>
            Navigator.pushNamed(context, AppConstants.routeProfile),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Banner ────────────────────────────────────
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 420,
                  child: PageView.builder(
                    controller: _bannerCtrl,
                    onPageChanged: (i) => setState(() => _bannerIndex = i),
                    itemCount: DummyData.bannerImages.length,
                    itemBuilder: (_, i) {
                      final texts = [
                        ['NEW ARRIVALS', 'The Spring\nCollection'],
                        ['EXCLUSIVELY YOURS', 'Timeless\nElegance'],
                        ['CURATED LUXURY', 'Dressed\nfor Life'],
                      ];
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            DummyData.bannerImages[i],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: AppTheme.charcoal),
                          ),
                          // Gradient overlay
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppTheme.obsidian.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          // Text overlay
                          Positioned(
                            left: 28,
                            bottom: 52,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  texts[i][0],
                                  style: GoogleFonts.jost(
                                    fontSize: 10,
                                    color: AppTheme.gold,
                                    letterSpacing: 4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  texts[i][1],
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 40,
                                    color: AppTheme.ivory,
                                    fontWeight: FontWeight.w400,
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, AppConstants.routeProducts),
                                  child: Row(
                                    children: [
                                      Text(
                                        'EXPLORE NOW',
                                        style: GoogleFonts.jost(
                                          fontSize: 11,
                                          color: AppTheme.ivory,
                                          letterSpacing: 3,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 32,
                                        height: 0.5,
                                        color: AppTheme.ivory,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: AnimatedSmoothIndicator(
                    activeIndex: _bannerIndex,
                    count: DummyData.bannerImages.length,
                    effect: const WormEffect(
                      dotHeight: 4,
                      dotWidth: 4,
                      activeDotColor: AppTheme.gold,
                      dotColor: Colors.white38,
                    ),
                  ),
                ),
              ],
            ),

            // ── Shop by Category ───────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader('SHOP BY CATEGORY'),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 130,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: DummyData.categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) {
                        final cat = DummyData.categories[i];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppConstants.routeProducts,
                            arguments: cat.name,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppTheme.champagne, width: 1),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    cat.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: AppTheme.champagne,
                                      child: const Icon(Icons.image_outlined,
                                          color: AppTheme.muted),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                cat.label,
                                style: GoogleFonts.jost(
                                  fontSize: 10,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.obsidian,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ── Promo Banner ───────────────────────────────────
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              height: 100,
              decoration: const BoxDecoration(color: AppTheme.obsidian),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'COMPLIMENTARY SHIPPING',
                        style: GoogleFonts.jost(
                          fontSize: 10,
                          color: AppTheme.gold,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'On all orders over \$500',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 18,
                          color: AppTheme.ivory,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Featured Products ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sectionHeader('FEATURED'),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppConstants.routeProducts),
                        child: Text(
                          'VIEW ALL',
                          style: GoogleFonts.jost(
                            fontSize: 10,
                            color: AppTheme.muted,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: featured.length,
                    itemBuilder: (_, i) => ProductCard(product: featured[i]),
                  ),
                ],
              ),
            ),

            // ── New Arrivals Row ───────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: _sectionHeader('NEW ARRIVALS'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: DummyData.products.where((p) => p.isNew).length,
                itemBuilder: (_, i) {
                  final newItems =
                      DummyData.products.where((p) => p.isNew).toList();
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 160,
                      child: ProductCard(product: newItems[i], compact: true),
                    ),
                  );
                },
              ),
            ),

            // ── Values / Trust signals ─────────────────────────
            Container(
              margin: const EdgeInsets.fromLTRB(24, 36, 24, 36),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.champagne.withOpacity(0.3),
                border: Border.all(color: AppTheme.champagne),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _trustPillar(Icons.verified_outlined, 'AUTHENTIC'),
                  Container(width: 0.5, height: 50, color: AppTheme.divider),
                  _trustPillar(Icons.local_shipping_outlined, 'FREE SHIP'),
                  Container(width: 0.5, height: 50, color: AppTheme.divider),
                  _trustPillar(Icons.replay_outlined, 'EASY RETURNS'),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Nav
      bottomNavigationBar: _buildBottomNav(context, 0),
    );
  }

  Widget _sectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.jost(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.obsidian,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 4),
        Container(width: 24, height: 1.5, color: AppTheme.gold),
      ],
    );
  }

  Widget _trustPillar(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 22, color: AppTheme.smoke),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: 9,
            letterSpacing: 1.5,
            color: AppTheme.smoke,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context, int currentIndex) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.divider, width: 0.5)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          switch (i) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(context, AppConstants.routeProducts);
              break;
            case 2:
              Navigator.pushNamed(context, AppConstants.routeCart);
              break;
            case 3:
              Navigator.pushNamed(context, AppConstants.routeProfile);
              break;
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.obsidian,
        unselectedItemColor: AppTheme.muted,
        selectedLabelStyle: GoogleFonts.jost(fontSize: 9, letterSpacing: 1.5),
        unselectedLabelStyle: GoogleFonts.jost(fontSize: 9, letterSpacing: 1.5),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 22), label: 'HOME'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined, size: 22), label: 'SHOP'),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>(
              builder: (_, cart, __) => Badge(
                isLabelVisible: cart.itemCount > 0,
                label: Text('${cart.itemCount}',
                    style: const TextStyle(fontSize: 9, color: AppTheme.ivory)),
                backgroundColor: AppTheme.obsidian,
                child: const Icon(Icons.shopping_bag_outlined, size: 22),
              ),
            ),
            label: 'BAG',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 22), label: 'PROFILE'),
        ],
      ),
    );
  }
}
