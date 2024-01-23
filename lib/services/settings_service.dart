import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';

class SettingsService {
  Future<Settings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return Settings(prefs.getBool("useMetricUnits") ?? true);
  }

  Future<void> updateSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("useMetricUnits", settings.useMetricUnits);
  }
}
