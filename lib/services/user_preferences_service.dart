import 'preferences_service.dart';


class UserPreferences {
  static const _usernameKey = 'username';
  static const _ageKey = 'age';

  /// Save username
  static Future<void> saveUsername(String username) async {
    await PreferencesService.saveData<String>(key: _usernameKey, value: username);
  }

  /// Load username
  static Future<String?> loadUsername() async {
    return await PreferencesService.getData<String>(key: _usernameKey);
  }

  /// Save user age
  static Future<void> saveUserAge(int age) async {
    await PreferencesService.saveData<int>(key: _ageKey, value: age);
  }

  /// Load user age
  static Future<int?> loadUserAge() async {
    return await PreferencesService.getData<int>(key: _ageKey);
  }

  /// Remove username
  static Future<void> removeUsername() async {
    await PreferencesService.removeData(key: _usernameKey);
  }

  /// Remove user age
  static Future<void> removeUserAge() async {
    await PreferencesService.removeData(key: _ageKey);
  }
}
