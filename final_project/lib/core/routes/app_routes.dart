import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/features/Verification%20code/presentation/page/verification_code.dart';
import 'package:final_project/features/auth/presentation/page/sign_in_screen.dart';
import 'package:final_project/features/auth/presentation/page/sign_up_screen.dart';
import 'package:final_project/features/checkout/presentation/page/checkout_screen.dart';
import 'package:final_project/features/forgot%20password/presentation/page/forgot_password.dart';
import 'package:final_project/features/categories/presentation/page/categories_screen.dart';
import 'package:final_project/features/filter/presentation/page/filter_screen.dart';
import 'package:final_project/features/home/presentation/page/main_screen.dart';
import 'package:final_project/features/details/presentation/page/product_details_screen.dart';
import 'package:final_project/features/details/data/model/product_detail_model.dart';
import 'package:final_project/features/intro/presentation/page/onboarding_screen.dart';
import 'package:final_project/features/intro/splash/splash_screen.dart';
import 'package:final_project/features/invoice/presentation/page/invoice_screen.dart';
import 'package:final_project/features/new%20password/presentation/page/new_password_screen.dart';
import 'package:final_project/features/profile/presentation/page/edit_profile_screen.dart';
import 'package:final_project/features/invoice/presentation/page/my_orders_screen.dart';
import 'package:final_project/features/search/presentation/page/search_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

var globalContext = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter routes = GoRouter(
    navigatorKey: globalContext,
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      GoRoute(
        path: Routes.login,
        builder: (context, state) => const SignInScreen(),
      ),

      GoRoute(
        path: Routes.signup,
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      GoRoute(
        path: Routes.verification,
        builder: (context, state) => const VerificationScreen(),
      ),

      GoRoute(
        path: Routes.newPassword,
        builder: (context, state) => const NewPasswordScreen(),
      ),

      GoRoute(
        path: Routes.home,
        builder: (context, state) => const MainScreen(),
      ),

      GoRoute(
        path: Routes.productDetails,
        builder: (context, state) {
          final detail = state.extra as ProductDetailModel?;
          return ProductDetailsScreen(
            detail: detail ?? ProductDetailModel.mensJacketDemo(),
          );
        },
      ),

      GoRoute(
        path: Routes.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),

      GoRoute(
        path: Routes.search,
        builder: (context, state) => const SearchScreen(),
      ),

      GoRoute(
        path: Routes.categories,
        builder: (context, state) => const CategoriesScreen(),
      ),

      GoRoute(
        path: Routes.filter,
        builder: (context, state) => const FilterScreen(),
      ),

      GoRoute(
        path: Routes.invoice,
        builder: (context, state) {
          final orderId = state.pathParameters['orderId'] ?? '';
          return InvoiceScreen(orderId: orderId);
        },
      ),

      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),

      GoRoute(
        path: Routes.myOrders,
        builder: (context, state) => const MyOrdersScreen(),
      ),
    ],
  );
}
