import 'package:dio/dio.dart';
import 'package:housing_project/Utils/app_constatns.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/Utils/http_constants.dart';
import 'package:housing_project/models/auth_models/owner_auth_model.dart';
import 'package:housing_project/models/auth_models/student_auth_model.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthServices {
  Future<bool> studentRegister(StudentRegisterModel newStudent);
  Future<String> updateMyInformation(Map<String, dynamic> newData);
  Future<Map<String, dynamic>> ownerRegister(OwnerRegisterModel newOwner);
  Future<bool> login(String email, String password);
  Future<String> changePassword(String password, String newPassword);
  Future<UserModel?> getUser();
  Future<void> logout();
}

class AuthServicesImplementation implements AuthServices {
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
  Future<bool> studentRegister(StudentRegisterModel newStudent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.post(
        HttpConstants.studentRegister,
        data: newStudent.toJson(),
      );
      final responseData = response.data;
      if (response.statusCode == 200) {
        await prefs.setString(
            AppConstants.accessToken, responseData['access_token']);
        return true;
      } else {
        throw AuthException(
            responseData['message'] ?? 'حصل خلل أثناء عملية إنشاء الحساب');
      }
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
                errorData['message'] ?? 'حصل خطأ أثناء عملية إنشاء الحساب');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل إنشاء الحساب : ${e.message}');
      }
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('حصل خلل أثناء عملية إنشاء الحساب');
    }
  }

  @override
  Future<Map<String, dynamic>> ownerRegister(
      OwnerRegisterModel newOwner) async {
    try {
      final response = await dio.post(
        HttpConstants.ownerRegister,
        data: newOwner.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data;
      } else {
        throw AuthException(response.data['message']);
      }
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
                errorData['message'] ?? 'حصل خطأ أثناء عملية إنشاء الحساب');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل إنشاء الحساب: ${e.message}');
      }
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<bool> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.post(
        HttpConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      final responseData = response.data;
      if (response.statusCode == 403 || response.statusCode == 401) {
        throw AuthException(responseData['message']);
      } else {
        await prefs.setString(
            AppConstants.accessToken, responseData['access_token']);
        return true;
      }
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
                errorData['message'] ?? 'حصل خطأ أثناء عملية إنشاء الحساب');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل إنشاء الحساب : ${e.message}');
      }
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('حصل خلل أثناء عملية تسجيل الدخول');
    }
  }

  @override
  Future<UserModel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.get(
        HttpConstants.getUser,
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
        return null;
      }
      UserModel user = UserModel.fromMap(responseData['user']);
      return user;
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
                errorData['message'] ?? 'حصل خطأ أثناء عملية إنشاء الحساب');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل إنشاء الحساب : ${e.message}');
      }
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('حصل خلل أثناء عملية تسجيل الدخول');
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
      await prefs.remove(AppConstants.accessToken);
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
                errorData['message'] ?? 'حصل خطأ أثناء عملية إنشاء الحساب');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل إنشاء الحساب : ${e.message}');
      }
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('حصل خلل أثناء عملية تسجيل الدخول');
    }
  }

  @override
  Future<String> changePassword(String password, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.post(
        HttpConstants.changePassword,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.get(AppConstants.accessToken)}',
          },
        ),
        data: {
          'password': password,
          'newPassword': newPassword,
        },
      );
      final responseData = response.data;
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
                errorData['message'] ?? 'حصل خطأ أثناء عملية إنشاء الحساب');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل إنشاء الحساب : ${e.message}');
      }
    } catch (e) {
      throw AuthException('حصل خطأ أثناء عملية تغيير كلمة المرور');
    }
  }

  @override
  Future<String> updateMyInformation(Map<String, dynamic> newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.post(
        HttpConstants.updateMyInformation,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${prefs.get(AppConstants.accessToken)}',
          },
        ),
        data: newData,
      );
      final responseData = response.data;
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
                errorData['message'] ?? 'حصل خطأ أثناء عملية تعديل المعلومات');
          } else {
            throw AuthException('إستقبال خاطئ');
          }
        case DioExceptionType.cancel:
          throw AuthException('تم إلغاء الطلب');
        case DioExceptionType.unknown:
          throw AuthException(
              'فشل الإتصال بالخادم، الرجاء التأكد من إتصال الإنترنت');
        default:
          throw AuthException('فشل تعديل المعلومات : ${e.message}');
      }
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('حصل خطأ أثناء عملية تعديل المعلومات');
    }
  }
}
