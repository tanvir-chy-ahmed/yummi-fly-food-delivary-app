import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelp {
  static String userIdkey = 'USER_ID';
  static String userNamekey = 'USER_NAME';
  static String userEmailKey = 'USER_EMAIL';
  static String walletKey = 'WALLET';
  static String isLoggedInKey = 'IS_LOGGED_IN';
  static String profileImageKey = 'PROFILE_IMAGE';

  // Save user login state
  Future<bool> saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  // Save profile image path
  Future<bool> saveProfileImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(profileImageKey, imagePath);
  }

  // Get profile image path
  Future<String?> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(profileImageKey);
  }

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdkey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNamekey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserWallet(String getUserWallet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(walletKey, getUserWallet);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdkey);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNamekey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(walletKey);
  }

  // Clear all user data
  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Save all user data at once
  Future<void> saveUserData({
    required String userId,
    required String name,
    required String email,
    String? wallet,
    String? profileImage,
  }) async {
    await saveUserId(userId);
    await saveUserName(name);
    await saveUserEmail(email);
    await saveLoginState(true);
    if (wallet != null) await saveUserWallet(wallet);
    if (profileImage != null) await saveProfileImage(profileImage);
  }
}
