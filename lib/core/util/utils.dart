
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static bool lastActiveLessTenMinutes(DateTime activeUser) {
    final difference = DateTime
        .now()
        .difference(activeUser)
        .inMinutes;
    return difference <= 10;
  }

  static Future<void> saveNotificationsStatus(bool isOn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enable_notifications', isOn);
  }

  static Future<bool> getNotificationsStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('enable_notifications') ?? false;
  }
}