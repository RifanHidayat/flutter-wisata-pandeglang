
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


import 'package:wisatapandeglang/constant/constant.dart';
import 'package:wisatapandeglang/model/model_wisata.dart';
import 'package:wisatapandeglang/validasi/validator.dart';

class Rencana extends StatefulWidget {
  @override
  _RencanaState createState() => _RencanaState();
}

final String assetName = 'assets/gas-station.svg';
final Widget svgIcon = SvgPicture.asset(
    assetName,
    color: Colors.black38,
    width: 20,
  height: 20,

);

class _RencanaState extends State<Rencana> {
  final _scaffoldKey=new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;
  Validasi validasi = new Validasi();
  var Cname = new TextEditingController();
  var Cpilih = new TextEditingController();
  var Cdana = new TextEditingController();
  var Cjmlkendaraan = new TextEditingController();
  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;


  var Clama = new TextEditingController();
  var Cjml = new TextEditingController();
  var Cdate = new TextEditingController();
  var Ckendaraan = new TextEditingController();
  var wisata_id;
  var kendaraan_id;
  var user_id;

  Map dataWisata;
  List wisataData = [];

  Map dataKendaraan;
  List kendaraanData = [];
  bool loading=false;
  var currentlat,currenlong;



  //get cureent position
  Position _currentPosition;
  String _currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
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


  Future getDatawisata() async {
    setState(() {
      loading=true;
    });
    http.Response response = await http
        .get("https://$base_url/api/wisata");
    dataWisata = jsonDecode(response.body);

    setState(() {
      wisataData = dataWisata["data"];
      //untuk menampilkan di concole

      loading=false;
    });
  }

  Future getDatakendaraan() async {
    setState(() {
      loading=true;
    });
    http.Response response = await http
        .get("https://$base_url/api/kendaraan");
    dataKendaraan = jsonDecode(response.body);
    setState(() {
      kendaraanData = dataKendaraan["data"];
      //untuk menampilkan di concole

      loading=false;
    });
  }




