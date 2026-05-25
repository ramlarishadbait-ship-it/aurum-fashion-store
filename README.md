# AURUM — Luxury Fashion Store (Flutter)
## CIT211 Phase 1 Submission

---

## 📁 Project Structure

```
luxury_fashion_store/
├── lib/
│   ├── main.dart                          # Entry point & routing
│   ├── theme/
│   │   └── app_theme.dart                 # Color palette & typography
│   ├── utils/
│   │   └── constants.dart                 # App constants + dummy data + models
│   ├── models/
│   │   └── cart_provider.dart             # Cart state management
│   ├── screens/
│   │   ├── splash_screen.dart             # Animated splash
│   │   ├── login_screen.dart              # Sign in form
│   │   ├── register_screen.dart           # Create account
│   │   ├── home_screen.dart               # Home (banner + categories + featured)
│   │   ├── product_listing_screen.dart    # All products + filter + sort
│   │   ├── product_detail_screen.dart     # Size, colour, add to bag
│   │   ├── cart_screen.dart               # Bag with quantity controls
│   │   ├── checkout_screen.dart           # Delivery + Payment (UI only)
│   │   └── profile_screen.dart            # User profile + settings
│   └── widgets/
│       ├── luxury_app_bar.dart            # Custom AppBar with cart badge
│       └── product_card.dart              # Reusable product card
├── pubspec.yaml
└── README.md
```

---

## 🚀 Setup Instructions

### Prerequisites
- Flutter SDK 3.10+ installed
- Android Studio or VS Code with Flutter plugin
- Android emulator or physical device (API 21+)

### Step 1 — Clone / Create Project
```bash
flutter create luxury_fashion_store
cd luxury_fashion_store
```

### Step 2 — Replace Files
Copy all files from this package into your project, replacing the default ones.

### Step 3 — Install Dependencies
```bash
flutter pub get
```

### Step 4 — Add Provider dependency to pubspec.yaml
The pubspec.yaml already includes this. Run:
```bash
flutter pub get
```

### Step 5 — Add Provider to main.dart
Already configured. Just run:
```bash
flutter run
```

### Step 6 — Create Assets Directory
```bash
mkdir -p assets/images
```
*(images are loaded from network URLs so this is optional)*

---

## 🎨 Design System

| Token | Value | Usage |
|-------|-------|-------|
| Ivory | #F9F6F0 | Background |
| Obsidian | #0E0E0E | Primary / Text |
| Gold | #C9A84C | Accent / Brand |
| Champagne | #EDE0C8 | Subtle backgrounds |
| Charcoal | #1C1C1C | Dark surface |

**Fonts:**
- Display: Cormorant Garamond (serif, editorial)
- Body/UI: Jost (geometric sans-serif)

---

## 📱 Screens Delivered (Phase 1)

| Screen | File | Status |
|--------|------|--------|
| Splash | splash_screen.dart | ✅ |
| Login | login_screen.dart | ✅ |
| Register | register_screen.dart | ✅ |
| Home | home_screen.dart | ✅ |
| Product Listing | product_listing_screen.dart | ✅ |
| Product Detail | product_detail_screen.dart | ✅ |
| Cart | cart_screen.dart | ✅ |
| Checkout (UI) | checkout_screen.dart | ✅ |
| Profile | profile_screen.dart | ✅ |

---

## 📦 Dependencies

```yaml
google_fonts: ^6.1.0                    # Cormorant Garamond + Jost
provider: ^6.1.1                        # Cart state management
cached_network_image: ^3.3.1            # Efficient image loading
smooth_page_indicator: ^1.1.0           # Hero banner dots
badges: ^3.1.2                          # Cart badge count
```

---

## ✅ Phase 1 Checklist

- [x] All 9 screens implemented
- [x] Navigation between all screens
- [x] Responsive layouts (SafeArea, ScrollView)
- [x] Clean project structure (screens / widgets / theme / utils)
- [x] State management (Provider for cart)
- [x] No Firebase (Phase 2)
- [x] Luxury brand design language
- [x] Animated splash screen
- [x] Category filter with sort
- [x] Wishlist toggle
- [x] Size guide modal
- [x] Checkout step flow
- [x] Profile edit mode
- [x] Swipe-to-delete cart items
