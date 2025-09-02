import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vmh_application/app/components/create_user_dialog.dart';
import 'package:vmh_application/app/data/user.dart';
import 'package:vmh_application/app/services/user_service.dart';

class UserController extends GetxController {
  final supabase = Supabase.instance.client;
  final pageName = 'Quản lý người dùng';

  final UserService _userService = UserService();
  List<Map<String, dynamic>>? _userProfiles;
  RxList<VmhUser> users = <VmhUser>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    _userProfiles = await _userService.getAllUserProfiles();
    debugPrint('User Profiles: $_userProfiles');
    users.value = _userProfiles!.map((e) => VmhUser.fromMap(e)).toList();
  }

  Future<void> createUser(Map<String, dynamic> payload) async {
    final res = await supabase.functions.invoke('create_user', body: payload);
    debugPrint(res.data.toString());
  }

  void showCreateUserDialog({List<String>? roles}) {
    Get.dialog(CreateUserDialog(roles: roles ?? ['user', 'sale admin', 'admin']));
  }
}
