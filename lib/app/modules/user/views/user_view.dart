import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vmh_application/app/helpers/constants.dart';
import 'package:vmh_application/app/helpers/responsive.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.pageName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: defaultPadding * 3,
            horizontal: Responsive.isTablet(context)
                ? defaultPadding * 5
                : defaultPadding * 3,
          ),
          child: Responsive.isDesktop(context)
              ? LargeTable(controller: controller)
              : SmallTable(controller: controller),
        ),
      ),
    );
  }
}

class SmallTable extends StatelessWidget {
  const SmallTable({super.key, required this.controller});

  final UserController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DataTable2(
        columns: [
          DataColumn2(
            label: Text('Tên', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn2(
            label: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Responsive.isMobile(context)
                    ? Icon(Icons.add)
                    : Text('Tạo người dùng mới'),
              ),
            ),
            fixedWidth: Responsive.isMobile(context) ? 100 : 200,
          ),
        ],
        rows: controller.users
            .map(
              (user) => DataRow(
                cells: [
                  DataCell(Text(user.fullName)),
                  DataCell(
                    Center(
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class LargeTable extends StatelessWidget {
  const LargeTable({super.key, required this.controller});

  final UserController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DataTable2(
        columns: [
          DataColumn2(
            label: Text('Tên', style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text(
              'Vai trò',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            fixedWidth: 100,
          ),
          DataColumn2(
            label: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Tạo người dùng mới',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            fixedWidth: 200,
          ),
        ],
        rows: controller.users
            .map(
              (user) => DataRow(
                cells: [
                  DataCell(Text(user.fullName)),
                  DataCell(Text(user.email)),
                  DataCell(Text(user.role)),
                  DataCell(
                    Center(
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
