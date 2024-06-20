import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_constatns.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/Utils/http_constants.dart';
import 'package:housing_project/models/houses_models/requestModels/house_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HouseOwnerServices {
  Future<String> addNewHouse(HouseRequestModel newHouseModel);
  Future<String> addtimeSlotsAvailable(List<Map<String, String?>> times);
}

class HouseOwnerServicesImplementation implements HouseOwnerServices {
  final dio = Dio(
    BaseOptions(
      sendTimeout: const Duration(seconds: 7),
      connectTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 7),
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
    ),
  );

  @override
  Future<String> addNewHouse(HouseRequestModel newHouseModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.post(
        HttpConstants.addHouse,
        data: newHouseModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.get(AppConstants.accessToken)}',
          },
        ),
      );

      final responseData = response.data;
      if (responseData == null ||
          responseData.isEmpty ||
          response.statusCode == 401) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      return responseData['message'];
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw AuthException('إنتهى وقت الطلب');
        case DioExceptionType.badResponse:
          if (e.response != null && e.response!.data is Map) {
            final errorData = e.response!.data as Map;
            throw AuthException(
                errorData['message'] ?? 'حصل خطأ أثناء عملية إسترجاع السكنات');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل إسترجاع السكنات : ${e.message}');
      }
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<String> addtimeSlotsAvailable(List<Map<String, String?>> times) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.post(
        HttpConstants.addtimeSlotsAvailable,
        data: {'data': times},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.get(AppConstants.accessToken)}',
          },
        ),
      );

      final responseData = response.data;
      debugPrint('test ${response.toString()}');
      if (responseData == null ||
          responseData.isEmpty ||
          response.statusCode == 401) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      return responseData['message'];
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw AuthException('إنتهى وقت الطلب');
        case DioExceptionType.badResponse:
          if (e.response != null && e.response!.data is Map) {
            final errorData = e.response!.data as Map;
            throw AuthException(
                errorData['message'] ?? 'حصل خطأ أثناء عملية إسترجاع السكنات');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل إسترجاع السكنات : ${e.message}');
      }
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}
