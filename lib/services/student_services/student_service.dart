import 'package:dio/dio.dart';
import 'package:housing_project/Utils/app_constatns.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/Utils/http_constants.dart';
import 'package:housing_project/models/houses_models/house_details_model.dart';
import 'package:housing_project/models/houses_models/house_model.dart';
import 'package:housing_project/models/houses_models/my_room_model.dart';
import 'package:housing_project/models/houses_models/room_details_models/rooms_response_model.dart';
import 'package:housing_project/models/room_requests_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StudentServices {
  Future<List<HouseModel>> getAllHouses();
  Future<List<HouseModel>> getCategorizedHouses(String category);
  Future<List<HouseModel>> searchForSpecificOwner(String ownerName);
  Future<String> changeFavorite(String houseId);
  Future<List<HouseModel>> getFavoriteHouses();
  Future<HouseDetailsModel> getHouseDetails(String houseId);
  Future<RoomModel> getRoomDetails(String roomId);
  Future<String> makeRequestReservation(String roomId, String timeSlotId);
  Future<List<RoomRequestsModel>?> getReservationRoomRequest();
  Future<String> cancelRequest(String requestId);
  Future<MyRoomModel?> getMyReservationRoom();
}

class StudentServicesImplementation implements StudentServices {
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
  Future<List<HouseModel>> getAllHouses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.get(
        HttpConstants.getAllHouses,
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

      List<HouseModel> houses = (responseData['houses'] as List)
          .map((houseMap) => HouseModel.fromMap(houseMap))
          .toList();

      return houses;
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
  Future<List<HouseModel>> getCategorizedHouses(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.post(
        HttpConstants.getCategorizedHouses,
        data: {
          'houseType': category,
        },
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
      List<HouseModel> houses = (responseData['houses'] as List)
          .map((houseMap) => HouseModel.fromMap(houseMap))
          .toList();
      return houses;
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
  Future<List<HouseModel>> searchForSpecificOwner(String ownerName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.get(
        HttpConstants.searchForSpecificOwner(ownerName),
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
      } else if (responseData.containsKey('message')) {
        throw AuthException(responseData['message']);
      }
      List<HouseModel> houses = (responseData['houses'] as List)
          .map((houseMap) => HouseModel.fromMap(houseMap))
          .toList();
      return houses;
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
  Future<String> changeFavorite(String houseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.put(
        HttpConstants.changeFavorite(int.parse(houseId)),
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
  Future<List<HouseModel>> getFavoriteHouses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.get(
        HttpConstants.getFavoriteHouses,
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
      } else if (responseData.containsKey('message')) {
        throw AuthException(responseData['message']);
      }

      List<HouseModel> houses = (responseData['houses'] as List)
          .map((houseMap) => HouseModel.fromMap(houseMap))
          .toList();

      return houses;
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
  Future<HouseDetailsModel> getHouseDetails(String houseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.get(
        HttpConstants.getHouseDetails(int.parse(houseId)),
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
      } else if (responseData.containsKey('message')) {
        throw AuthException(responseData['message']);
      }
      HouseDetailsModel houseDetail =
          HouseDetailsModel.fromMap(responseData['data']);

      return houseDetail;
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
  Future<RoomModel> getRoomDetails(String roomId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.get(
        HttpConstants.getRoomDetails(int.parse(roomId)),
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
      } else if (responseData.containsKey('message')) {
        throw AuthException(responseData['message']);
      }
      RoomModel roomDetail = RoomModel.fromMap(responseData['result']);

      return roomDetail;
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
  Future<String> makeRequestReservation(
      String roomId, String timeSlotId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.post(
        HttpConstants.requestReservation,
        data: {
          'roomId': roomId,
          'timeSlotId': timeSlotId,
        },
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
      } else if (responseData.containsKey('error')) {
        throw AuthException(responseData['error']);
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
  Future<List<RoomRequestsModel>?> getReservationRoomRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.get(
        HttpConstants.getReservationRoomRequest,
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
      } else if (responseData['requests'] == null) {
        return null;
      }
      List<RoomRequestsModel> roomRequests = (responseData['requests'] as List)
          .map((requestMap) => RoomRequestsModel.fromMap(requestMap))
          .toList();
      return roomRequests;
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
  Future<String> cancelRequest(String requestId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.delete(
        HttpConstants.cancelRequest(int.parse(requestId)),
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
  Future<MyRoomModel?> getMyReservationRoom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (!(prefs.containsKey(AppConstants.accessToken))) {
        throw AuthException('لم تقم بتسجيل الدخول');
      }
      final response = await dio.get(
        HttpConstants.getMyReservationRoom,
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
      } else if (responseData.containsKey('message')) {
        return null;
      }
      MyRoomModel roomModel = MyRoomModel.fromMap(responseData['myRoom']);
      return roomModel;
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
