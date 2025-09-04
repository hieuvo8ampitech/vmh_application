import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:vmh_application/app/helpers/constants.dart';
import 'package:vmh_application/app/helpers/responsive.dart';

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
                child: SvgPicture.asset(
                  'assets/images/vmh_logo.svg',
                  width: 50,
                ),
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
                    )
                  : SizedBox(),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust number of columns based on screen width
          int crossAxisCount = Responsive.isMobile(context)
              ? 2
              : Responsive.isTablet(context)
              ? 4
              : 6;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: controller.tools.length,
            itemBuilder: (context, index) {
              final tool = controller.tools[index];
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: tool.onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(tool.icon, size: 40, color: kPrimaryColor),
                        const SizedBox(height: 8),
                        Text(
                          tool.name,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
