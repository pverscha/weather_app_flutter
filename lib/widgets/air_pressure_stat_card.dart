import 'package:flutter/material.dart';
import 'package:nice_weather/view_models/settings_view_model.dart';
import 'package:nice_weather/widgets/weather_stat_card.dart';
import 'package:provider/provider.dart';

import '../models/weather_stat.dart';
import '../utils/unit_conversions.dart';

class AirPressureStatCard extends StatelessWidget {
  const AirPressureStatCard({
    super.key,
    required this.title,
    this.icon = Icons.air,
    required this.weatherStat
  });

  final String title;
  final IconData icon;
  final WeatherStat? weatherStat;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(builder: (context, settings, child) {
      var unit = 'mm Hg';
      WeatherStat? convertedWeatherStat = weatherStat;

      if (settings.settings != null) {
        if (settings.settings!.useMetricUnits) {
          unit = 'hPa';

          convertedWeatherStat = weatherStat == null ? null : WeatherStat(
              convertInHgToHpa(weatherStat!.currentValue),
              convertInHgToHpa(weatherStat!.averageValue),
              convertInHgToHpa(weatherStat!.minValue),
              convertInHgToHpa(weatherStat!.maxValue),
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
