import 'dart:convert';
import 'dart:developer';

import 'package:bot_search/model/user_model.dart';
import 'package:http/http.dart' as http;

class UsersApi {
  static Future<List<User>> getUsers(String query) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => User.fromJson(json)).where((user) {
        final nameLower = user.name!.toLowerCase();
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
