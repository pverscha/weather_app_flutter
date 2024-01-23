import 'dart:convert';

import 'package:nice_weather/utils/unit_conversions.dart';

import '../models/weather_stat.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // URL that always provides the most recent set of temperature (and other weather-related) metrics.
  static const String currentReadingsUrl = "https://www.weerstationbelsele.be/api/summary.php";

  Future<dynamic> _retrieveMostRecentAPIResponse() async {
    var response = await http.get(Uri.parse(currentReadingsUrl));
    return  jsonDecode(response.body);
  }

  Future<WeatherStat> _retrieveWeatherStat(
      String currentKey,
      String averageKey,
      String minKey,
      String maxKey,
  ) async {
    var parsedResponse = await _retrieveMostRecentAPIResponse();

    return WeatherStat(
        parsedResponse[currentKey].toDouble(),
        parsedResponse[averageKey].toDouble(),
        parsedResponse[minKey].toDouble(),
        parsedResponse[maxKey].toDouble(),
        DateTime.fromMicrosecondsSinceEpoch(parsedResponse['dateTime'] as int)
    );
  }

  Future<WeatherStat> retrieveCurrentTemperature() async {
    return await _retrieveWeatherStat('outTemp', 'averageTemp', 'minTemp', 'maxTemp');
  }

  Future<WeatherStat> retrieveCurrentDewpoint() async {
    return await _retrieveWeatherStat('dewpoint', 'averageDewpoint', 'minDewpoint', 'maxDewpoint');
  }

  Future<WeatherStat> retrieveCurrentHumidity() async {
    return await _retrieveWeatherStat('outHumidity', 'averageHumidity', 'minHumidity', 'maxHumidity');
  }

  Future<WeatherStat> retrievePressure() async {
    return await _retrieveWeatherStat('airPressure', 'averageAirPressure', 'minAirPressure', 'maxAirPressure');
  }
}
