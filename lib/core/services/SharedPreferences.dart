import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  // Private constructor
  SharedPrefsService._internal();

  // The single instance
  static final SharedPrefsService _instance = SharedPrefsService._internal();

  // Getter for the instance
  static SharedPrefsService get instance => _instance;

  SharedPreferences? _prefs;

  // Ensure preferences are initialized once
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }


  static const _justUnlockedKey = 'just_unlocked';

  bool getJustUnlocked() {
    return _prefs?.getBool(_justUnlockedKey) ?? false;
  }

  Future<void> setJustUnlocked(bool value) async {
    await _prefs?.setBool(_justUnlockedKey, value);
  }

  Future<void> setLastRoute(String route) async {
    // final prefs = await SharedPreferences.getInstance();
    await _prefs?.setString('last_route', route);
  }

  String? getLastRoute() {
    return _prefs?.getString('last_route');
        // .then((prefs) => prefs.getString('last_route'));
  }

  // Example: save a string
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static const _appLockKey = 'isAppLockEnabled';

  Future<void> setAppLockEnabled(bool enabled) async {
    await setBool(_appLockKey, enabled);
  }

  bool isAppLockEnabled() {
    return getBool(_appLockKey);
  }
  // Example: get a string
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Example: clear a key
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Add this inside SharedPrefsService class
  Future<void> clear() async {
    await _prefs?.clear();
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }
}
