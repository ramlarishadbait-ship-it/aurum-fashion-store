import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _loading = false);
      Navigator.pushReplacementNamed(context, AppConstants.routeHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ivory,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hero image section
              Stack(
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    color: AppTheme.charcoal,
                    child: Opacity(
                      opacity: 0.6,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: AppTheme.charcoal),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.appName,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 52,
                            fontWeight: FontWeight.w300,
                            color: AppTheme.ivory,
                            letterSpacing: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          AppConstants.tagline.toUpperCase(),
                          style: GoogleFonts.jost(
                            fontSize: 10,
                            color: AppTheme.gold,
                            letterSpacing: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Form Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SIGN IN',
                        style: GoogleFonts.jost(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.obsidian,
                          letterSpacing: 3,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4, bottom: 28),
                        width: 28,
                        height: 1.5,
                        color: AppTheme.gold,
                      ),

                      // Email
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.jost(
                            fontSize: 14, color: AppTheme.obsidian),
                        decoration:
                            const InputDecoration(labelText: 'EMAIL ADDRESS'),
                        validator: (v) => v == null || !v.contains('@')
                            ? 'Enter a valid email'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: _passwordCtrl,
                        obscureText: _obscurePass,
                        style: GoogleFonts.jost(
                            fontSize: 14, color: AppTheme.obsidian),
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                setState(() => _obscurePass = !_obscurePass),
                            child: Icon(
                              _obscurePass
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 18,
                              color: AppTheme.muted,
                            ),
                          ),
                        ),
                        validator: (v) => v == null || v.length < 6
                            ? 'Min 6 characters'
                            : null,
                      ),
                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            'Forgot password?',
                            style: GoogleFonts.jost(
                              fontSize: 11,
                              color: AppTheme.muted,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _login,
                          child: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    color: AppTheme.ivory,
                                  ),
                                )
                              : Text(
                                  'SIGN IN',
                                  style: GoogleFonts.jost(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 3,
                                    color: AppTheme.ivory,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Divider
                      Row(children: [
                        const Expanded(child: Divider(color: AppTheme.divider)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: GoogleFonts.jost(
                              fontSize: 11,
                              color: AppTheme.muted,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: AppTheme.divider)),
                      ]),
                      const SizedBox(height: 20),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, AppConstants.routeRegister),
                          child: Text(
                            'CREATE ACCOUNT',
                            style: GoogleFonts.jost(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 3,
                              color: AppTheme.obsidian,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
