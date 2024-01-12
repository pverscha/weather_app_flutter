import 'package:flutter/material.dart';
import 'package:nice_weather/view_models/weather_view_model.dart';
import 'package:provider/provider.dart';

import 'widgets/weather_stat_card.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => WeatherViewModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                Provider.of<WeatherViewModel>(context, listen: false)
                    .refreshWeatherValues();
              },
              tooltip: 'Check for new weather stats.',
            )
          ]
        ),
        body: Consumer<WeatherViewModel>(builder: (context, weather, child) {
          return ListView(
            children: [
              WeatherStatCard(
                  title: 'Temperature',
                  unit: '°C',
                  icon: Icons.thermostat,
                  weatherStat: weather.temperatureStat
              ),
              WeatherStatCard(
                  title: 'Dewpoint',
                  unit: '°C',
                  icon: Icons.dew_point,
                  weatherStat: weather.dewpointStat
              ),
              WeatherStatCard(
                  title: 'Humidity',
                  unit: '%',
                  icon: Icons.snowing,
                  weatherStat: weather.humidityStat
              ),
              WeatherStatCard(
                  title: 'Air pressure',
                  unit: 'hPa',
                  icon: Icons.air,
                  weatherStat: weather.pressureStat
              )
            ],
          );
        }));
  }
}