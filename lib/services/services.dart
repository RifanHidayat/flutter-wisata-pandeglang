import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;
import 'package:wisatapandeglang/constant/constant.dart';
import 'package:wisatapandeglang/model/m_wisata.dart';
import 'package:wisatapandeglang/model/model_favorite.dart';
import 'package:wisatapandeglang/model/model_user.dart';
import 'package:wisatapandeglang/page/navbar.dart';
import 'package:wisatapandeglang/shared_preferenced/SessionManager.dart';


class DatabaseHelper {
  SharedPreference session = new SharedPreference();
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  //table
  final String tableuser = 'tbuser';
  final String tablerencana = 'rencana';
  final String tablerencana1 = 'tbrencana';
  final String tablefavorite = 'favorite';
  final String tablefavorite1 = 'trfavorite';

  //column user
  final String id_user = 'id';
  final String username_user = 'username';
  final String name_user = 'name';
  final String phone_user = 'phone';
  final String password_user = 'password';
  final String email_user = 'email';

  //colum add rencana

  final String id_rencana = 'id';
  final String photo_rencana = 'photo';
  final String name_rencana = 'name';
  final String jmlwisatwan_rencana = 'jmlwisatawan';
  final String lamawisata_rencana = 'lawawisata';
  final String dana_rencana = 'data';

  final String id_wisata_rencana = 'id_wisata';
  //colum add favorite
  final String id_favorite = 'id';
  final String photo_favorite = 'photo';
  final String place_favorite = 'place';
  final String location_favorite= 'location';
  final String lat_favorite = 'lat';
  final String long_favorite = 'long';
  final String description_favorite = 'description';
  final String favorite = 'favorite';
  static Database _db;


  DatabaseHelper.internal();


  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'travel.db');
    var db = await openDatabase(path, version: 3, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int NewViersion) async {
    await db.execute(
        'CREATE TABLE $tablefavorite($id_favorite INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL, $place_favorite TEXT, $location_favorite TEXT,$lat_favorite TEXT, $long_favorite TEXT,$description_favorite Text,$favorite Text,$photo_rencana Text)');
    await db.execute(
        'CREATE TABLE $tablerencana($id_rencana INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL, $name_rencana TEXT, $dana_rencana TEXT,$jmlwisatwan_rencana TEXT, $lamawisata_rencana TEXT,$id_wisata_rencana Text,$photo_favorite Text)');

    await db.execute(
        'CREATE TABLE $tableuser($id_user INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL, $username_user TEXT, $name_user TEXT,$phone_user TEXT, $email_user TEXT,$password_user Text)');
    // await db.execute(
    //     'CREATE TABLE $tablefavorite1($id_favorite INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL, $place_favorite TEXT, $location_favorite TEXT,$lat_favorite TEXT, $long_favorite TEXT,$description_favorite Text,$favorite Text)');
    // await db.execute(
    //     'CREATE TABLE $tablerencana1($id_rencana INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL, $name_rencana TEXT, $dana_rencana TEXT,$jmlwisatwan_rencana TEXT, $lamawisata_rencana TEXT,$id_wisata_rencana Text)');
    //

    //table baru


  }
