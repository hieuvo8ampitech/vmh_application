import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final supabase = Supabase.instance.client;

  // Fetch current user's profile
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      
      if (userId == null) {
        throw 'User not logged in';
      }

      final response = await supabase
          .from('profiles')
          .select('*')
          .eq('id', userId)
          .single();
      
      return response;
    } on PostgrestException catch (error) {
      debugPrint('Error fetching user profile: ${error.message}');
      return null;
    }
  }

  // Fetch multiple user profiles (for admin)
  Future<List<Map<String, dynamic>>> getAllUserProfiles() async {
    try {
      final response = await supabase
          .from('profiles')
          .select('*')
          .order('created_at', ascending: false);
      
      return response;
    } on PostgrestException catch (error) {
      debugPrint('Error fetching user profiles: ${error.message}');
      return [];
    }
  }

  // Update current user profile
  Future<bool> updateUserProfile({
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      
      if (userId == null) {
        throw 'User not logged in';
      }

      await supabase
          .from('profiles')
          .update({
            if (firstName != null) 'first_name': firstName,
            if (lastName != null) 'last_name': lastName,
            if (phone != null) 'phone': phone,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);
      
      return true;
    } on PostgrestException catch (error) {
      debugPrint('Error updating profile: ${error.message}');
      return false;
    }
  }

  // Search users (admin functionality)
  Future<List<Map<String, dynamic>>> searchUsers({
    String? searchTerm,
    String? role,
  }) async {
    try {
      var query = supabase.from('profiles').select('*');
      
      if (searchTerm != null) {
        query = query.or(
          'first_name.ilike.%$searchTerm%, last_name.ilike.%$searchTerm%, email.ilike.%$searchTerm%'
        );
      }
      
      if (role != null) {
        query = query.eq('role', role);
      }
      
      final response = await query;
      return response;
    } on PostgrestException catch (error) {
      debugPrint('Error searching users: ${error.message}');
      return [];
    }
  }

  // Get user by ID (admin functionality)
  Future<Map<String, dynamic>?> getUserById(String userId) async {
    try {
      final response = await supabase
          .from('profiles')
          .select('*')
          .eq('id', userId)
          .single();
      
      return response;
    } on PostgrestException catch (error) {
      debugPrint('Error fetching user by ID: ${error.message}');
      return null;
    }
  }
}