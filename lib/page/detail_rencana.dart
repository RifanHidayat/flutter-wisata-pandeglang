import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:wisatapandeglang/constant/constant.dart';
import 'package:wisatapandeglang/page/Map.dart';
import 'package:wisatapandeglang/page/Updaterencna.dart';
import 'package:wisatapandeglang/page/detailwisata.dart';
import 'package:wisatapandeglang/services/weatherapi.dart';


class detail_rencana extends StatefulWidget {
  @override
  _detail_rencanaState createState() => _detail_rencanaState();
  detail_rencana({
    this.tanggal_wisata,
    this.jumlah_wisatawan,
    this.lama_wisata,
    this.jumlah_dana,

    this.id_wisata,
    this.id_kendaraan,
    this.lat,
    this.long,
    this.jumlah_kendaraan,
    this.nama_rencana,
    this.id

});
  var id,nama_rencana,tanggal_wisata,jumlah_wisatawan,lama_wisata,jumlah_dana,id_kendaraan,id_wisata,lat,long,jumlah_kendaraan;
}

class _detail_rencanaState extends State<detail_rencana> {
api weather=new api();
Map detailWisata,detailKendaraan;
var _tempat_wisata,_harga_tiket,_jarak;
var _merk_kendaraan,_jenis_kendaraan,_nama_bbm,_harga_bbm,_jarak_tempu,_jenis_bbm,_nama_wisata;
final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
var _current_lat,_current_long;
var _jarak_rekomendasi;
var sisaDana=0;
var _latwisata=0.0,_longwisata=0.0;
Map data;
List wisataData = [];
bool loading=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Detail Rencana",

          style: TextStyle(
              color: Colors.black
          ),

        ),
        backgroundColor: Colors.white,

        //Menambahkan Beberapa Action Button
        actions: <Widget>[

          new IconButton(icon: new Icon(Icons.edit, color: Colors.black), onPressed: () {
            Navigator
                .push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext
                  context) =>UpdateRencana(
                    nama_rencana: widget.nama_rencana,
                    tanggal: widget.tanggal_wisata,
                    alokasi_dana: widget.jumlah_dana,
                    lama_wisata: widget.lama_wisata,
                    jumlah_wisatawan: widget.jumlah_wisatawan,
                    jumlah_kendaraan: widget.jumlah_kendaraan,
                    pilih_kendaraan: _jenis_kendaraan,
                    pilih_wisata: _tempat_wisata,
                    id_wisata: widget.id_wisata,
                    id_kendaran: widget.id_kendaraan,
                    id: widget.id,
                  )
              ),);

          },),
        ],
      ),


      body : loading? Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15,right: 15,top: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height+300,
          child: Column(
            children: <Widget>[
              Container(
                child: Text(widget.nama_rencana,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //row  1
                    Container(
                      width: MediaQuery.of(context).size.width/2,


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          //statu absence
                          Container(
                            child: Text("Tanggal wisata",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child: Text("${widget.tanggal_wisata}",
                              style: TextStyle(
                                  color: Colors.black,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          //Type
                          Container(
                            child: Text("Jumlah wisatawan",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child: Text("${widget.jumlah_wisatawan}",
                              style: TextStyle(
                                  color: Colors.black87,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),

                          //statu absence
                          Container(
                            child: Text("Lama Wisata",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child: Text("${widget.lama_wisata} Hari",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          //statu absence
                          SizedBox(height: 20,),
                          Container(
                            child: Text("Alokasi Dana",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child: Text(NumberFormat.currency(locale: 'id',decimalDigits: 0).format(
                                int.parse(widget.jumlah_dana)),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),



                          SizedBox(height: 20,),

                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //statu absence
                          // Container(
                          //   child: Text("Tempat wisata",
                          //     style: TextStyle(
                          //         color: Colors.black38,
                          //         fontSize: 16
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 5,),
                          // Container(
                          //   child: Text("$_tempat_wisata",
                          //     style: TextStyle(
                          //         color: Colors.black87,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 16
                          //     ),
                          //   ),
                          // ),

                          //Type
                          Container(
                            child: Text("Harga tiket",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child:  Text(NumberFormat.currency(locale: 'id',decimalDigits: 0).format(_harga_tiket),
                              style: TextStyle(
                                  color: Colors.black87,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),

                          //Type
                          Container(
                            child: Text("Jarak ",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child: Text("$_jarak KM",
                              style: TextStyle(
                                  color: Colors.black87,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),


                          //statu absence
                          Container(
                            child: Text("Location",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          InkWell(
                            onTap: (){

                              Navigator
                                  .push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext
                                    context) =>
                                        Maps(
                                          latitudeWisata: _latwisata.toString() ,
                                          longitudeWisata: _longwisata.toString(),
                                          icon: "$_merk_kendaraan",
                                        )),);

                            },
                            child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.black12,
                                child: Image.network("",
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.fill,
                                  color: Colors.black,
                                )
                            ),
                          ),
                          SizedBox(height: 20,),

                        ],
                      ),
                    )
                  ],
                ),
              ),
           Container(

             width: double.maxFinite,
             margin:EdgeInsets.all(10),
             child: Column(

               crossAxisAlignment: CrossAxisAlignment.start,

               children: [
                 Text("Kendaraan yang digunakan",

                   style: TextStyle(
                       color: Colors.black,
                       fontSize: 16,
                     fontWeight: FontWeight.bold
                   ),

                 ),
               ],
             ),
           ),
           _buildkendaraan(),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(left: 5),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text("kesimpulan",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold

                  ),
                  ),
                ),
              ],
            ),
          ),
              Container(child: sisaDana<0? _buildSummaryfailed(): _buildSummary()),






            ],
          ),

        ),
      ),
    );
  }
  Widget _buildSummary(){
    return Container(

      width: double.infinity,
      height: 150,
      child: Card(
      child: Container(
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                  child: sisaDana!=null?Flexible(child: Text("Horeyy dana anda mencukupi untuk pergi ke $_tempat_wisata",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white

                  ),
                  )):Text(""),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.all(10),

                    child: Text("Sisan Dana Anda setelah berpergian sebesar ${sisaDana.toString()}",
                      style: TextStyle(
                        color: Colors.white
                      ),

                    )

                ),
              ],
            )
          ],
        ),
      ),
      ),
    );
  }
