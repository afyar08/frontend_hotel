import 'dart:convert';

import 'package:http/http.dart';

class ApiClient {
  void login(String username, password) async {
    try {
      Response response = await post(
          Uri.parse('http://127.0.0.1:8000/api/receptionist/auth_receptionist'),
          body: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data.success['token']);
        print('Login successfully');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
