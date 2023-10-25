import 'dart:convert';
import 'package:flutter_simple_page/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const baseUrl = 'http://127.0.0.1:8000/api';

  static Future<http.Response> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    return response;
  }

  static Future<http.Response> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        "email": email,
        "password": password,
      }),
    );
    return response;
  }

  static Future<User> fetchUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final userProfileMap = jsonDecode(response.body);
      final userProfile = User.fromJson(userProfileMap);
      return userProfile;
    } else {
      throw Exception('Failed to load User');
    }
  }
}
