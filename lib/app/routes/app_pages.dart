import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../middlewares/role_middleware.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.user,
      page: () => const UserView(),
      binding: UserBinding(),
      middlewares: [RoleMiddleware()],
    ),
    GetPage(
      name: _Paths.order,
      page: () => const OrderView(),
      binding: OrderBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
