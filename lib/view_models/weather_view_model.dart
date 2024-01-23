import 'package:flutter/material.dart';

import '../models/weather_stat.dart';
import '../services/weather_service.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherStat? temperatureStat;
  WeatherStat? dewpointStat;
  WeatherStat? humidityStat;
  WeatherStat? pressureStat;

  WeatherViewModel() {
    // Load the initial state of this view model.
    refreshWeatherValues();
  }

  Future<void> refreshWeatherValues() async {
    temperatureStat = await _weatherService.retrieveCurrentTemperature();
    dewpointStat = await _weatherService.retrieveCurrentDewpoint();
    humidityStat = await _weatherService.retrieveCurrentHumidity();
    pressureStat = await _weatherService.retrievePressure();

    // Update all listeners that the current temperature has been updated.
    notifyListeners();
  }
}

