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

| Splash | Onboarding | Sign In | Sign Up |
|:---:|:---:|:---:|:---:|
|<img width="397" height="849" alt="image" src="https://github.com/user-attachments/assets/7e27fa6e-f942-4d3f-82d7-52e2a9bf3224" /><img width="406" height="858" alt="image" src="https://github.com/user-attachments/assets/a8c982e6-f279-452e-8426-1573023184df" />
| <img width="399" height="853" alt="image" src="https://github.com/user-attachments/assets/84d0b94d-043a-4bee-88cd-d98577584fac" /><img width="403" height="852" alt="image" src="https://github.com/user-attachments/assets/625a206f-4574-4526-b365-412ba47e1f34" /><img width="405" height="855" alt="image" src="https://github.com/user-attachments/assets/509ce3bc-0db8-428a-b7d8-f4e32f1378c9" />
 | <img src="screenshots/sign_in.png" width="200"/> | <img src="screenshots/sign_up.png" width="200"/> |

| Forgot Password | Verification Code | New Password | Home |
|:---:|:---:|:---:|:---:|
| <img src="screenshots/forgot_password.png" width="200"/> | <img src="screenshots/verification_code.png" width="200"/> | <img src="screenshots/new_password.png" width="200"/> | <img src="screenshots/home.png" width="200"/> |

| Categories | Search | Filter | Product Details |
|:---:|:---:|:---:|:---:|
| <img src="screenshots/categories.png" width="200"/> | <img src="screenshots/search.png" width="200"/> | <img src="screenshots/filter.png" width="200"/> | <img src="screenshots/product_details.png" width="200"/> |

| Favorites | Cart | Checkout | Invoice |
|:---:|:---:|:---:|:---:|
| <img src="screenshots/favorites.png" width="200"/> | <img src="screenshots/cart.png" width="200"/> | <img src="screenshots/checkout.png" width="200"/> | <img src="screenshots/invoice.png" width="200"/> |

| My Orders | Profile | Edit Profile |
|:---:|:---:|:---:|
| <img src="screenshots/my_orders.png" width="200"/> | <img src="screenshots/profile.png" width="200"/> | <img src="screenshots/edit_profile.png" width="200"/> |

</div>



## 📂 Project Structure

```
lib/
 ├─ core/                 # shared styles, widgets, routing, constants
 └─ features/
     ├─ intro/            # splash & onboarding
     ├─ auth/              # sign in / sign up
     ├─ forgot password/
     ├─ Verification code/
     ├─ new password/
     ├─ home/
     ├─ categories/
     ├─ search/
     ├─ filter/
     ├─ details/           # product details
     ├─ favorites/
     ├─ cart/
     ├─ checkout/
     ├─ invoice/           # invoice & my orders
     └─ profile/
```
<div align="center">Made with 💙 using Flutter</div>
