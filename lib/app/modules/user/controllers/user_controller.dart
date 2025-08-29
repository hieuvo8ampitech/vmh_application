import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    _userProfiles = await _userService.getAllUserProfiles();
    debugPrint('User Profiles: $_userProfiles');
    final sortedUsers = _userProfiles!
        .map((e) => VmhUser.fromMap(e))
        .toList();
    sortedUsers.sort((a, b) => a.firstName.compareTo(b.firstName));
    users.value = sortedUsers;
    update();
  }

  Future<void> createUser() async {
    final payload = <String, dynamic>{
      'email': 'thongbaokd@pharmedic.com.vn',
      'password': '123456',
      'email_confirm': true,
      'user_metadata': <String, String>{
        'first_name': 'tâm',
        'last_name': 'lâm thị hoài',
        'role': 'user',
      },
    };

 

    final res = await supabase.functions.invoke(
      'create_user',
      body: payload,
    );
    debugPrint(res.data.toString());
  }
}