  //------------bottom sheet--------
  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Card(
            elevation: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        //project
                        Text("Daftar WIsata",
                          style: TextStyle(fontFamily: "OpenSans",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                        new Divider(
                          color: Colors.black38,
                        ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/2,
                      child: Container(
                        child:  loading?Center(child: CircularProgressIndicator()):ListView.builder(
                          itemCount: wisataData == null ? 0 : wisataData.length,
                          // ignore: missing_return
                          itemBuilder: (context, index) {
                            return _listitem(index);
                          },
                          //itemCount: wisataData.length+1,

                        ),


                      ),



                    ),


                      ],
                    ),
                  ),
                ],
              ),
            ),


          );
        });
  }

  void _showModalKendaraan() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Card(
            elevation: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //project
                        Text("Daftar Kendaraan",
                          style: TextStyle(fontFamily: "OpenSans",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                        new Divider(
                          color: Colors.black38,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height/2,
                          child:  loading?Center(child: CircularProgressIndicator()):ListView.builder(
                            itemCount: kendaraanData == null ? 0 : kendaraanData.length,
                            // ignore: missing_return
                            itemBuilder: (context, index) {
                              return _listKendaraan(index);
                            },
                            //itemCount: wisataData.length+1,

                          ),


                        ),




                      ],
                    ),
                  ),
                ],
              ),
            ),


          );
        });
  }



  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(

        decoration: InputDecoration(

            hintText: 'Search...'
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            listwisata = listwisata.where((note) {
              var noteTitle = note.place.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    getDataPref();
    getDatawisata();
    getDatakendaraan();
    _getCurrentLocation();


    _showPersBottomSheetCallBack = _showBottomSheet;

  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
      return new Container(
        height: 300.0,
        color: Colors.greenAccent,
        child: new Center(

        ),
      );
    })
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() {
          _showPersBottomSheetCallBack = _showBottomSheet;
        });
      }
    });
  }



  Widget _buildname() {
    return Container(
      child: TextFormField(
        controller: Cname,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Theme.of(context).cursorColor,

        maxLength: 50,
        decoration: InputDecoration(
          icon: Icon(Icons.wallet_travel_sharp),
          labelText: 'Nama Rencana wisata',
          labelStyle: TextStyle(
            color: Colors.black87,
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
      ),
    );
  }

  Widget _builddana() {
    return Container(
      child: TextFormField(
        controller: Cdana,
        keyboardType: TextInputType.number,
        onChanged: (string) {
          string = '${_formatNumber(string.replaceAll('.', ''))}';
          Cdana.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(offset: string.length),
          );
        },
        cursorColor: Theme.of(context).cursorColor,
        maxLength: 50,
        decoration: InputDecoration(

          icon: Icon(Icons.monetization_on),
          labelText: 'Alokasi dana wisata',
          labelStyle: TextStyle(
            color: Colors.black87,
          ),

          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)
          ),
        ),
      ),
    );
  }
  Widget _buildpilihwisata() {
    return InkWell(
      onTap: (){
        _showModalSheet();
      },
      child: Container(
        child: TextFormField(
          enabled: false,
          controller: Cpilih,

          cursorColor: Theme.of(context).cursorColor,
          maxLength: 50,
          decoration: InputDecoration(
            icon: Icon(Icons.label),
            labelText: 'Pilih Wisata',
            labelStyle: TextStyle(
              color: Colors.black87,
            ),

            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black38)
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildpilihkendaraan() {
    return InkWell(
      onTap: (){
        _showModalKendaraan();
      },
      child: Container(
        child: TextFormField(
          enabled: false,
          controller: Ckendaraan,

          cursorColor: Theme.of(context).cursorColor,
          maxLength: 50,
          decoration: InputDecoration(
            icon: Icon(Icons.label),
            labelText: 'Pilih Kendaraan',
            labelStyle: TextStyle(
              color: Colors.black87,
            ),

            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black38)
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildLoginBtn() {
    return Container(

      width: double.infinity,
      height: 40,
      child: OutlineButton(

        onPressed: () {
           //Toast.show("${currenlong.toString()}", context);
          var dana=(Cdana.text.replaceAll(new RegExp(r'[^\w\s]+'),''));
          validasi.validasi_rencana(context, Cname.text,
              dana, Clama.text, Cjml.text,
              Cdate.text.toString().trim(), "", currentlat.toString().trim(), currenlong.toString().trim(),
              kendaraan_id.toString().trim(), wisata_id.toString().trim(), Cjmlkendaraan.text.toString().trim(), user_id.toString().trim());

       //   validasi.validasi_rencana(context, Cname.text, Cdana.text, Clama.text, Cjml.text, Cdate.text, Cpilih.text,photo);

        },
        child: Text('Save'),
      ),
    );

  }





  Widget _buildlamawisata() {
    return Container(
      child: TextFormField(
        controller: Clama,
        keyboardType: TextInputType.number,
        // ignore: deprecated_member_use
        cursorColor: Theme.of(context).cursorColor,

        maxLength: 50,
        decoration: InputDecoration(
          icon: Icon(Icons.tab_outlined),
          labelText: 'lama wisata (Hari)',
          labelStyle: TextStyle(
            color: Colors.black87,
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
      ),
    );
  }


  Widget _buildjml() {
    return Container(

      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: Cjml,
        // ignore: deprecated_member_use
        cursorColor: Theme.of(context).cursorColor,

        maxLength: 50,
        decoration: InputDecoration(
          icon: Icon(Icons.view_compact),
          labelText: 'Jumlah wisatawan',
          labelStyle: TextStyle(
            color: Colors.black87,
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
      ),
    );
  }
  Widget _buildjmlkendaraan() {
    return Container(

      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: Cjmlkendaraan,
        // ignore: deprecated_member_use
        cursorColor: Theme.of(context).cursorColor,

        maxLength: 50,
        decoration: InputDecoration(
          icon: Icon(Icons.view_compact),
          labelText: 'Jumlah kendaraan',
          labelStyle: TextStyle(
            color: Colors.black87,
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
      ),
    );
  }

  Widget _builddate() {
    return InkWell(
      onTap: (){
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(2040, 0, 30),
          theme: DatePickerTheme(
              headerColor: Colors.orange,
              backgroundColor: Colors.blue,
              itemStyle: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
          onChanged: (date) {
            print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
            setState(() {
              Cdate.text=date.toString();
            });
          }, onConfirm: (date) {

            setState(() {
              Cdate.text=date.toString();
            });
          }, currentTime: DateTime.now(), locale: LocaleType.en);
    },

      child: Container(
        child: TextFormField(
          enabled: false,
          controller: Cdate,

          keyboardType: TextInputType.datetime,
          // ignore: deprecated_member_use
          cursorColor: Theme.of(context).cursorColor,



          maxLength: 50,
          decoration: InputDecoration(
            hintText: "20-01-2021",
            icon: Icon(Icons.date_range),
            labelText: 'Tanggal ',
            labelStyle: TextStyle(
              color: Colors.black87,
            ),


            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Rencana",

          style: TextStyle(
            color: Colors.black
          ),

        ),
        backgroundColor: Colors.white,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,

              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 50.0,
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[


                        _buildname(),
                        _builddana(),
                        _buildlamawisata(),
                        _buildjml(),
                        _builddate(),
                        _buildjmlkendaraan(),
                        _buildpilihkendaraan(),
                        _buildpilihwisata(),

                        SizedBox(height: 25,),

                        _buildLoginBtn(),



                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

  _listitem(index){
    return Container(
      margin: EdgeInsets.only(bottom: 20),

      child: Card(

        elevation: 1,
        child: Container(


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Image.network(
                // listwisata[index].photo,
                  wisataData[index]['gambar'],
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.fill
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
              InkWell(
                onTap: () {

                  setState(() {
                    Navigator.of(context).pop();

                    Cpilih.text=wisataData[index]['nama_wisata'];
                    wisata_id=wisataData[index]['id'];
                  });

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
                        Text("PILIH WiSATA",
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

_listKendaraan(index){
    return InkWell(
      onTap: (){
        setState(() {
          kendaraan_id=kendaraanData[index]['id'];
          Ckendaraan.text=kendaraanData[index]['kendaraan'];
          Navigator.of(context).pop();
        });

      },
      child: Container(
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
                        Text(kendaraanData[index]['jenis_kendaraan'].toString(),
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

                                    child:Text(kendaraanData[index]['fuel']['nama_bbm'].toString(),
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
                          Container(child: Text(kendaraanData[index]['kendaraan'],
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
      ),
    );


  }
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {



      user_id = sharedPreferences.getString("id");

    });
  }


}

