import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
class api{
//   void login(BuildContext context, String username, String password) async {
//     final responseData = await http.post("$base_url/RestFullAPi/login", body: {
//       "username": username,
//       "password": password,
//     });
//
//     final data = jsonDecode(responseData.body);
//
//     int value = data['value'];
//     String pesan = data['message'];
//
// // get data respon
//
//
// // cek value 1 atau 0
//     if (value == 1) {
//       Toast.show("$pesan", context, duration: 5, gravity: Toast.BOTTOM);
//       String dtusername = data['detail']['username'];
//       String dtfirst_name = data['detail']['firts_name'];
//       String dtlast_name = data['detail']['last_name'];
//       String dtemail = data['detail']['email'];
//       String dttelp = data['detail']['telp'];
//
//       saveData(value, dtusername, dtfirst_name, dtlast_name, dtemail, dttelp);
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (BuildContext context) => TapBarMenu()),
//         ModalRoute.withName('/LoginScreen'),
//       );
//
//     } else if (value == 0) {
//       Toast.show("$pesan", context, duration: 5, gravity: Toast.BOTTOM);
//
//     }
//   }

  void wather(BuildContext context,String  lat, String long) async {
   // Toast.show("$data", context, duration: 5, gravity: Toast.BOTTOM);
final responseData=await http.get("https://api.openweathermap.org/data/2.5/find?lat=-6.9564071&lon=107.6544534&cnt=1&appid=43ea6baaad7663dc17637e22ee6f78f2");
    final data = json.decode(responseData.body);
final jsonWeather = data["coord"];



    //var pesan = data['list']['coord'];
//Toast.show("$data", context, duration: 5, gravity: Toast.BOTTOM);

Toast.show("$jsonWeather", context, duration: 5, gravity: Toast.BOTTOM);

//
// if (pesan == "accurate") {
//       var kota=data['list']['name'];
//       Toast.show("$data", context, duration: 5, gravity: Toast.BOTTOM);
//
//
//
//     }else{
//       Toast.show("data tidak ditemukan", context, duration: 5, gravity: Toast.BOTTOM);
//     }
  }



}