Widget _buildSummaryfailed(){
  return Center(
    child: Container(

      width: double.infinity,

      child: Card(
        child: Container(
          color: Colors.redAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: sisaDana!=null?Flexible(child: Text("Maaf dana anda tidak mencukupi untuk pergi ke $_tempat_wisata",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white

                      ),
                    )):Text(""),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.all(10),

                      child:Expanded(
                        child: Container(

                          child: Text("Anda kekurangan dana sebesar ${(NumberFormat.currency(locale: 'id',
                              decimalDigits: 0).format(sisaDana))}",
                            style: TextStyle(
                                color: Colors.white
                            ),

                          ),
                        ),
                      )

                  ),
                  SizedBox(height: 20,),

                  Container(

                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Text("Daftar Wisata",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.redAccent,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            height: 200,

                            child: Expanded(

                              child: ListView.builder(
                                  itemCount: wisataData.length,
                                  shrinkWrap: true,


                                  itemBuilder:(context,index){

                                    return _listnofavorite(index);
                                  }),
                            ),

                          ),
                        ),

                      ],

                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildkendaraan(){
    return Container(
      width: double.infinity,
      height: 100,
      child: Card(
        elevation: 1,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 10,right: 10),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(child: Column(
                    children: [
                      Text("${_merk_kendaraan}",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 15

                        ),

                      ),
                    ],
                  )),
                  Flexible(
                    child: Container(

                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(


                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      child:svgIcon
                                  ),

                                  Container(

                                      child: Text(" $_nama_bbm",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 15

                                        ),


                                      )),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),


                ],
              ),
              SizedBox(height: 20,),
              Flexible(
                child: Container(

                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(child: Text("${_jenis_kendaraan}",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),

                        )),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );

  }

