import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;
import 'package:wisatapandeglang/constant/constant.dart';
import 'package:wisatapandeglang/model/model_favorite.dart';
import 'package:wisatapandeglang/model/model_rencana.dart';
import 'package:wisatapandeglang/page/detail_rencana.dart';
import 'package:wisatapandeglang/page/detailwisata.dart';
import 'package:wisatapandeglang/page/rencana.dart';
import 'package:wisatapandeglang/services/services.dart';
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  List<ModelFavorite> itemsFavorite = new List();
  List<ModelRencana> itemsRencana = new List();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  String _currentAddress;
  DatabaseHelper db = new DatabaseHelper();

  Map dataRencana;
  List _rencana=[];

  var _loading=false;
  var id_pengunjung;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Rencana()),
        );
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blueAccent,
    ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Home",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),

      body: Container(
        child: Container(

          color: Colors.white38,
          child: Container(
            child: _loading?Center(child: CircularProgressIndicator(),): _rencana.length==0?_listnorencana():ListView.builder(
                itemCount: _rencana.length,
                itemBuilder:(context,indext){

                  return _listrencana(indext);
                }),

          ),

        ),
      ),

    );
  }
  //------ widget project----
  Widget _listrencana(index){
    return Center(
      child: Container(

          width: double.infinity,
          child:Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 5,left: 5,top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Text("${_rencana[index]['nama_rencana']}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 5,),



                              SizedBox(height: 5,),
                              Text(NumberFormat.currency(locale: 'id',decimalDigits: 0).format(
                                _rencana[index]['jumlah_dana']),

                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.green
                                ),
                              ),
                              SizedBox(height: 10,),

                              Container(
                                  width: double.infinity,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end ,
                                    children: <Widget>[
                                      //button detail
                                      new RaisedButton(
                                        padding: const EdgeInsets.all(8.0),
                                        textColor: Colors.white,
                                        color: Colors.blueAccent,

                                        onPressed: (){

                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>detail_rencana(
                                                jumlah_dana: dataRencana['data'][index]['jumlah_dana'].toString(),
                                                jumlah_wisatawan: dataRencana['data'][index]['jumlah_wisatawan'].toString(),
                                                tanggal_wisata: dataRencana['data'][index]['tanggal_wisata'].toString(),
                                                lama_wisata: dataRencana['data'][index]['lama_wisata'].toString(),
                                                id_kendaraan: dataRencana['data'][index]['kendaraan_id'].toString(),
                                                id_wisata: dataRencana['data'][index]['wisata_id'].toString(),
                                                long: dataRencana['data'][index]['longitude_berangkat'].toString(),
                                                lat: dataRencana['data'][index]['latitude_berangkat'].toString(),
                                                jumlah_kendaraan: dataRencana['data'][index]['jumlah_kendaraan'].toString(),
                                                nama_rencana: dataRencana['data'][index]['nama_rencana'].toString(),
                                                id: dataRencana['data'][index]['id'].toString(),

                                              )
                                          ));
                                        },
                                        child: new Text("Detail"),
                                      ),


                                      //button budgeting

                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: new  OutlineButton(
                                          onPressed: () {

                                            alert("${_rencana[index]['id']}");
                                          },
                                          child: Text('Hapus',
                                            style: TextStyle(color: Colors.black87),
                                          ),
                                        ),
                                      )


                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

          )
      ),
    );
  }

  void alert(String data) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: new Text("Apakah anda yakin menghapus rencana ini?"),
            actions: <Widget>[
              new RaisedButton(
                  child: new Text(
                    'Iya',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    // // ignore: unnecessary_statements
                    db.deleteData(context,data).then((_) {

                      setState(() {
                        getAllRencana(id_pengunjung);


                      });

                      Toast.show("Berhasil menghapus data", context,
                          duration: 5, gravity: Toast.BOTTOM);


                    });
                  }),
              FlatButton(
                  child: new Text(
                    'Batalkan',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black12,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  _listnorencana(){
    return Center(
      child: Container(
        width: double.infinity,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.work_off_rounded,
              color: Colors.black12,
              size: 80,
            ),
            SizedBox(height: 20,),
            Text("Belum terdapat rencana",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black38
              ),
            ),

          ],
        ),
      ),
    );
  }
  _listfavorite(int index){
    return Container(
      child: Card(
        elevation: 1,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Image.network(
              itemsFavorite[index].favorite,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.fill
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text(itemsFavorite[index].place,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.black38,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          itemsFavorite[index].location,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black38
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator
                      .push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext
                        context) =>
                            Detail(
                              description: itemsFavorite[index].description,
                              location: itemsFavorite[index].location,
                              place: itemsFavorite[index].place,
                              lat: itemsFavorite[index].lat,
                              long: itemsFavorite[index].long,
                              // photo: listwisata[index].photo,
                            )),);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10,bottom: 10
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("LIHAT DETAIL",
                          style: TextStyle(
                              fontSize: 16,color: Colors.blueAccent
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
  _listnofavorite(){
    return Container(
      width: double.infinity,
      height: 200,
      child: Card(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.fact_check,
              color: Colors.black12,
              size: 80,
            ),
            SizedBox(height: 20,),
            Text("Belum tersedia rekomendasi wisata anda",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black38
              ),
            )
          ],
        ),
      ),
    );
  }
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id_pengunjung = sharedPreferences.getString("id");
      print(id_pengunjung);
   getAllRencana(id_pengunjung);




    });
  }
    //  .get("https://fcb9c86f3e09.ngrok.io/api/pengunjung/$id/rencana");
  //get all rencana
  Future getAllRencana(id) async {
    setState(() {
      _loading=true;
    });
    http.Response response = await http
        .get("https://$base_url/api/pengunjung/$id/rencana");

    dataRencana = jsonDecode(response.body);
    setState(() {
      _rencana=dataRencana['data'];
    });






    setState(() {

      _loading=false;
    });
  }

  _getAddressFromLatLng(lat,long) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          lat, long);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPref();

  }
}

