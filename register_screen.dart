import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConf = true;
  bool _loading = false;
  bool _agreed = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to Terms & Conditions'),
          backgroundColor: AppTheme.smoke,
        ),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _loading = false);
      Navigator.pushReplacementNamed(context, AppConstants.routeHome);
    }
  }

  Widget _buildField({
    required TextEditingController ctrl,
    required String label,
    bool obscure = false,
    bool hasToggle = false,
    VoidCallback? onToggle,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: GoogleFonts.jost(fontSize: 14, color: AppTheme.obsidian),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: hasToggle
            ? GestureDetector(
                onTap: onToggle,
                child: Icon(
                  obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: AppTheme.muted,
                ),
              )
            : null,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ivory,
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: AppTheme.obsidian,
            letterSpacing: 6,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 16),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CREATE ACCOUNT',
                  style: GoogleFonts.jost(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.obsidian,
                    letterSpacing: 3,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                  width: 28,
                  height: 1.5,
                  color: AppTheme.gold,
                ),
                Text(
                  'Join AURUM and experience luxury delivered.',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 15,
                    color: AppTheme.muted,
                  ),
                ),
                const SizedBox(height: 32),

                _buildField(
                  ctrl: _nameCtrl,
                  label: 'FULL NAME',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 20),

                _buildField(
                  ctrl: _emailCtrl,
                  label: 'EMAIL ADDRESS',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v == null || !v.contains('@')
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(height: 20),

                _buildField(
                  ctrl: _passCtrl,
                  label: 'PASSWORD',
                  obscure: _obscurePass,
                  hasToggle: true,
                  onToggle: () => setState(() => _obscurePass = !_obscurePass),
                  validator: (v) =>
                      v == null || v.length < 6 ? 'Min 6 characters' : null,
                ),
                const SizedBox(height: 20),

                _buildField(
                  ctrl: _confirmCtrl,
                  label: 'CONFIRM PASSWORD',
                  obscure: _obscureConf,
                  hasToggle: true,
                  onToggle: () => setState(() => _obscureConf = !_obscureConf),
                  validator: (v) =>
                      v != _passCtrl.text ? 'Passwords do not match' : null,
                ),
                const SizedBox(height: 24),

                // Terms checkbox
                GestureDetector(
                  onTap: () => setState(() => _agreed = !_agreed),
                  child: Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _agreed ? AppTheme.obsidian : AppTheme.muted,
                          ),
                          color:
                              _agreed ? AppTheme.obsidian : Colors.transparent,
                        ),
                        child: _agreed
                            ? const Icon(Icons.check,
                                size: 12, color: AppTheme.ivory)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'I agree to the Terms & Conditions and Privacy Policy',
                          style: GoogleFonts.jost(
                            fontSize: 12,
                            color: AppTheme.smoke,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _register,
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
                            'CREATE ACCOUNT',
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

                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Already have an account? Sign In',
                      style: GoogleFonts.jost(
                        fontSize: 12,
                        color: AppTheme.muted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