//registrasi user
  Future<int> saveUser(ModelUser user,BuildContext context) async {

    var dbClient = await db;
    var result = await dbClient.insert(tableuser, user.toMap());

    return result;
  }

  //login user
  Future<ModelUser> doLogin(
      BuildContext context, String username, String password) async {

    var dbClient = await db;

    var res = await dbClient.rawQuery(
        "SELECT * FROM $tableuser WHERE $username_user = '$username' and $password_user = '$password'");

    if (res.length == 1) {
      var d = ModelUser.fromMap(res.first);
      var username = d.username;
      var email = d.email;
      var phone = d.phone;
      var name = d.name;
      var id = d.id;
      var value = 1;


      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Navbar()),
        ModalRoute.withName('/LoginScreen'),
      );
      Toast.show("Berhasil mekalkukan Login", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Periksa lagi username dan password anda", context,
          duration: 5, gravity: Toast.BOTTOM);
    }

  }

  Future<ModelUser> getFavorite(


      BuildContext context, String place) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();


    var dbClient = await db;

    var res = await dbClient.rawQuery(
        "SELECT * FROM $tablefavorite WHERE $place_favorite = '$place'");

    if (res.length == 1) {


      var d = ModelFavorite.fromMap(res.first);
      sharedPreferences.setString("favor",d.favorite);

      //return d;

    } else {

      sharedPreferences.setString("favor","0");


    }

  }


    Future<int> saveFavorite(ModelFavorite favor,BuildContext context) async {
    var dbClient = await db;
    var result = await dbClient.insert(tablefavorite, favor.toMap());
    return result;
  }
  Future<int> updateFavorite(ModelFavorite favor) async {
    var dbClient = await db;
    return await dbClient.update(tablefavorite, favor.toMap(),
        where: "$place_favorite = ?", whereArgs: [favor.place]);
  }


  //Get All favorite
  Future<List> getAllfavorite() async {
    var dbClient = await db;
    var result = await dbClient.query(tablefavorite, columns: [

      place_favorite,
      location_favorite,
      lat_favorite,
      long_favorite,
      description_favorite,
      favorite,

    ]);
    return result.toList();
  }

  //Get All Pegawai
  Future<List> getAllRencana() async {
    var dbClient = await db;
    var result = await dbClient.query(tablerencana, columns: [


      name_rencana,
      jmlwisatwan_rencana,
      lamawisata_rencana,
      dana_rencana

    ]);
    return result.toList();
  }


