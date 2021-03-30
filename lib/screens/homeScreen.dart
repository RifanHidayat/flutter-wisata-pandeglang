import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wisatapandeglang/model/WeatherModel.dart';
import 'package:wisatapandeglang/model/forecastModel.dart';
import 'package:wisatapandeglang/widgets/weather.dart';
import 'package:wisatapandeglang/widgets/weatherItem.dart';


class Homescreen extends StatefulWidget {
  Homescreen({
   this.latitudeWisata,
   this.longitudeWisata,
    this.nama_wisata

});
  var latitudeWisata,longitudeWisata,nama_wisata;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;

  loadWeather() async {
    setState(() {
      isLoading = true;
    });




      //get api respon dari api weather
      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${widget.latitudeWisata.toString()}&lon=${widget.longitudeWisata.toString()}');
    //get api respon dari api weather
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${widget.latitudeWisata.toString()}&lon=${widget.longitudeWisata.toString()}');
      //cek status respon api
      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          //memasukan data api kealam model yang telah dibuat
          weatherData =
              new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
              new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }


    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Weather',style: TextStyle(
          color: Colors.black87
        ),),
      ),
      body: Container(
        child: Center(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Container(
                    child: isLoading?Text(""):Text(widget.nama_wisata,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                    //cek data jika data telah diambil maka munculkan data tersebut
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: weatherData != null
                          ? Weather(weather: weatherData)
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading
                          ? CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  new AlwaysStoppedAnimation(Colors.blueAccent),
                            )
                          : IconButton(
                              icon: new Icon(Icons.refresh),
                              tooltip: 'Refresh',
                              onPressed: loadWeather,
                              color: Colors.white,
                            ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200.0,
                    //memunculkan data data wather dan prediksi wearher
                    child: forecastData != null
                        ? ListView.builder(
                            itemCount: forecastData.list.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => WeatherItem(
                                weather: forecastData.list.elementAt(index)))
                        : Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
