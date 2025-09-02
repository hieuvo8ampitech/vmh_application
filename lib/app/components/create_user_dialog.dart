import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vmh_application/app/modules/user/controllers/user_controller.dart';

class CreateUserDialog extends StatefulWidget {
  final List<String> roles;

  const CreateUserDialog({
    super.key,
    this.roles = const ['user', 'admin'],
  });

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  final RxBool _loading = false.obs;
  final RxnString _selectedRole = RxnString();

  late final UserController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<UserController>();
    _selectedRole.value = widget.roles.isNotEmpty ? widget.roles.first : null;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _loading.value = true;

    final payload = <String, dynamic>{
      'email': _emailCtrl.text.trim(),
      'password': _passwordCtrl.text.trim(),
      'email_confirm': true,
      'user_metadata': <String, String>{
        'first_name': _firstNameCtrl.text.trim(),
        'last_name': _lastNameCtrl.text.trim(),
        'role': _selectedRole.value.toString(),
      },
    };

    try {
      await _controller.createUser(payload);
      if (mounted) {
        _controller.fetchUsers();
        Get.back(); // close dialog
        Get.snackbar('Thành công', 'Người dùng đã được tạo', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Lỗi', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      _loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tạo người dùng mới'),
      content: SizedBox(
        width: 480,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _lastNameCtrl,
                decoration: const InputDecoration(labelText: 'Họ'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Bắt buộc' : null,
              ),
              TextFormField(
                controller: _firstNameCtrl,
                decoration: const InputDecoration(labelText: 'Tên'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Bắt buộc' : null,
              ),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Bắt buộc';
                  final email = v.trim();
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) return 'Email không hợp lệ';
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(labelText: 'Mật Khẩu'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Bắt buộc' : null,
              ),
              const SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: _selectedRole.value,
                  items: widget.roles
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (v) => _selectedRole.value = v,
                  decoration: const InputDecoration(labelText: 'Vai trò'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Bắt buộc' : null,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Hủy')),
        Obx(
          () => ElevatedButton(
            onPressed: _loading.value ? null : _submit,
            child: _loading.value
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Tạo'),
          ),
        ),
      ],
    );
  }
}