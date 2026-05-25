import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import '../widgets/luxury_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editing = false;
  final _nameCtrl = TextEditingController(text: 'Ramla Rishad');
  final _emailCtrl = TextEditingController(text: 'ramlarishad@gmail.com');
  final _phoneCtrl = TextEditingController(text: '+94 753619852');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ivory,
      appBar: LuxuryAppBar(title: 'PROFILE'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Profile Header ─────────────────────────────────
            Container(
              color: AppTheme.obsidian,
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.gold, width: 1),
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppTheme.charcoal,
                      child: Text(
                        'AR',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 24,
                          color: AppTheme.ivory,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _nameCtrl.text,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 22,
                            color: AppTheme.ivory,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'AURUM GOLD MEMBER',
                          style: GoogleFonts.jost(
                            fontSize: 9,
                            color: AppTheme.gold,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _editing = !_editing),
                    child: Icon(
                      _editing ? Icons.close : Icons.edit_outlined,
                      size: 18,
                      color: AppTheme.muted,
                    ),
                  ),
                ],
              ),
            ),

            // ── Stats Row ─────────────────────────────────────
            Container(
              color: AppTheme.charcoal,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statItem('12', 'ORDERS'),
                  Container(width: 0.5, height: 32, color: AppTheme.smoke),
                  _statItem('5', 'WISHLIST'),
                  Container(width: 0.5, height: 32, color: AppTheme.smoke),
                  _statItem('\$2,840', 'SPENT'),
                ],
              ),
            ),

            // ── Personal Details ──────────────────────────────
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader('PERSONAL DETAILS'),
                  const SizedBox(height: 20),
                  _editing
                      ? Column(children: [
                          TextFormField(
                            controller: _nameCtrl,
                            style: GoogleFonts.jost(
                                fontSize: 14, color: AppTheme.obsidian),
                            decoration:
                                const InputDecoration(labelText: 'FULL NAME'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailCtrl,
                            style: GoogleFonts.jost(
                                fontSize: 14, color: AppTheme.obsidian),
                            decoration:
                                const InputDecoration(labelText: 'EMAIL'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneCtrl,
                            style: GoogleFonts.jost(
                                fontSize: 14, color: AppTheme.obsidian),
                            decoration:
                                const InputDecoration(labelText: 'PHONE'),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => setState(() => _editing = false),
                              child: Text('SAVE CHANGES',
                                  style: GoogleFonts.jost(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2.5,
                                    color: AppTheme.ivory,
                                  )),
                            ),
                          ),
                        ])
                      : Column(children: [
                          _infoRow(
                              Icons.person_outline, 'Name', _nameCtrl.text),
                          _infoRow(
                              Icons.email_outlined, 'Email', _emailCtrl.text),
                          _infoRow(
                              Icons.phone_outlined, 'Phone', _phoneCtrl.text),
                        ]),

                  const SizedBox(height: 32),
                  _sectionHeader('MY ACCOUNT'),
                  const SizedBox(height: 12),
                  _menuItem(Icons.shopping_bag_outlined, 'Order History',
                      onTap: () {}),
                  _menuItem(Icons.favorite_border, 'Saved Items', onTap: () {}),
                  _menuItem(Icons.location_on_outlined, 'Saved Addresses',
                      onTap: () {}),
                  _menuItem(Icons.credit_card_outlined, 'Payment Methods',
                      onTap: () {}),
                  _menuItem(Icons.notifications_none_outlined, 'Notifications',
                      onTap: () {}),

                  const SizedBox(height: 20),
                  _sectionHeader('PREFERENCES'),
                  const SizedBox(height: 12),
                  _menuItem(Icons.language_outlined, 'Language',
                      trailing: 'English', onTap: () {}),
                  _menuItem(Icons.attach_money_outlined, 'Currency',
                      trailing: 'USD', onTap: () {}),

                  const SizedBox(height: 32),
                  // Logout
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppConstants.routeLogin,
                        (r) => false,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: AppTheme.divider, width: 0.5),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text('SIGN OUT',
                          style: GoogleFonts.jost(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3,
                            color: AppTheme.smoke,
                          )),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              color: AppTheme.ivory,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 2),
        Text(label,
            style: GoogleFonts.jost(
              fontSize: 9,
              color: AppTheme.muted,
              letterSpacing: 2,
            )),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.jost(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.obsidian,
              letterSpacing: 2.5,
            )),
        Container(
            margin: const EdgeInsets.only(top: 4),
            width: 24,
            height: 1.5,
            color: AppTheme.gold),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.muted),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.jost(
                      fontSize: 10,
                      color: AppTheme.muted,
                      letterSpacing: 1,
                    )),
                Text(value,
                    style: GoogleFonts.jost(
                      fontSize: 13,
                      color: AppTheme.obsidian,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label,
      {String? trailing, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppTheme.smoke),
            const SizedBox(width: 16),
            Expanded(
                child: Text(label,
                    style: GoogleFonts.jost(
                      fontSize: 13,
                      color: AppTheme.obsidian,
                    ))),
            if (trailing != null)
              Text(trailing,
                  style: GoogleFonts.jost(fontSize: 12, color: AppTheme.muted)),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 16, color: AppTheme.muted),
          ],
        ),
      ),
    );
  }
}
