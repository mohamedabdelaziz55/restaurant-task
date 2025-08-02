import 'package:res_task/main.dart';

class SharedPrefHelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userWalletKey = "USERWALLETKEY";

  Future<bool> saveUserId(String getUserId) async {
    return sp.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    return sp.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserName(String getUserName) async {
    return sp.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserWallet(String getUserWallet) async {
    return sp.setString(userWalletKey, getUserWallet);
  }

  Future<String?> getUserId() async {
    return sp.getString(userIdKey);
  }

  Future<String?> getUserEmail() async {
    return sp.getString(userEmailKey);
  }

  Future<String?> getUserName() async {
    return sp.getString(userNameKey);
  }

  Future<String?> getUserWallet() async {
    return sp.getString(userWalletKey);
  }

  Future<bool> clearData() async {
    return sp.clear();
  }
}
