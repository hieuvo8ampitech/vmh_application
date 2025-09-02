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
              ? const LargeTable()
              : const SmallTable(),
        ),
      ),
    );
  }
}

class SmallTable extends StatelessWidget {
  const SmallTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Obx(
      () {
        // create a sorted copy (A -> Z by firstName, Unicode compare)
        final users = controller.users.toList()
          ..sort((a, b) => a.firstName.compareTo(b.firstName));

        return DataTable2(
          columns: [
            DataColumn2(
              label: Text('Tên', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn2(
              label: Center(
                child: ElevatedButton(
                  onPressed: () => controller.showCreateUserDialog(),
                  child: Responsive.isMobile(context)
                      ? Icon(Icons.add)
                      : Text('Tạo người dùng mới'),
                ),
              ),
              fixedWidth: Responsive.isMobile(context) ? 100 : 200,
            ),
          ],
          rows: users
              .map(
                (user) => DataRow(
                  cells: [
                    DataCell(Text(user.fullName)),
                    DataCell(
                      Center(
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Use controller to open edit flow, e.g. controller.editUser(user)
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class LargeTable extends StatelessWidget {
  const LargeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Obx(
      () {
        final users = controller.users.toList()
          ..sort((a, b) => a.firstName.compareTo(b.firstName));

        return DataTable2(
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
                  onPressed: () => controller.showCreateUserDialog(),
                  child: Text(
                    'Tạo người dùng mới',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              fixedWidth: 200,
            ),
          ],
          rows: users
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
                            // Use controller to open edit flow, e.g. controller.editUser(user)
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}
