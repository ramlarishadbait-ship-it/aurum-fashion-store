import 'package:flutter/foundation.dart';
import '../utils/constants.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  double get shipping => subtotal > 500 ? 0 : 25.00;

  double get total => subtotal + shipping;

  void addItem(ProductModel product, String size, String color) {
    final existing = _items.firstWhere(
      (i) =>
          i.product.id == product.id &&
          i.selectedSize == size &&
          i.selectedColor == color,
      orElse: () =>
          CartItem(product: product, selectedSize: '', selectedColor: ''),
    );

    if (existing.selectedSize.isNotEmpty) {
      existing.quantity++;
    } else {
      _items.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
      ));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
