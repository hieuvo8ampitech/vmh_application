class VmhUser {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  String get fullName => '$lastName $firstName';
  final DateTime createdAt;
  final DateTime updatedAt;

  VmhUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VmhUser.fromMap(Map<String, dynamic> map) {
    return VmhUser(
      id: map['id'] as String,
      email: map['email'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      role: map['role'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'VmhUser(id: $id, email: $email, firstName: $firstName, lastName: $lastName, role: $role, createAt: $createdAt, updateAt: $updatedAt)';
  }
}