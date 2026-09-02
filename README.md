<div align="center">

# StyleK

**Where Style Meets Elegance** ✨

A modern Flutter e-commerce app for fashion shopping — browse, filter, and
check out, with a soft pastel design system and full light/dark theming.

</div>

---

## ✨ Features

- 🔐 **Auth** — sign in / sign up, forgot password, new password, code verification
- 🏠 **Home** — categorized browsing, search with filters, promo banners
- 🧥 **Product Details** — image gallery, variants, reviews
- ❤️ **Favorites** — save products for later
- 🛒 **Cart & Checkout** — manage items, delivery details, place orders
- 🧾 **Invoices & Orders** — order history and invoice view
- 👤 **Profile** — edit profile, app preferences
- 🌗 **Light / Dark Mode** — every screen fully themed for both modes
- 🌍 **Localization** — Arabic / English support

## 🛠️ Tech Stack

| | |
|---|---|
| **Framework** | Flutter |
| **State Management** | Cubit (BLoC) |
| **Navigation** | go_router |
| **Backend** | Firebase (Auth + Firestore) |
| **Localization** | easy_localization |
| **Architecture** | Feature-first (`data` / `domain` / `presentation`) |

## 📱 Screenshots

<div align="center">

| Home | Product Details | Checkout |
|:---:|:---:|:---:|
| <img src="screenshots/home.png" width="220"/> | <img src="screenshots/details.png" width="220"/> | <img src="screenshots/checkout.png" width="220"/> |

</div>

> Replace the images above with real screenshots in a `screenshots/` folder.

## 📂 Project Structure

```
lib/
 ├─ core/            # shared styles, widgets, routing, constants
 └─ features/
     ├─ auth/
     ├─ home/
     ├─ categories/
     ├─ filter/
     ├─ search/
     ├─ details/
     ├─ cart/
     ├─ checkout/
     ├─ favorites/
     ├─ invoice/
     └─ profile/
```

## 🚀 Getting Started

```bash
flutter pub get
flutter run
```

---

<div align="center">Made with 💙 using Flutter</div>
