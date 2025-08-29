import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Row(
            children: [
              Hero(
                tag: 'logo',
                transitionOnUserGestures: true,
                child: SvgPicture.asset('assets/images/vmh_logo.svg', width: 50),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'VMH Application',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),

              Text(controller.name.value, style: TextStyle(fontSize: 16)),
              SizedBox(width: 10),
              controller.isAdmin.value
                  ? ElevatedButton(
                onPressed: () => Get.toNamed('/user'),
                child: Text('Quản Lý Người Dùng'),
              ) : SizedBox(),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: controller.logout,
                child: Icon(Icons.logout),
              ),  
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Home View is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