_listnofavorite(index){
  return Container(
    width: MediaQuery.of(context).size.width-30,

 color: Colors.white,
 child: Container(
   child: Card(

     elevation: 1,
     child: Container(


       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[

           Container(
             color: Colors.black38,
             child: Image.network(
               "${wisataData[index]['gambar']}",

                 width: double.infinity,
                 height: 100,
                 fit: BoxFit.fill


             ),
           ),
           Container(
               margin: EdgeInsets.all(10),
               child: Text('${wisataData[index]['nama_wisata']}',
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
                       "${wisataData[index]['alamat']}",
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
           SizedBox(height: 10,),
           // Container(
           //   margin: EdgeInsets.only(left: 20),
           //
           //   child: Text("dari alokasi dana anda didapatkan sisa dana sebesar",
           //     style: TextStyle(
           //       color: Colors.green
           //     ),
           //   ),),
           InkWell(
             onTap: () {

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
                     InkWell(
                       onTap: (){
                         Navigator
                             .push(
                           context,
                           MaterialPageRoute(
                               builder: (BuildContext
                               context) =>
                                   Detail(
                                     description: wisataData[index]['deskripsi'],
                                     location: wisataData[index]['alamat'],
                                     place: wisataData[index]['nama_wisata'],
                                     lat: wisataData[index]['latitude'].toString(),
                                     long: wisataData[index]['longitude'].toString(),
                                     photo: wisataData[index]['gambar'].toString(),
                                     jam_buka: wisataData[index]['jam_buka'],
                                     jam_tutup: wisataData[index]['jam_tutup'],
                                     harga_tiket: wisataData[index]['harga_tiket'],
                                   )),);

                       },
                       child: Text("LIHAT DETAIL",
                         style: TextStyle(
                             fontSize: 16,color: Colors.blueAccent
                         ),
                       ),
                     ),
                   ],
                 )),
           )
         ],
       ),
     ),
   ),
 ),
  );
}

  final Widget svgIcon = SvgPicture.asset("assets/gas-station.svg",
    color: Colors.black38,
    width: 20,
    height: 20,


  );

_getDistance(lat_end,long_end) async {
  try {

    // double latstart=double.parse(widget.lat);
    // double longstart=double.parse(widget.long);

    final double d = await Geolocator().distanceBetween(double.parse(widget.lat),double.parse(widget.long),lat_end,long_end);

    setState(() {
      _jarak=(d/1000).round();
    });

  } catch (e) {
    print(e);
  }
}

Future getWisata() async {
      http.Response response = await http
      .get("https://$base_url/api/wisata/${widget.id_wisata}");

  detailWisata = jsonDecode(response.body);
  //Toast.show("${detailWisata['data']['nama_wisata']}", context);

  setState(() {
    _tempat_wisata=detailWisata['data']['nama_wisata'];
    _harga_tiket=detailWisata['data']['harga_tiket'];
    _latwisata= double.parse(detailWisata['data']['latitude']) ;
    _longwisata=double.parse(detailWisata['data']['longitude']);
    _current_lat=widget.lat;
    _current_long=widget.long;

   _getDistance(_latwisata, _longwisata);

  });

}
Future getKendaraan() async {
  http.Response response = await http
      .get("https://$base_url/api/kendaraan/${widget.id_kendaraan}}");

  detailKendaraan = jsonDecode(response.body);


  setState(() {
    _jenis_kendaraan=detailKendaraan['data']['kendaraan'];
    _merk_kendaraan=detailKendaraan['data']['jenis_kendaraan'];
    _jarak_tempu=detailKendaraan['data']['jarak_tempuh'];
    _nama_bbm=detailKendaraan['data']['fuel']['nama_bbm'];
    _harga_bbm=detailKendaraan['data']['fuel']['harga_bbm'];
  _rekomendasi();




  });

}
void _rekomendasi(){
  var bbm=(((_jarak/_jarak_tempu)*_harga_bbm).round()*2);

  var rekomendasi=int.parse(widget.jumlah_dana)-(_harga_tiket*int.parse(widget.jumlah_wisatawan))-(bbm);

  sisaDana=rekomendasi;

  //58.5
//7650

}

Future _getData() async {
  setState(() {
    loading=true;
  });

  http.Response response = await http
      .get("https://$base_url/api/wisata");
  data = jsonDecode(response.body);
  print(data);
  setState(() {
    wisataData = data["data"];
    setState(() {
      loading=false;
    });


  });
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWisata();
    getKendaraan();
    _getData();




}
}