
class Utils {
  static bool lastActiveLessTenMinutes(DateTime activeUser) {
    final difference = DateTime
        .now()
        .difference(activeUser)
        .inMinutes;
    return difference <= 10;
  }
}