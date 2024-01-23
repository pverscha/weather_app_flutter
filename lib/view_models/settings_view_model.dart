import 'package:flutter/material.dart';

import '../models/settings.dart';
import '../services/settings_service.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsService _settingsService = SettingsService();
  Settings? settings;

  SettingsViewModel() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    settings = await _settingsService.getSettings();
    notifyListeners();
  }

  Future<void> updateSettings(Settings settings) async {
    await _settingsService.updateSettings(settings);
    settings = settings;
    notifyListeners();
  }
}
