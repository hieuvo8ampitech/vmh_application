import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  // @override
  // void onInit() async{
  //   super.onInit();
  //   var newUser = await Supabase.instance.client.auth.signUp(
      
  //       email: 'hieuvo.ampitech3@gmail.com',
  //       password: 'Hieu1803@@',
      
  //   );

  //   if(newUser.user != null) {
  //     debugPrint('User signed up successfully: ${newUser.user?.email} with ID: ${newUser.user?.id}');
  //   } else {
  //     debugPrint('Failed to sign up user');
  //   }
  // }

  RxString email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var isPasswordObscured = true.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  Future<void> signIn() async {
    final supabase = Supabase.instance.client;
    isLoading.value = true;

    try {
      await supabase.auth.signInWithPassword(
        email: email.value,
        password: password.value,
      );
    } catch (e) {
      debugPrint('Login error: $e');
      Get.snackbar(
        '',
        '',
        titleText: Center(
          child: const Text(
            'Lỗi Đăng Nhập',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        messageText: Center(
          child: Text(
            'Tên đăng nhập hoặc mật khẩu không đúng',
            style: TextStyle(fontSize: 18),
          ),
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }

    isLoading.value = false;
  }
}
