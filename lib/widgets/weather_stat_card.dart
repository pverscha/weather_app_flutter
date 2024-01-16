import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/weather_stat.dart';
import '../view_models/weather_view_model.dart';

class WeatherStatCard extends StatefulWidget {
  const WeatherStatCard({
    super.key,
    required this.title,
    required this.unit,
    required this.icon,
    required this.weatherStat
  });

  final String title;
  final String unit;
  final IconData icon;
  final WeatherStat? weatherStat;

  @override
  State<WeatherStatCard> createState() => _WeatherStatCard();
}

class _WeatherStatCard extends State<WeatherStatCard> {
  bool _isCardExpanded = true;

  toggleCardExpanded() {
    setState(() {_isCardExpanded = !_isCardExpanded;});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
          child: Column(
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                        widget.icon,
                        size: 36
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(widget.title),
                            Consumer<WeatherViewModel>(
                                builder: (context, weather, child) {
                                  return Text(
                                      widget.weatherStat == null ? "N/A" : "${widget.weatherStat!.currentValue.toStringAsFixed(1)}${widget.unit}",
                                      style: DefaultTextStyle
                                          .of(context)
                                          .style
                                          .apply(fontSizeFactor: 4)
                                  );
                                }
                            )
                          ]
                      ),
                    )
                  ]
              ),
              IconButton(
                icon: Icon(_isCardExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: toggleCardExpanded
              ),
              if (_isCardExpanded) Consumer<WeatherViewModel>(
                builder: (context, weather, child) {
                    return StaggeredGrid.count(
                      crossAxisCount: 2,
                      children: [
                        Text("${AppLocalizations.of(context)!.minimum}:"),
                        Text(
                          widget.weatherStat == null ? "N/A" : "${widget.weatherStat!.minValue.toStringAsFixed(1)}${widget.unit}",
                          textAlign: TextAlign.end,
                        ),
                        Text("${AppLocalizations.of(context)!.average}:"),
                        Text(
                          widget.weatherStat == null ? "N/A" :  "${widget.weatherStat!.averageValue.toStringAsFixed(1)}${widget.unit}",
                          textAlign: TextAlign.end,
                        ),
                        Text("${AppLocalizations.of(context)!.maximum}:"),
                        Text(
                          widget.weatherStat == null ? "N/A" : "${widget.weatherStat!.maxValue.toStringAsFixed(1)}${widget.unit}",
                          textAlign: TextAlign.end,
                        )
                      ]
                    );
                }
              )
            ],
          ),
        )
    );
  }
}
