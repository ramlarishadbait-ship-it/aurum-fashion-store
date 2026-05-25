import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/constants.dart';
import '../widgets/luxury_app_bar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _step = 0;
  final _deliveryKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _zipCtrl = TextEditingController();
  String _paymentMethod = 'card';
  bool _orderPlaced = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _zipCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_orderPlaced) return _OrderConfirmation();

    return Scaffold(
      backgroundColor: AppTheme.ivory,
      appBar: LuxuryAppBar(title: 'CHECKOUT'),
      body: Column(
        children: [
          // Step indicator
          _StepIndicator(currentStep: _step),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _step == 0
                  ? _DeliveryForm(
                      formKey: _deliveryKey,
                      nameCtrl: _nameCtrl,
                      phoneCtrl: _phoneCtrl,
                      addressCtrl: _addressCtrl,
                      cityCtrl: _cityCtrl,
                      zipCtrl: _zipCtrl,
                    )
                  : _PaymentForm(
                      selected: _paymentMethod,
                      onChanged: (v) => setState(() => _paymentMethod = v),
                    ),
            ),
          ),

          // Bottom button
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              border:
                  Border(top: BorderSide(color: AppTheme.divider, width: 0.5)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_step == 0) {
                    if (_deliveryKey.currentState?.validate() ?? false) {
                      setState(() => _step = 1);
                    }
                  } else {
                    setState(() => _orderPlaced = true);
                  }
                },
                child: Text(
                  _step == 0 ? 'CONTINUE TO PAYMENT' : 'PLACE ORDER',
                  style: GoogleFonts.jost(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.5,
                    color: AppTheme.ivory,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step Indicator ────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      color: AppTheme.surface,
      child: Row(
        children: [
          _Step(label: 'DELIVERY', index: 0, current: currentStep),
          Expanded(child: Container(height: 0.5, color: AppTheme.divider)),
          _Step(label: 'PAYMENT', index: 1, current: currentStep),
          Expanded(child: Container(height: 0.5, color: AppTheme.divider)),
          _Step(label: 'CONFIRM', index: 2, current: currentStep),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String label;
  final int index;
  final int current;
  const _Step(
      {required this.label, required this.index, required this.current});

  @override
  Widget build(BuildContext context) {
    final done = index < current;
    final active = index == current;
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done || active ? AppTheme.obsidian : Colors.transparent,
            border: Border.all(
              color: done || active ? AppTheme.obsidian : AppTheme.divider,
              width: 0.5,
            ),
          ),
          child: Center(
            child: done
                ? const Icon(Icons.check, size: 14, color: AppTheme.ivory)
                : Text(
                    '${index + 1}',
                    style: GoogleFonts.jost(
                      fontSize: 11,
                      color: active ? AppTheme.ivory : AppTheme.muted,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: 9,
            letterSpacing: 1.5,
            color: active ? AppTheme.obsidian : AppTheme.muted,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// ── Delivery Form ─────────────────────────────────────────────

class _DeliveryForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl,
      phoneCtrl,
      addressCtrl,
      cityCtrl,
      zipCtrl;
  const _DeliveryForm({
    required this.formKey,
    required this.nameCtrl,
    required this.phoneCtrl,
    required this.addressCtrl,
    required this.cityCtrl,
    required this.zipCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('DELIVERY DETAILS'),
          const SizedBox(height: 20),
          _field(
              ctrl: nameCtrl,
              label: 'FULL NAME',
              validator: (v) => v!.isEmpty ? 'Required' : null),
          const SizedBox(height: 16),
          _field(
              ctrl: phoneCtrl,
              label: 'PHONE NUMBER',
              type: TextInputType.phone,
              validator: (v) => v!.isEmpty ? 'Required' : null),
          const SizedBox(height: 16),
          _field(
              ctrl: addressCtrl,
              label: 'STREET ADDRESS',
              validator: (v) => v!.isEmpty ? 'Required' : null),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
                child: _field(
                    ctrl: cityCtrl,
                    label: 'CITY',
                    validator: (v) => v!.isEmpty ? 'Required' : null)),
            const SizedBox(width: 16),
            SizedBox(
                width: 120,
                child: _field(
                    ctrl: zipCtrl,
                    label: 'ZIP CODE',
                    validator: (v) => v!.isEmpty ? 'Required' : null)),
          ]),
          const SizedBox(height: 32),
          _sectionLabel('DELIVERY OPTIONS'),
          const SizedBox(height: 16),
          _DeliveryOption(
            title: 'Standard Delivery',
            subtitle: '5–7 working days',
            price: 'Complimentary',
            selected: true,
          ),
          const SizedBox(height: 8),
          _DeliveryOption(
            title: 'Express Delivery',
            subtitle: '2–3 working days',
            price: '\$25.00',
            selected: false,
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController ctrl,
    required String label,
    TextInputType type = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: type,
      style: GoogleFonts.jost(fontSize: 14, color: AppTheme.obsidian),
      decoration: InputDecoration(labelText: label),
      validator: validator,
    );
  }

  Widget _sectionLabel(String text) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
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

class _DeliveryOption extends StatelessWidget {
  final String title, subtitle, price;
  final bool selected;
  const _DeliveryOption({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? AppTheme.obsidian : AppTheme.divider,
          width: selected ? 1 : 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.obsidian, width: 0.5),
            ),
            child: selected
                ? Center(
                    child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppTheme.obsidian,
                          shape: BoxShape.circle,
                        )))
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.jost(
                      fontSize: 13,
                      color: AppTheme.obsidian,
                      fontWeight: FontWeight.w500,
                    )),
                Text(subtitle,
                    style:
                        GoogleFonts.jost(fontSize: 11, color: AppTheme.muted)),
              ],
            ),
          ),
          Text(price,
              style: GoogleFonts.jost(
                fontSize: 12,
                color: AppTheme.obsidian,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

// ── Payment Form ──────────────────────────────────────────────

class _PaymentForm extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  const _PaymentForm({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('PAYMENT METHOD'),
        const SizedBox(height: 16),
        _PayOption(
            label: 'Credit / Debit Card',
            icon: Icons.credit_card_outlined,
            value: 'card',
            group: selected,
            onChanged: onChanged),
        const SizedBox(height: 8),
        _PayOption(
            label: 'PayPal',
            icon: Icons.account_balance_wallet_outlined,
            value: 'paypal',
            group: selected,
            onChanged: onChanged),
        const SizedBox(height: 8),
        _PayOption(
            label: 'Bank Transfer',
            icon: Icons.account_balance_outlined,
            value: 'bank',
            group: selected,
            onChanged: onChanged),
        if (selected == 'card') ...[
          const SizedBox(height: 32),
          _label('CARD DETAILS'),
          const SizedBox(height: 16),
          TextFormField(
            style: GoogleFonts.jost(fontSize: 14, color: AppTheme.obsidian),
            decoration: const InputDecoration(labelText: 'CARD NUMBER'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
                child: TextFormField(
              style: GoogleFonts.jost(fontSize: 14, color: AppTheme.obsidian),
              decoration: const InputDecoration(labelText: 'EXPIRY DATE'),
            )),
            const SizedBox(width: 16),
            SizedBox(
                width: 100,
                child: TextFormField(
                  style:
                      GoogleFonts.jost(fontSize: 14, color: AppTheme.obsidian),
                  decoration: const InputDecoration(labelText: 'CVV'),
                  keyboardType: TextInputType.number,
                )),
          ]),
          const SizedBox(height: 16),
          TextFormField(
            style: GoogleFonts.jost(fontSize: 14, color: AppTheme.obsidian),
            decoration: const InputDecoration(labelText: 'CARDHOLDER NAME'),
          ),
        ],
      ],
    );
  }

  Widget _label(String text) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
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

