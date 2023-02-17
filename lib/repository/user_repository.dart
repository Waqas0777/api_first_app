import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";

  Future<bool> isUserExists(String userEmail) async {
    final response = await http.get(Uri.parse('$_baseUrl/users?userEmail=$userEmail'));

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);
      return users.isNotEmpty;
    } else {
      throw Exception('Failed to load users');
    }
  }


}