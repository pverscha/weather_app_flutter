import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _useMetricsSwitch = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _useMetricsSwitch = prefs.getBool('useMetricUnits') ?? false);
  }

  _onToggleMetricSwitch(bool useMetricSystem) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _useMetricsSwitch = useMetricSystem;
      prefs.setBool('useMetricUnits', _useMetricsSwitch);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(AppLocalizations.of(context)!.settingsPageTitle)
        ),
        body: SwitchListTile(
          value: _useMetricsSwitch,
          onChanged: _onToggleMetricSwitch,
          title: Text(AppLocalizations.of(context)!.localizationSettingTitle),
          subtitle: Text(AppLocalizations.of(context)!.metricSwitchToggleDescription)
        )
    );
  }
}
