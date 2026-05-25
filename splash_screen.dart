import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnim = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppConstants.routeLogin);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.obsidian,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: AnimatedBuilder(
            animation: _slideAnim,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, _slideAnim.value),
              child: child,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Decorative lines above logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 40, height: 0.5, color: AppTheme.gold),
                    const SizedBox(width: 16),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppTheme.gold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(width: 40, height: 0.5, color: AppTheme.gold),
                  ],
                ),
                const SizedBox(height: 20),

                // Main wordmark
                Text(
                  AppConstants.appName,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 60,
                    fontWeight: FontWeight.w300,
                    color: AppTheme.ivory,
                    letterSpacing: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.tagline.toUpperCase(),
                  style: GoogleFonts.jost(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: AppTheme.gold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 20),

                // Decorative lines below
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 40, height: 0.5, color: AppTheme.gold),
                    const SizedBox(width: 16),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppTheme.gold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(width: 40, height: 0.5, color: AppTheme.gold),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
