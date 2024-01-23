import 'package:flutter/material.dart';
import 'package:nice_weather/view_models/settings_view_model.dart';
import 'package:nice_weather/widgets/weather_stat_card.dart';
import 'package:provider/provider.dart';

import '../models/weather_stat.dart';
import '../utils/unit_conversions.dart';

class TemperatureStatCard extends StatelessWidget {
  const TemperatureStatCard({
    super.key,
    required this.title,
    this.icon = Icons.thermostat,
    required this.weatherStat
  });

  final String title;
  final IconData icon;
  final WeatherStat? weatherStat;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(builder: (context, settings, child) {
      var unit = 'F';
      WeatherStat? convertedWeatherStat = weatherStat;

      if (settings.settings != null) {
        if (settings.settings!.useMetricUnits) {
          unit = '°C';

          convertedWeatherStat = weatherStat == null ? null : WeatherStat(
              fahrenheitToCelsius(weatherStat!.currentValue),
              fahrenheitToCelsius(weatherStat!.averageValue),
              fahrenheitToCelsius(weatherStat!.minValue),
              fahrenheitToCelsius(weatherStat!.maxValue),
              weatherStat!.date
          );
        }
      }

      return WeatherStatCard(
        title: title,
        unit: unit,
        icon: icon,
        weatherStat: convertedWeatherStat
      );
    });
  }
}
