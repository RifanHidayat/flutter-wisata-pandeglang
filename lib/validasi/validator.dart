import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


import 'package:wisatapandeglang/page/login.dart';
import 'package:wisatapandeglang/services/services.dart';
import 'package:wisatapandeglang/shared_preferenced/SessionManager.dart';


class Validasi {
  // Servi services = new Services();
  DatabaseHelper db = new DatabaseHelper();
  SharedPreference session=new SharedPreference();

  Future<void> validasi_register(BuildContext context, String nama,
      String email, String username, String password) {

    if (nama.isEmpty) {
      Toast.show("Nama belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (username.isEmpty) {
      Toast.show("Username masi kosong", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (!email.contains("@")) {
      Toast.show("Email tidak valid", context,
          duration: 5, gravity: Toast.BOTTOM);
    }  else if (password.length < 4 || password.length > 15) {
      Toast.show("Minimal password 4 karakter dan Maximal password 15 karakter",
          context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      loading(context);
      db.register(context, username, nama, email, password).then((_){
        Navigator.pop(context);
        Toast.show("Registrasi berhasil",
            context,
            duration: 5, gravity: Toast.BOTTOM);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          ModalRoute.withName('/LoginScreen'),
        );

      });

    }
  }
  Future<void> validasi_update(BuildContext context, String nama,
      String email, String username,String photo,String id) {

    if (nama.isEmpty) {
      Toast.show("Nama belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (username.isEmpty) {
      Toast.show("Username masi kosong", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (!email.contains("@")) {
      Toast.show("Email tidak valid", context,
          duration: 5, gravity: Toast.BOTTOM);
    }else {
      loading(context);
      db.update_profile(context, username, nama, email,photo,id).then((_){
        Navigator.pop(context);
        session.logout();
        Toast.show("berhasil update profile", context, duration: 5, gravity: Toast.BOTTOM);
        session.saveData(1, id, nama, email, photo, username);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          ModalRoute.withName('/LoginScreen'),
        );

      });

    }
  }


  Future<void> validasi_rencana(BuildContext context, String nama_rencana,
      String jumlah_dana, String lama_wisata, String jumlah_wisatawan, String tanggal,String wisata,lat_berangkat,long_berangkat,kendaraan_id,wisata_id,jumlah_kendaraan,pengunjung_id) {

    if (nama_rencana.isEmpty) {
      Toast.show("Nama rencana wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (jumlah_dana.isEmpty) {
      Toast.show("Alokasi dana wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (lama_wisata.isEmpty) {
      Toast.show("Lama wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (jumlah_wisatawan.isEmpty) {
      Toast.show("Jumlah Wisata belum diiisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (tanggal.isEmpty) {
      Toast.show("Tanggal wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    }else if (jumlah_kendaraan.isEmpty) {
      Toast.show("banyak kendaraan belum dimasukan",
          context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (wisata_id.isEmpty) {
      Toast.show("Pilih terlebih dahulu wisata yang ingin dituju",
          context,
          duration: 5, gravity: Toast.BOTTOM);
    }else if (kendaraan_id.isEmpty) {
      Toast.show("Pilih terlebih dahulu kendaraan yang akan digunakan",
          context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      loading(context);
      db.saveRencana(context, nama_rencana, jumlah_dana,
          lama_wisata, jumlah_wisatawan,
          tanggal, jumlah_kendaraan, kendaraan_id,
          wisata_id, lat_berangkat, long_berangkat, pengunjung_id).then((_){


      });

    }
  }
  Future<void> validasi_update_rencana(BuildContext context, String nama_rencana,
      String jumlah_dana, String lama_wisata, String jumlah_wisatawan, String tanggal,String wisata,lat_berangkat,long_berangkat,kendaraan_id,wisata_id,jumlah_kendaraan,pengunjung_id,id) {

    if (nama_rencana.isEmpty) {
      Toast.show("Nama rencana wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (jumlah_dana.isEmpty) {
      Toast.show("Alokasi dana wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (lama_wisata.isEmpty) {
      Toast.show("Lama wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (jumlah_wisatawan.isEmpty) {
      Toast.show("Jumlah Wisata belum diiisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (tanggal.isEmpty) {
      Toast.show("Tanggal wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    }else if (jumlah_kendaraan.isEmpty) {
      Toast.show("banyak kendaraan belum dimasukan",
          context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (wisata_id.isEmpty) {
      Toast.show("Pilih terlebih dahulu wisata yang ingin dituju",
          context,
          duration: 5, gravity: Toast.BOTTOM);
    }else if (kendaraan_id.isEmpty) {
      Toast.show("Pilih terlebih dahulu kendaraan yang akan digunakan",
          context,
          duration: 5, gravity: Toast.BOTTOM);
    } else {
      loading(context);
      db.updateRencana(context, nama_rencana, jumlah_dana,
          lama_wisata, jumlah_wisatawan,
          tanggal, jumlah_kendaraan, kendaraan_id,
          wisata_id, lat_berangkat, long_berangkat, pengunjung_id,id).then((_){


      });

    }
  }


  Future<void> validasi_login(BuildContext context, String username,
      String password) {

    if (username.isEmpty) {
      Toast.show("Username tidak boleh kosong", context,
          duration: 5, gravity: Toast.BOTTOM);
    } else if (password.length < 4 || password.length > 15) {
      Toast.show(
          "Minimal password 4 karakter dan Maximal password 15 karakter",
          context,
          duration: 5,
          gravity: Toast.BOTTOM);
    } else {

   db.login(context, username, password);


//      services.login(context, email, password);


    }
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
  // Future<void> validasi_addDataNote(
  //     BuildContext context, String judul, String isi,String id) {
  //   if (judul.isEmpty) {
  //     Toast.show("Judul note tidak boleh kosong", context,
  //         duration: 5, gravity: Toast.BOTTOM);
  //   } else if (isi.isEmpty) {
  //     Toast.show(
  //         "Note belum diisi",
  //         context,
  //         duration: 5,
  //         gravity: Toast.BOTTOM);
  //   } else if (id.isEmpty){
  //     Toast.show("User tidak ditemukan", context,
  //         duration: 5, gravity: Toast.BOTTOM);
  //
  //   }else {
  //     services.addData(context, judul, isi, id);
  //
  //   }
  // }
//}