//Delete Mahasiswa
  Future<int> deleteData( BuildContext context, String id) async {
    final responseData = await http.delete("https://$base_url/api/rencana/$id");

    final data = jsonDecode(responseData.body);

    var code = data['code'];
    Toast.show("$data", context, duration: 5, gravity: Toast.BOTTOM);
//cek value 1 atau 0
    if (code == 200) {
      Toast.show("Berhasil menghapus rencana", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);

    }else{
      Toast.show("terjadi kesalahan", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);

    }

  }


  Future<void> register(BuildContext context, String username, String name,String email, String password) async {

    final responseData = await http.post("https://$base_url/api/pengunjung/register", body: {
      "name": name.toString().trim(),
      "email": email.toString().trim(),
      "password": password,
      "username": username.toString().trim(),

    });

    final data = jsonDecode(responseData.body);

    var code = data['code'];
//cek value 1 atau 0
    if (code == 200) {
      Toast.show("Registrasi berhasiil", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    }else{
      Toast.show("gagal registrasi", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);

    }
  }
  Future<void> update_profile(BuildContext context, String username, String name,String email,String photo,String id) async {

    final responseData = await http.patch("https://$base_url/api/pengunjung/$id", body: {
      "name": name.toString().trim(),
      "email": email.toString().trim(),
      "username": username.toString().trim(),
    });
    final data = jsonDecode(responseData.body);

    var code = data['code'];
//cek value 1 atau 0
    if (code == 200) {
      session.logout();
      Toast.show("berhasil update profile", context, duration: 5, gravity: Toast.BOTTOM);
      session.saveData(1, id, name, email, photo, username);
      Navigator.pop(context);
    }else{
      Toast.show("gagal update Profile", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);

    }
  }

  Future<void> saveRencana(BuildContext context, String nama_rencana, String jumlah_dana,
      String lama_wisata, String jumlah_wisatawan,
      tanggal,jumlah_kendaraan,kendaraan_id,wisata_id,latitude_berangkat,longitude_berangkat,pengujung_id) async {
    final responseData = await http.post("https://$base_url/api/rencana", body: {
      "nama_rencana": nama_rencana.toString().trim(),
      "jumlah_dana": jumlah_dana.toString().trim(),
      "jumlah_wisatawan":jumlah_wisatawan.toString().trim(),
      "lama_wisata": lama_wisata.toString().trim(),
      "latitude_berangkat": latitude_berangkat.toString().trim(),
      "longitude_berangkat": longitude_berangkat.toString().trim(),
      "kendaraan_id": kendaraan_id.toString().trim(),
      "jumlah_kendaraan": jumlah_kendaraan.toString().trim(),
      "wisata_id": wisata_id.toString().trim(),
      "pengunjung_id": pengujung_id.toString().trim(),
      "tanggal_wisata":tanggal.toString().trim(),

    });

    final data = jsonDecode(responseData.body);


    var code = data['code'];
//cek value 1 atau 0
    if (code == 200) {
      Toast.show("Berhasil menambahkan rencana", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Navbar()), (Route<dynamic> route) => false);

    }else{
      Toast.show("gagal menambahkan rencana", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);


    }
  }
  Future<void> updateRencana(BuildContext context, String nama_rencana, String jumlah_dana,
      String lama_wisata, String jumlah_wisatawan,
      tanggal,jumlah_kendaraan,kendaraan_id,wisata_id,latitude_berangkat,longitude_berangkat,pengujung_id,id) async {
    final responseData = await http.patch("https://$base_url/api/rencana/$id", body: {
      "nama_rencana": nama_rencana.toString().trim(),
      "jumlah_dana": jumlah_dana.toString().trim(),
      "jumlah_wisatawan":jumlah_wisatawan.toString().trim(),
      "lama_wisata": lama_wisata.toString().trim(),
      "latitude_berangkat": latitude_berangkat.toString().trim(),
      "longitude_berangkat": longitude_berangkat.toString().trim(),
      "kendaraan_id": kendaraan_id.toString().trim(),
      "jumlah_kendaraan": jumlah_kendaraan.toString().trim(),
      "wisata_id": wisata_id.toString().trim(),
      "pengunjung_id": pengujung_id.toString().trim(),
      "tanggal_wisata":tanggal.toString().trim(),

    });

    final data = jsonDecode(responseData.body);


    var code = data['code'];
//cek value 1 atau 0
    if (code == 200) {
      Toast.show("Berhasil update rencana", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Navbar()), (Route<dynamic> route) => false);

    }else{
      Toast.show("gagal update rencana", context, duration: 5, gravity: Toast.BOTTOM);
      Navigator.pop(context);


    }
  }


  void login(BuildContext context, String username, String password) async {
    loading(context);
    final responseData = await http.post("https://$base_url/api/pengunjung/login", body: {
      "email": username.toString().trim(),
      "password": password,
    });

    final data = jsonDecode(responseData.body);



var code=data['error'];


    if (code == false) {
      Navigator.pop(context);
      Toast.show("Berhasil Login", context,
          duration: 5, gravity: Toast.BOTTOM);

      String nama = data['data']['nama'];

      String email = data['data']['email'];
      String foto = data['data']['foto'];
      int id = data['data']['id'];

      session.saveData(1, id.toString(), nama, email, foto, username);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Navbar()),
        ModalRoute.withName('/LoginScreen'),
      );





      // saveData(value, dtusername, dtfirst_name, dtlast_name, dtemail, dttelp);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (BuildContext context) => Navbar()),
      //   ModalRoute.withName('/LoginScreen'),
      // );

    }else{
      Navigator.pop(context);
      Toast.show("Username atau password tidak tersedia", context,
          duration: 5, gravity: Toast.BOTTOM);

    }
  }

  static Future<List<Wisata>> getWisata(BuildContext context) async{
    try{
      Toast.show("tte", context,
          duration: 5, gravity: Toast.BOTTOM);
      final respon=await http.get("https://bba332c5f77b.ngrok.io/api/wisata");
      if (200==respon.statusCode){
        final List<Wisata> wisata = wisataFromJson(respon.body) as List<Wisata>;
        Toast.show(respon.body.toString(), context,
            duration: 5, gravity: Toast.BOTTOM);
        print(wisata);
        return wisata;


      }else{
        return List<Wisata>();
      }

  } catch(e){
      return List<Wisata>();


  }

}

//alert loading
  void loading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(

              content:Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Loading...."),
                    SizedBox(height: 30,),
                    CircularProgressIndicator(

                      backgroundColor: Colors.blue[250],

                    ),
                  ],
                ),



              )

          );

        }
    );


  }

}