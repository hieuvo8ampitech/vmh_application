import 'package:flutter/material.dart';

class ShippingLines {
  final String shippingLinesID;
  final String shippingLinesName;
  final String createdBy;
  final DateTime createdAt;
  final String status;

  const ShippingLines({
    required this.shippingLinesID,
    required this.shippingLinesName,
    required this.createdBy,
    required this.createdAt,
    required this.status,
  });

  factory ShippingLines.fromJson(Map<String, dynamic> json) {
    return ShippingLines(
      shippingLinesID: json['shipping_lines_id'] as String,
      shippingLinesName: json['shipping_lines_name'] as String,
      createdBy: json['created_by'] as String,
      createdAt: json['created_date'] as DateTime,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipping_lines_id': shippingLinesID,
      'shipping_lines_name': shippingLinesName,
      'created_by': createdBy,
      'created_date': createdAt,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'ShippingLines(shippingLinesID: $shippingLinesID, shippingLinesName: $shippingLinesName, createdBy: $createdBy, createdDate: $createdAt, status: $status)';
  }
}

class Tool {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  Tool({required this.name, required this.icon, required this.onTap});

  factory Tool.fromJson(Map<String, dynamic> json) {
    return Tool(
      name: json['name'] as String,
      icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
      onTap: () {}, // Placeholder, as functions can't be serialized
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon.codePoint,
      // 'onTap' cannot be serialized
    };
  }

  @override
  String toString() {
    return 'Tool(name: $name, icon: $icon)';
  }
}