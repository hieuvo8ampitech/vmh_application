import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vmh_application/app/helpers/constants.dart';

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
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(defaultPadding * 3),
            child: DataTable2(
              columns: [
                DataColumn(
                  label: Text(
                    'Tên',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  columnWidth: FlexColumnWidth(15),
                ),
                DataColumn(
                  label: Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  columnWidth: FlexColumnWidth(15),
                ),
                DataColumn(
                  label: Text(
                    'Role',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  columnWidth: FlexColumnWidth(2),
                ),
                DataColumn(
                  label: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Tạo người dùng mới',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  columnWidth: FlexColumnWidth(2),
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
          ),
        ),
      ),
    );
  }
}
