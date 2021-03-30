import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:google_maps_webservice/directions.dart';

class DirectionProvider extends ChangeNotifier {

  //Api google direction
  GoogleMapsDirections directionsApi =
  GoogleMapsDirections(apiKey: "AIzaSyAS0ZC9_i6uCFpbD5vrqLjk_rX2TB1QuLY");

  Set<maps.Polyline> _route = Set();

  Set<maps.Polyline> get currentRoute => _route;

  findDirections(maps.LatLng from, maps.LatLng to) async {
    //lat dan long posisi handphone
    var origin = Location(from.latitude, from.longitude);

    //lat dan long tempat wisata
    var destination = Location(to.latitude, to.longitude);

    var result = await directionsApi.directionsWithLocation(
      origin,
      destination,
      travelMode: TravelMode.driving,
    );

    Set<maps.Polyline> newRoute = Set();

    if (result.isOkay) {
      var route = result.routes[0];
      var leg = route.legs[0];

      List<maps.LatLng> points = [];

      leg.steps.forEach((step) {
        points.add(maps.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(maps.LatLng(step.endLocation.lat, step.endLocation.lng));
      });
      //membuat rute
      var line = maps.Polyline(
        points: points,
        polylineId: maps.PolylineId("mejor ruta"),
        color: Colors.blueAccent,
        width: 4,
      );
      newRoute.add(line);

      print(line);

      _route = newRoute;
      notifyListeners();
    } else {
      print("ERRROR !!! ${result.status}");
    }
  }
}
