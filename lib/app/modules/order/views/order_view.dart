import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vmh_application/app/helpers/constants.dart';
import 'package:vmh_application/app/helpers/customformat.dart';
import 'package:vmh_application/app/helpers/responsive.dart';

import '../controllers/order_controller.dart'; 

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn Hàng', style: TextStyle(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding *3),
        child: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust number of columns based on screen width
          int crossAxisCount = Responsive.isMobile(context)
              ? 2
              : Responsive.isTablet(context)
              ? 3
              : 5;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2,
            ),
            itemCount: controller.shippingLines.length,
            itemBuilder: (context, index) {
              final shippingLine = controller.shippingLines[index];
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          shippingLine.shippingLinesName,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          shippingLine.createdBy,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          Customformat.formatDate(time: shippingLine.createdAt, dateOnly: false),
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
      ),
    );
  }
}
