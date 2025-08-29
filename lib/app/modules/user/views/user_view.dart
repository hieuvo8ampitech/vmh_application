import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(controller.pageName),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () => controller.createUser(),
          child: const Text('CreateUser',
          style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
