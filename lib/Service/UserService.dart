import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/UserModel.dart';

class UserService {
  var url = "/api/users?page=2";

  Future<UserModel> getUser() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
