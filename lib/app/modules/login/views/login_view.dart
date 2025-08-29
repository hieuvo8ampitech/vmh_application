import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:vmh_application/app/components/custom_button.dart';
import 'package:vmh_application/app/helpers/responsive.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    // final bool isSmallScreen = MediaQuery.of(context).size.width < 700;
    // final bool isMediumScreen =
    //     MediaQuery.of(context).size.width >= 700 &&
    //     MediaQuery.of(context).size.width < 900;

    return Scaffold(
      body: Center(
        child: Responsive.isDesktop(context)
            ? Container(
                padding: const EdgeInsets.all(32.0),
                //constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: [
                    Flexible(flex: 1, child: Center(child: _Logo())),
                    Flexible(flex: 2, child: Center(child: _FormContent())),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(32),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [_Logo(), SizedBox(height: 30), _FormContent()],
                ),
              ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    //final bool isSmallScreen = MediaQuery.of(context).size.width < 700;
    return Hero(
      tag: 'logo',
      transitionOnUserGestures: true,
      child: SvgPicture.asset(
        'assets/images/vmh_logo.svg',
        width: Responsive.isDesktop(context) ? 200 : 150,
      ),
    );
  }
}

class _FormContent extends StatelessWidget {
  const _FormContent();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Đăng Nhập',
            style: TextStyle(
              color: Color(0xFF4c662b),
              fontFamily: 'Goldman',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(3.5, 4.5),
                  blurRadius: 0,
                  color: Colors.black12,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autofillHints: [AutofillHints.username],
            decoration: const InputDecoration(labelText: 'Email'),
            onChanged: (value) => controller.email.value = value,
          ),
          const SizedBox(height: 16),
          Obx(
            () => TextField(
              autofillHints: [AutofillHints.password],
              decoration: InputDecoration(
                labelText: 'Mật khẩu',

                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordObscured.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
              obscureText: controller.isPasswordObscured.value,
              onChanged: (value) => controller.password.value = value,
              onSubmitted: (_) => controller.signIn(),
            ),
          ),
          const SizedBox(height: 32),
          Obx(
            () => controller.isLoading.value
                ? const CircularProgressIndicator()
                : CustomButton(text: 'Đăng Nhập', onPressed: controller.signIn),
          ),
        ],
      ),
    );
  }
}
