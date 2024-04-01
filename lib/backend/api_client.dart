import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  // Future<Response> registerUser() async {
  //     //IMPLEMENT USER REGISTRATION
  // }

  Future<Response> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'https://api.loginradius.com/identity/v2/auth/login',
        data: {
          'email': email,
          'password': password,
        },
        // queryParameters: {'apikey': 'YOUR_API_KEY'},
      );
      //returns the successful user data json object
      return response.data;
    } on DioError catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  // Future<Response> getUserProfileData() async {
  //     //GET USER PROFILE DATA
  // }

  // Future<Response> logout() async {
  //     //IMPLEMENT USER LOGOUT
  //  }
}
