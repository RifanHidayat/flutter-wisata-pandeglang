import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:wisatapandeglang/model/WeatherModel.dart';


class WeatherItem extends StatelessWidget {
  final WeatherData weather;

  WeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${(((weather.temp-32)* 5.0/9.0-(120))).round()}°C'),
            Text(weather.main),
            // Text('${weather.temp.toString()}°F'),
            Image.network(
                'https://openweathermap.org/img/w/${weather.icon}.png'),
            Text(new DateFormat.yMMMd().format(weather.date)),
            Text(new DateFormat.Hm().format(weather.date)),
          ],
        ),
      ),
    );
  }
}