class _PayOption extends StatelessWidget {
  final String label, value, group;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const _PayOption({
    required this.label,
    required this.icon,
    required this.value,
    required this.group,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sel = value == group;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: sel ? AppTheme.obsidian : AppTheme.divider,
            width: sel ? 1 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 20, color: sel ? AppTheme.obsidian : AppTheme.muted),
            const SizedBox(width: 12),
            Expanded(
                child: Text(label,
                    style: GoogleFonts.jost(
                      fontSize: 13,
                      color: AppTheme.obsidian,
                    ))),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.obsidian, width: 0.5),
              ),
              child: sel
                  ? Center(
                      child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppTheme.obsidian,
                            shape: BoxShape.circle,
                          )))
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Order Confirmation ────────────────────────────────────────

class _OrderConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ivory,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: AppTheme.obsidian,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.check, color: AppTheme.ivory, size: 32),
                ),
                const SizedBox(height: 28),
                Text('Order Confirmed',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      color: AppTheme.obsidian,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 10),
                Text(
                    'Thank you for choosing AURUM.\nYour order is being prepared with care.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 13,
                      color: AppTheme.muted,
                      height: 1.6,
                    )),
                const SizedBox(height: 8),
                Text(
                    '#AUR-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                    style: GoogleFonts.jost(
                      fontSize: 12,
                      color: AppTheme.gold,
                      letterSpacing: 2,
                    )),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppConstants.routeHome,
                      (r) => false,
                    ),
                    child: Text('CONTINUE SHOPPING',
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
        ),
      ),
    );
  }
}
