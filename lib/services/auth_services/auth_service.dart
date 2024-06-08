import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/http_constants.dart';
import 'package:housing_project/models/student_auth_model.dart';

abstract class AuthServices {
  Future<String> register(StudentRegisterModel newStudent);
  // Future<UserModel> login();
}

class AuthServicesImplementation implements AuthServices {
  final dio = Dio(BaseOptions(
    baseUrl: HttpConstants.baseUrl,
    followRedirects: true,
    validateStatus: (status) {
      return status != null &&
          status < 500; // Accept all status codes less than 500
    },
  ));
  @override
  Future<String> register(StudentRegisterModel newStudent) async {
    debugPrint('request base url: ${dio.options.baseUrl}');
    final response = await dio.post(
      HttpConstants.studentRegister,
      data: newStudent.toJson(),
      options: Options(
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        headers: {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json",
        },
      ),
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