import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_constatns.dart';
import 'package:housing_project/Utils/http_constants.dart';
import 'package:housing_project/models/auth_models/owner_auth_model.dart';
import 'package:housing_project/models/auth_models/student_auth_model.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthServices {
  Future<bool> studnetRegister(StudentRegisterModel newStudent);
  Future<String> ownerRegister(OwnerRegisterModel newOwner);
  Future<bool> login(String email, String password);
  Future<String> changePassword(String password, String newPassword);
  Future<UserModel?> getUser();
  Future<void> logout();
}

class AuthServicesImplementation implements AuthServices {
  final dio = Dio(BaseOptions(
    baseUrl: HttpConstants.baseUrl,
    followRedirects: false,
    validateStatus: (status) {
      return status != null &&
          status < 500; // Accept all status codes less than 500
    },
    headers: {
      "Accept": "application/vnd.api+json",
      "Content-Type": "application/vnd.api+json",
    },
  ));

  @override
  Future<bool> studnetRegister(StudentRegisterModel newStudent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('request base url: ${dio.options.baseUrl}');
    final response = await dio.post(
      HttpConstants.studentRegister,
      data: newStudent.toJson(),
    );
    debugPrint(response.data.toString());
    final responseData = response.data;
    await prefs.setString(
        AppConstants.accessToken, responseData['access_token']);
    debugPrint('token: ${responseData['access_token']}');
    return responseData['logged'];
    // if (response.statusCode == 302) {
    //   final redirectUrl = response.headers['location']?.first;
    //   debugPrint('Redirecting to: $redirectUrl');
    //   if (redirectUrl != null) {
    //     final redirectResponse = await dio.get(redirectUrl);
    //     debugPrint(redirectResponse.toString());
    //     return redirectResponse.toString();
    //   }
    // } else if (response.statusCode == 200) {
    //   debugPrint(response.data.toString());
    //   return response.data.toString();
    // }
    // debugPrint(response.toString());
    // return response.toString();
  }

  @override
  Future<String> ownerRegister(OwnerRegisterModel newOwner) async {
    debugPrint('request base url: ${dio.options.baseUrl}');
    final response = await dio.post(
      HttpConstants.ownerRegister,
      data: newOwner.toJson(),
    );
    if (response.statusCode == 302) {
      final redirectUrl = response.headers['location']?.first;
      debugPrint('Redirecting to: $redirectUrl');
      if (redirectUrl != null) {
        final redirectResponse = await dio.get(redirectUrl);
        debugPrint(redirectResponse.toString());
        return redirectResponse.toString();
      }
    } else if (response.statusCode == 200) {
      debugPrint(response.data.toString());
      return response.data.toString();
    }
    debugPrint(response.toString());
    return response.toString();
  }

  @override
  Future<bool> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await dio.post(
      HttpConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 403 || response.statusCode == 401) {
      return false;
    } else {
      final responseData = response.data;
      debugPrint('token: ${responseData['access_token']}');
      await prefs.setString(
          AppConstants.accessToken, responseData['access_token']);
      return true;
    }
  }

  @override
  Future<UserModel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.get(
        HttpConstants.getUser,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.get(AppConstants.accessToken)}',
          },
        ),
      );

      debugPrint(response.toString());
      final responseData = response.data;
      debugPrint(responseData.toString());
      // Check if responseData is null or empty
      if (responseData == null || responseData.isEmpty) {
        return null;
      }
      UserModel user = UserModel.fromMap(responseData);
      return user;
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
  }

  @override
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await dio.post(
        HttpConstants.logout,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.get(AppConstants.accessToken)}',
          },
        ),
      );
      prefs.remove(AppConstants.accessToken);
    } catch (e) {
      debugPrint('Error logout : $e');
    }
  }

  @override
  Future<String> changePassword(String password, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.post(HttpConstants.changePassword,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${prefs.get(AppConstants.accessToken)}',
            },
          ),
          data: {
            'password': password,
            'newPassword': newPassword,
          });
      final responseData = response.data;
      debugPrint(responseData['message']);
      return responseData['message'];
    } catch (e) {
      debugPrint('Error logout : $e');
      return 'Error logout : $e';
    }
  }
}
/*
  @override
  Future<TopHeadlinesApiResponse> getUsTopHeadlines() async {
    dio.options.baseUrl = AppConstants.baseUrl;
    debugPrint('request base url: ${dio.options.baseUrl}');
    Response<Map<String, dynamic>> response = await dio.get(
      AppConstants.topHeadlines,
      options: Options(
        headers: {
          'Authorization': 'Bearer 483cfdf815b34dd48e59c99e7767167f',
        },
      ),
      queryParameters: {
        'country': 'us',
      },
    );
    debugPrint('response: ${response.data}');
    return TopHeadlinesApiResponse.fromJson(response.data!);
  }
 */
// if (response.statusCode != 200) {
    //   throw Exception('Failed to load top headlines');
    // }


 // queryParameters: {
      //   'country': 'us',
      // },