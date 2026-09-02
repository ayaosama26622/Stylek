class Routes {
  static String splash = '/splash';
  static String onboarding = '/onboarding';
  static String login = '/login';
  static String signup = '/signup';
  static String forgotPassword = '/forgotPassword';
  static String verification = '/verification';
  static String newPassword = '/newPassword';
  static String home = '/home';
  static String productDetails = '/product-details';
  static String checkout = '/checkout';
  static String search = '/search';
  static String categories = '/categories';
  static String filter = '/filter';
  static String invoice = '/invoice/:orderId';
  static String editProfile = '/edit-profile';
  static String myOrders = '/my-orders';

  static String invoicePath(String orderId) => '/invoice/$orderId';
}
