import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'utils/constants.dart';
import 'models/cart_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_listing_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const AurumApp(),
    ),
  );
}

class AurumApp extends StatelessWidget {
  const AurumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppConstants.routeSplash,
      routes: {
        AppConstants.routeSplash: (_) => const SplashScreen(),
        AppConstants.routeLogin: (_) => const LoginScreen(),
        AppConstants.routeRegister: (_) => const RegisterScreen(),
        AppConstants.routeHome: (_) => const HomeScreen(),
        AppConstants.routeProducts: (_) => const ProductListingScreen(),
        AppConstants.routeDetail: (_) => const ProductDetailScreen(),
        AppConstants.routeCart: (_) => const CartScreen(),
        AppConstants.routeCheckout: (_) => const CheckoutScreen(),
        AppConstants.routeProfile: (_) => const ProfileScreen(),
      },
    );
  }
}
