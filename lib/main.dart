import 'package:flutter/material.dart';
import 'package:nice_weather/utils/unit_conversions.dart';
import 'package:nice_weather/view_models/settings_view_model.dart';
import 'package:nice_weather/view_models/weather_view_model.dart';
import 'package:nice_weather/views/settings_page.dart';
import 'package:nice_weather/widgets/air_pressure_stat_card.dart';
import 'package:nice_weather/widgets/temperature_stat_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/weather_stat_card.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => WeatherViewModel()),
      ChangeNotifierProvider(create: (context) => SettingsViewModel())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "Weather"),
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                var refreshSnackBar = SnackBar(
                  content: Text(AppLocalizations.of(context)!.updatingWeatherStatsSnackBar)
                );

                ScaffoldMessenger.of(context).showSnackBar(refreshSnackBar);

                Provider.of<WeatherViewModel>(context, listen: false)
                    .refreshWeatherValues();
              },
              tooltip: AppLocalizations.of(context)!.checkWeatherStatsTooltip,
            )
          ]
        ),
        body: Consumer<WeatherViewModel>(builder: (context, weather, child) {
          if (weather.temperatureStat == null) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else {
            return ListView(
              children: [
                TemperatureStatCard(
                    title: AppLocalizations.of(context)!.temperature,
                    weatherStat: weather.temperatureStat
                ),
                TemperatureStatCard(
                    title: AppLocalizations.of(context)!.dewPoint,
                    icon: Icons.dew_point,
                    weatherStat: weather.dewpointStat
                ),
                WeatherStatCard(
                    title: AppLocalizations.of(context)!.humidity,
                    unit: '%',
                    icon: Icons.snowing,
                    weatherStat: weather.humidityStat
                ),
                AirPressureStatCard(
                    title: AppLocalizations.of(context)!.airPressure,
                    weatherStat: weather.pressureStat
                )
              ],
            );
          }
        }
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text('Weather App'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.settingsPageTitle),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
                // Then navigate to the settings page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage())
                );
              },
            )
          ]
        )
      )
    );
  }
}
