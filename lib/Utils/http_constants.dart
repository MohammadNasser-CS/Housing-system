class HttpConstants {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String login = '/login';
  static const String studentRegister = '/studentRegister';
  static const String ownerRegister = '/houseOwnerRegister';
  static const String getUser = '/getUser';
  static const String logout = '/logout';
  static const String changePassword = '/changePassword';
  static const String updateMyInformation = '/updateMyInformation';
  static const String getAllHouses = '/getAllHouses';
  static const String getCategorizedHouses = '/getCategorizedHouses';
  static const String getFavoriteHouses = '/getFavoriteHouses';
  static String searchForSpecificOwner(String name) => '/search/$name';
  static String getHouseDetails(int houseId) => '/getHouseDetails/$houseId';
  static String getRoomDetails(int roomId) => '/getRoomDetails/$roomId';
  static String changeFavorite(int houseId) => '/changeFavorite/$houseId';
}
