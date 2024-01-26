import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../view_models/settings_view_model.dart';

class SettingsPage extends StatelessWidget {
  _onToggleMetricSwitch(BuildContext context, bool useMetricSystem) async {
    var settingsProvider = Provider.of<SettingsViewModel>(context, listen: false);
    var currentSettings = settingsProvider.settings;
    currentSettings!.useMetricUnits = useMetricSystem;
    settingsProvider.updateSettings(currentSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(AppLocalizations.of(context)!.settingsPageTitle)
        ),
        body: Consumer<SettingsViewModel>(builder: (context, settings, child) {
          if (settings.settings == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                SwitchListTile(
                    value: settings.settings!.useMetricUnits,
                    onChanged: (val) => _onToggleMetricSwitch(context, val),
                    title: Text(AppLocalizations.of(context)!.localizationSettingTitle),
                    subtitle: Text(AppLocalizations.of(context)!.metricSwitchToggleDescription)
                ),
              ],
            );
          }
        })
    );
  }
}
