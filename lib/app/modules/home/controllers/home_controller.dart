import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vmh_application/app/data/models.dart';
import 'package:vmh_application/app/services/user_service.dart';

class HomeController extends GetxController {

  
final UserService _userService = UserService();
Map<String, dynamic>? _userProfile;

  final User? user = Supabase.instance.client.auth.currentUser;
  final RxString name = ''.obs;
  final RxBool isAdmin = false.obs;

  final List<Tool> tools = [
      Tool(
        name: 'Đơn Hàng',
        icon: Icons.add_chart,
        onTap: () {
          Get.toNamed('/order');
        },
      ),
      Tool(name: 'Quản Lý Đơn', icon: Icons.assignment, onTap: () {}),
    ];

  @override
  void onInit() async{
    super.onInit();

    _userProfile = await _userService.getCurrentUserProfile();
    debugPrint('User Profile: $_userProfile');
    
    if (_userProfile != null) {
      GetStorage().write('user', _userProfile);
    
      name.value = _userProfile!['first_name'];
      isAdmin.value = _userProfile!['role'] == 'admin' ? true : false;
      
    } else {
      name.value = '';
      isAdmin.value = false;
      debugPrint('No user is currently logged in');
    }
  }

  Future<void> logout() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
  }
}
