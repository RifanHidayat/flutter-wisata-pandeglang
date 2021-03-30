import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wisatapandeglang/page/SplassScreen.dart';
import 'package:wisatapandeglang/theme/theme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wisata Pandeglang',
      debugShowCheckedModeBanner: false,
      theme: lighttheme(),
      darkTheme: darktheme(),
      themeMode: ThemeMode.system,
      home: Splashscreen(),
    );
  }
}
// import 'package:flutter/material.dart';
//
// import 'package:travel/page/SplassScreen.dart';
// import 'package:travel/page/detail_rencana.dart';
//
//
//
// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Wisata Pandeglang',
//       debugShowCheckedModeBanner: false,
//       home: Splashscreen()
//     );
//   }
// }
// import 'package:flare_flutter/flare_actor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:travel/model/WeatherBloc.dart';
// import 'package:travel/model/WeatherModel.dart';
// import 'package:travel/model/WeatherRepo.dart';
//
//
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // Try running your application with "flutter run". You'll see the
//           // application has a blue toolbar. Then, without quitting the app, try
//           // changing the primarySwatch below to Colors.green and then invoke
//           // "hot reload" (press "r" in the console where you ran "flutter run",
//           // or simply save your changes to "hot reload" in a Flutter IDE).
//           // Notice that the counter didn't reset back to zero; the application
//           // is not restarted.
//           primarySwatch: Colors.blue,
//         ),
//         home: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.grey[900],
//           body: SingleChildScrollView(
//             child: BlocProvider(
//               builder: (context) => WeatherBloc(WeatherRepo()),
//               child: SearchPage(),
//             ),
//           ),
//         )
//     );
//   }
// }
//
//
//
//
// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final weatherBloc = BlocProvider.of<WeatherBloc>(context);
//     var cityController = TextEditingController();
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//
//
//         Center(
//             child: Container(
//               child: FlareActor("assets/WorldSpin.flr", fit: BoxFit.contain, animation: "roll",),
//               height: 300,
//               width: 300,
//             )
//         ),
//
//
//
//         BlocBuilder<WeatherBloc, WeatherState>(
//           builder: (context, state){
//             if(state is WeatherIsNotSearched)
//               return Container(
//                 padding: EdgeInsets.only(left: 32, right: 32,),
//                 child: Column(
//                   children: <Widget>[
//                     Text("Search Weather", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
//                     Text("Instanly", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),),
//                     SizedBox(height: 24,),
//                     TextFormField(
//                       controller: cityController,
//
//                       decoration: InputDecoration(
//
//                         prefixIcon: Icon(Icons.search, color: Colors.white70,),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             borderSide: BorderSide(
//                                 color: Colors.white70,
//                                 style: BorderStyle.solid
//                             )
//                         ),
//
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             borderSide: BorderSide(
//                                 color: Colors.blue,
//                                 style: BorderStyle.solid
//                             )
//                         ),
//
//                         hintText: "City Name",
//                         hintStyle: TextStyle(color: Colors.white70),
//
//                       ),
//                       style: TextStyle(color: Colors.white70),
//
//                     ),
//
//                     SizedBox(height: 20,),
//                     Container(
//                       width: double.infinity,
//                       height: 50,
//                       child: FlatButton(
//                         shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                         onPressed: (){
//                           weatherBloc.add(FetchWeather(cityController.text));
//                         },
//                         color: Colors.lightBlue,
//                         child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),
//
//                       ),
//                     )
//
//                   ],
//                 ),
//               );
//             else if(state is WeatherIsLoading)
//               return Center(child : CircularProgressIndicator());
//             else if(state is WeatherIsLoaded)
//               return ShowWeather(state.getWeather, cityController.text);
//             else
//               return Text("Error",style: TextStyle(color: Colors.white),);
//           },
//         )
//
//       ],
//     );
//   }
// }
//
// class ShowWeather extends StatelessWidget {
//   WeatherModel weather;
//   final city;
//
//   ShowWeather(this.weather, this.city);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//           padding: EdgeInsets.only(right: 32, left: 32, top: 10),
//           child: Column(
//             children: <Widget>[
//               Text(city,style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
//               SizedBox(height: 10,),
//
//               Text(weather.getTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 50),),
//               Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       Text(weather.getMinTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
//                       Text("Min Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
//                     ],
//                   ),
//                   Column(
//                     children: <Widget>[
//                       Text(weather.getMaxTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
//                       Text("Max Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//
//               Container(
//                 width: double.infinity,
//                 height: 50,
//                 child: FlatButton(
//                   shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                   onPressed: (){
//                     BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
//                   },
//                   color: Colors.lightBlue,
//                   child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),
//
//                 ),
//               )
//             ],
//           )
//       ),
//     );
//   }
// }
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geocoder/services/base.dart';
//
// void main() => runApp(new MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }
//
// class AppState extends InheritedWidget {
//   const AppState({
//     Key key,
//     this.mode,
//     Widget child,
//   })  : assert(mode != null),
//         assert(child != null),
//         super(key: key, child: child);
//
//   final Geocoding mode;
//
//   static AppState of(BuildContext context) {
//     return context.inheritFromWidgetOfExactType(AppState);
//   }
//
//   @override
//   bool updateShouldNotify(AppState old) => mode != old.mode;
// }
//
// class GeocodeView extends StatefulWidget {
//   GeocodeView();
//
//   @override
//   _GeocodeViewState createState() => new _GeocodeViewState();
// }
//
// class _GeocodeViewState extends State<GeocodeView> {
//   _GeocodeViewState();
//
//   final TextEditingController _controller = new TextEditingController();
//
//   List<Address> results = [];
//
//   bool isLoading = false;
//
//   Future search() async {
//     this.setState(() {
//       this.isLoading = true;
//     });
//
//     try {
//       var geocoding = AppState.of(context).mode;
//       var results = await geocoding.findAddressesFromQuery(_controller.text);
//       this.setState(() {
//         this.results = results;
//       });
//     } catch (e) {
//       print("Error occured: $e");
//     } finally {
//       this.setState(() {
//         this.isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Column(children: <Widget>[
//       new Card(
//         child: new Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: new Row(
//             children: <Widget>[
//               new Expanded(
//                 child: new TextField(
//                   controller: _controller,
//                   decoration: new InputDecoration(hintText: "Enter an address"),
//                 ),
//               ),
//               new IconButton(
//                   icon: new Icon(Icons.search), onPressed: () => search())
//             ],
//           ),
//         ),
//       ),
//       new Expanded(child: new AddressListView(this.isLoading, this.results)),
//     ]);
//   }
// }
//
// class ReverseGeocodeView extends StatefulWidget {
//   ReverseGeocodeView();
//
//   @override
//   _ReverseGeocodeViewState createState() => new _ReverseGeocodeViewState();
// }
//
// class _ReverseGeocodeViewState extends State<ReverseGeocodeView> {
//   final TextEditingController _controllerLongitude =
//   new TextEditingController();
//   final TextEditingController _controllerLatitude = new TextEditingController();
//
//   _ReverseGeocodeViewState();
//
//   List<Address> results = [];
//
//   bool isLoading = false;
//
//   Future search() async {
//     this.setState(() {
//       this.isLoading = true;
//     });
//
//     try {
//       var geocoding = AppState.of(context).mode;
//       var longitude = double.parse(_controllerLongitude.text);
//       var latitude = double.parse(_controllerLatitude.text);
//       var results = await geocoding
//           .findAddressesFromCoordinates(new Coordinates(latitude, longitude));
//       this.setState(() {
//         this.results = results;
//       });
//     } catch (e) {
//       print("Error occured: $e");
//     } finally {
//       this.setState(() {
//         this.isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Column(children: <Widget>[
//       new Card(
//         child: new Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: new Row(
//             children: <Widget>[
//               new Expanded(
//                 child: new Column(
//                   children: <Widget>[
//                     new TextField(
//                       controller: _controllerLatitude,
//                       decoration: new InputDecoration(hintText: "Latitude"),
//                     ),
//                     new TextField(
//                       controller: _controllerLongitude,
//                       decoration: new InputDecoration(hintText: "Longitude"),
//                     ),
//                   ],
//                 ),
//               ),
//               new IconButton(
//                   icon: new Icon(Icons.search), onPressed: () => search())
//             ],
//           ),
//         ),
//       ),
//       new Expanded(child: new AddressListView(this.isLoading, this.results)),
//     ]);
//   }
// }
//
// class _MyAppState extends State<MyApp> {
//   Geocoding geocoding = Geocoder.local;
//
//   final Map<String, Geocoding> modes = {
//     "Local": Geocoder.local,
//     "Google (distant)": Geocoder.google("<API-KEY>"),
//   };
//
//   void _changeMode(Geocoding mode) {
//     this.setState(() {
//       geocoding = mode;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new AppState(
//       mode: this.geocoding,
//       child: new MaterialApp(
//         home: new DefaultTabController(
//           length: 2,
//           child: new Scaffold(
//             appBar: new AppBar(
//               title: new Text('Geocoder'),
//               actions: <Widget>[
//                 new PopupMenuButton<Geocoding>(
//                   // overflow menu
//                   onSelected: _changeMode,
//                   itemBuilder: (BuildContext context) {
//                     return modes.keys.map((String mode) {
//                       return new CheckedPopupMenuItem<Geocoding>(
//                         checked: modes[mode] == this.geocoding,
//                         value: modes[mode],
//                         child: new Text(mode),
//                       );
//                     }).toList();
//                   },
//                 ),
//               ],
//               bottom: new TabBar(
//                 tabs: [
//                   new Tab(
//                     text: "Query",
//                     icon: new Icon(Icons.search),
//                   ),
//                   new Tab(
//                     text: "Coordinates",
//                     icon: new Icon(Icons.pin_drop),
//                   ),
//                 ],
//               ),
//             ),
//             body: new TabBarView(children: <Widget>[
//               new GeocodeView(),
//               new ReverseGeocodeView(),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AddressTile extends StatelessWidget {
//   final Address address;
//
//   AddressTile(this.address);
//
//   final titleStyle =
//   const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);
//
//   @override
//   Widget build(BuildContext context) {
//     return new Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new ErrorLabel(
//               "feature name",
//               this.address.featureName,
//               fontSize: 15.0,
//               isBold: true,
//             ),
//             new ErrorLabel("address lines", this.address.addressLine),
//             new ErrorLabel("country name", this.address.countryName),
//             new ErrorLabel("locality", this.address.locality),
//             new ErrorLabel("sub-locality", this.address.subLocality),
//             new ErrorLabel("admin-area", this.address.adminArea),
//             new ErrorLabel("sub-admin-area", this.address.subAdminArea),
//             new ErrorLabel("thoroughfare", this.address.thoroughfare),
//             new ErrorLabel("sub-thoroughfare", this.address.subThoroughfare),
//             new ErrorLabel("postal code", this.address.postalCode),
//             this.address.coordinates != null
//                 ? new ErrorLabel("", this.address.coordinates.toString())
//                 : new ErrorLabel("coordinates", null),
//           ]),
//     );
//   }
// }
//
// class AddressListView extends StatelessWidget {
//   final List<Address> addresses;
//
//   final bool isLoading;
//
//   AddressListView(this.isLoading, this.addresses);
//
//   @override
//   Widget build(BuildContext context) {
//     if (this.isLoading) {
//       return new Center(child: new CircularProgressIndicator());
//     }
//
//     return new ListView.builder(
//       itemCount: this.addresses.length,
//       itemBuilder: (c, i) => new AddressTile(this.addresses[i]),
//     );
//   }
// }
//
// class ErrorLabel extends StatelessWidget {
//   final String name, text;
//
//   final TextStyle descriptionStyle;
//
//   ErrorLabel(this.name, String text,
//       {double fontSize = 9.0, bool isBold = false})
//       : this.text = text ?? "Unknown $name",
//         this.descriptionStyle = new TextStyle(
//             fontSize: fontSize,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             color: text == null ? Colors.red : Colors.black);
//
//   @override
//   Widget build(BuildContext context) {
//     return new Text(this.text, style: descriptionStyle);
//   }
// }