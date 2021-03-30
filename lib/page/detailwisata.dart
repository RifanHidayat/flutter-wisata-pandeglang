import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisatapandeglang/model/model_favorite.dart';
import 'package:wisatapandeglang/page/Map.dart';
import 'package:wisatapandeglang/screens/homeScreen.dart';
import 'package:wisatapandeglang/services/services.dart';
import 'package:wisatapandeglang/services/weatherapi.dart';


class Detail extends StatefulWidget {
  Detail(
      {this.place,
        this.description,
        this.location,
        this.photo,
        this.lat,
        this.long,
        this.jam_buka,
        this.jam_tutup,
        this.harga_tiket,
        this.id});

  final String place, description, photo, id, location, lat, long,jam_buka,jam_tutup;
  final int harga_tiket;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<ModelFavorite> items = new List();
  DatabaseHelper db = new DatabaseHelper();
  api weather=new api();



  String favorite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              Image.network(
                                widget.photo,
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 150),
                                width: double.maxFinite,
                                height: 100,
                                color: Colors.black26,
                              ),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 170, horizontal: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 25),
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              widget.place,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Flexible(
                                              child: Text(
                                                widget.location,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              _detail1(),

                            ],
                          ),

                        ],
                      ),



                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  Widget _detail1(){
    return Container(
     margin: EdgeInsets.only(top: 260),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.access_time_outlined,
                            color: Colors.green,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(widget.jam_buka),
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.access_time_outlined,
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(widget.jam_tutup),
                        ),


                      ],

                    ),
                  ),
                  SizedBox(height: 5,),


                ],
              ),
              Flexible(
                child: Container(

                  height: 50,
                  width: 230,

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text("Rp ${widget.harga_tiket.toString()}/tiket"),
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
          _detail()
        ],

      ),
    );
  }

Widget _detail(){
    return Container(
      width: double.infinity,

      child:Column(
        children: [
          Container(
            child: Container(
              width: double.infinity,

              child: new Card(
                child: new Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                widget.description,
                                textAlign: TextAlign.justify,
                                style: new TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 300.0,
                        height: 300.0,
                        // Memanggi funsi google map
                        child: GoogleMap(
                            initialCameraPosition:
                            CameraPosition(
                              //set camera to are lokasi/tempat wisata
                                target: LatLng(double.parse(widget.lat),double.parse(widget.long)),
                                zoom: 11.0),
                            markers:
                            Set<Marker>.of(<Marker>[
                              Marker(
                                //set market sesuai lat long dari tempat wisata
                                markerId: MarkerId(
                                    "${widget.id}"),
                                position: LatLng(
                                    double.parse(widget.lat),
                                      double.parse(widget.long),),
                                infoWindow: InfoWindow(
                                    title:
                                    "${widget.place}",
                                    snippet:
                                    " Alamat: ${widget.description}"),
                              ),
                            ]),
                            //funsi untuk menampilkan google maps
                            gestureRecognizers: <
                                Factory<
                                    OneSequenceGestureRecognizer>>[
                              Factory<
                                  OneSequenceGestureRecognizer>(
                                    () =>
                                    ScaleGestureRecognizer(),
                              ),
                            ].toSet()),
                      ),
                    ),
                    _buildMap(),
                    _buildweather()

                  ],
                ),
              ),
            ),
          ),
        ],
      ),


    );

}
  Widget _buildweather() {
    return Container(
      margin: EdgeInsets.all(10),

      width: double.infinity,
      height: 40,
      child: OutlineButton(

        onPressed: () {

          Navigator
              .push(
            context,
            MaterialPageRoute(
                builder: (BuildContext
                context) =>
                    Homescreen(
                      longitudeWisata: widget.long,
                      latitudeWisata: widget.lat,
                      nama_wisata: widget.place,
                    )),);
          //Get.off(Homescreen());

        },
        child: Text('Weather'),
      ),
    );

  }

  Widget _buildMap() {
    return Container(
      margin: EdgeInsets.all(10),

      width: double.infinity,
      height: 40,
      child: OutlineButton(

        onPressed: () {

          Navigator
              .push(
            context,
            MaterialPageRoute(
                builder: (BuildContext
                context) =>
                    Maps(
                      latitudeWisata: widget.lat ,
                      longitudeWisata: widget.long,
                      icon: "current",
                    )),);


        },
        child: Text('Rute'),
      ),
    );

  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      favorite = sharedPreferences.getString("favor");

    });
  }

  @override
  void initState() {


    super.initState();


  }

}

