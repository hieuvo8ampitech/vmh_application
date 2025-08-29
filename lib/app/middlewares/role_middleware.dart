import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RoleMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    

    if (GetStorage().read('user')['role'] == null) {
      return const RouteSettings(name: '/home');
    } else if (GetStorage().read('user')['role'] != 'admin') {
      return const RouteSettings(name: '/home');
    }
    return null;
  }
}