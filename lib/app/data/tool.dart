import 'package:flutter/material.dart';

class Tool {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  Tool({required this.name, required this.icon, required this.onTap});
}