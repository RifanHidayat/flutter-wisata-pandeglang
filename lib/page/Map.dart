import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';



const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
//const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(-6.2293867,106.6894293);

var currentlat=6.2293867;
var currenlong=106.6894293;

class Maps extends StatefulWidget {
  Maps({
   this.latitudeWisata,
   this.longitudeWisata,
    this.icon
});
  String latitudeWisata,longitudeWisata,icon;
  @override
  State<StatefulWidget> createState() => MapsState();
}

class MapsState extends State<Maps> {
  var _assets;

  Completer<GoogleMapController> _controller = Completer();
  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();

  //google direction api
  String googleAPIKey = "AIzaSyAS0ZC9_i6uCFpbD5vrqLjk_rX2TB1QuLY";
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;


  //get cureent position
  Position _currentPosition;
  String _currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  //get lokasi saat ini
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        currentlat=_currentPosition.latitude;
        currenlong=_currentPosition.longitude;

      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  //convert lat long to adress
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    if(widget.icon=="current"){
      _assets="assets/current.png";
    }else if (widget.icon=="motor"){
      _assets="assets/motor.png";
    }else{
      _assets="assets/driving_pin.png";

    }
    super.initState();
    _getCurrentLocation();
    setSourceAndDestinationIcons();


  }

  void setSourceAndDestinationIcons() async {

    sourceIcon = await BitmapDescriptor.fromAssetImage(

        ImageConfiguration(devicePixelRatio: 0.5), '$_assets',
    );
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: LatLng(currentlat,currenlong));
    return _currentPosition!=null?GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        tiltGesturesEnabled: false,
        markers: _markers,
        polylines: _polylines,
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        onMapCreated: onMapCreated):Container(
      color: Colors.white,

    );
  }

  void onMapCreated(GoogleMapController controller) {
   // controller.setMapStyle(Utils.mapStyles);
   //  controller.setMapStyle('[{"featureType": "all","stylers": [{ "color": "#C0C0C0" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "#CCFFFF" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "off" }]}]');
   //  _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      //menampilkan market posisi saat ini
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: LatLng(currentlat,currenlong),
          icon: sourceIcon));
      // destination pin
      //menampilkan posisi tujuan
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: LatLng(double.parse(widget.latitudeWisata),double.parse(widget.longitudeWisata)),
          icon: destinationIcon));
    });
  }
//funtion membuat polilyn berdsarkan lat long dari posisi saat ini dan posisi tempat wisata
  setPolylines() async {

    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        currentlat,
        currenlong,
        double.parse(widget.latitudeWisata),
        double.parse(widget.longitudeWisata));
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }
}


// //   }
// // }
// //
// //
// //
// //
// // class SearchPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final weatherBloc = BlocProvider.of<WeatherBloc>(context);
// //     var cityController = TextEditingController();
// //
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: <Widget>[
// //
// //
// //         Center(
// //             child: Container(
// //               child: FlareActor("assets/WorldSpin.flr", fit: BoxFit.contain, animation: "roll",),
// //               height: 300,
// //               width: 300,
// //             )
// //         ),
// //
// //
// //
// //         BlocBuilder<WeatherBloc, WeatherState>(
// //           builder: (context, state){
// //             if(state is WeatherIsNotSearched)
// //               return Container(
// //                 padding: EdgeInsets.only(left: 32, right: 32,),
// //                 child: Column(
// //                   children: <Widget>[
// //                     Text("Search Weather", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
// //                     Text("Instanly", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),),
// //                     SizedBox(height: 24,),
// //                     TextFormField(
// //                       controller: cityController,
// //
// //                       decoration: InputDecoration(
// //
// //                         prefixIcon: Icon(Icons.search, color: Colors.white70,),
// //                         enabledBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.all(Radius.circular(10)),
// //                             borderSide: BorderSide(
// //                                 color: Colors.white70,
// //                                 style: BorderStyle.solid
// //                             )
// //                         ),
// //
// //                         focusedBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.all(Radius.circular(10)),
// //                             borderSide: BorderSide(
// //                                 color: Colors.blue,
// //                                 style: BorderStyle.solid
// //                             )
// //                         ),
// //
// //                         hintText: "City Name",
// //                         hintStyle: TextStyle(color: Colors.white70),
// //
// //                       ),
// //                       style: TextStyle(color: Colors.white70),
// //
// //                     ),
// //
// //                     SizedBox(height: 20,),
// //                     Container(
// //                       width: double.infinity,
// //                       height: 50,
// //                       child: FlatButton(
// //                         shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
// //                         onPressed: (){
// //                           weatherBloc.add(FetchWeather(cityController.text));
// //                         },
// //                         color: Colors.lightBlue,
// //                         child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),
// //
// //                       ),
// //                     )
// //
// //                   ],
// //                 ),
// //               );
// //             else if(state is WeatherIsLoading)
// //               return Center(child : CircularProgressIndicator());
// //             else if(state is WeatherIsLoaded)
// //               return ShowWeather(state.getWeather, cityController.text);
// //             else
// //               return Text("Error",style: TextStyle(color: Colors.white),);
// //           },
// //         )
// //
// //       ],
// //     );
// //   }
// // }
// //
// // class ShowWeather extends StatelessWidget {
// //   WeatherModel weather;
// //   final city;
// //
// //   ShowWeather(this.weather, this.city);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Container(
// //           padding: EdgeInsets.only(right: 32, left: 32, top: 10),
// //           child: Column(
// //             children: <Widget>[
// //               Text(city,style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
// //               SizedBox(height: 10,),
// //
// //               Text(weather.getTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 50),),
// //               Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
// //
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: <Widget>[
// //                   Column(
// //                     children: <Widget>[
// //                       Text(weather.getMinTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
// //                       Text("Min Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
// //                     ],
// //                   ),
// //                   Column(
// //                     children: <Widget>[
// //                       Text(weather.getMaxTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
// //                       Text("Max Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //
// //               Container(
// //                 width: double.infinity,
// //                 height: 50,
// //                 child: FlatButton(
// //                   shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
// //                   onPressed: (){
// //                     BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
// //                   },
// //                   color: Colors.lightBlue,
// //                   child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),
// //
// //                 ),
// //               )
// //             ],
// //           )
// //       ),
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travel/page/DeliveryScreen.dart';
// import 'package:travel/services/direction.dart';
//
//
//
//
// class Maps extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Container(
//         child: ChangeNotifierProvider(
//           builder: (_) => DirectionProvider(),
//           child: MaterialApp(
//             title: 'Flutter Demo',
//
//             home: MapsScreen(),
//             debugShowCheckedModeBanner: false,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AskScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Desde: Pizzeria',
//             ),
//             Text(
//               'Hasta: Roca 123',
//             ),
//             FlatButton(
//               child: Text("Aceptar Viaje"),
//               onPressed: () {
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }