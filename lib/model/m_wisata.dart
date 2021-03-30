// To parse this JSON data, do
//
//     final wisata = wisataFromJson(jsonString);

import 'dart:convert';

Wisata wisataFromJson(String str) => Wisata.fromJson(json.decode(str));

String wisataToJson(Wisata data) => json.encode(data.toJson());

class Wisata {
  Wisata({
    this.status,
    this.code,
    this.data,
  });

  String status;
  int code;
  List<Datum> data;

  factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
    status: json["status"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.namaWisata,
    this.hargaTiket,
    this.alamat,
    this.deskripsi,
    this.jamBuka,
    this.jamTutup,
    this.latitude,
    this.longitude,
    this.pengelola,
    this.gambar,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.manager,
  });

  int id;
  String namaWisata;
  int hargaTiket;
  String alamat;
  String deskripsi;
  String jamBuka;
  String jamTutup;
  String latitude;
  String longitude;
  int pengelola;
  String gambar;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Manager manager;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namaWisata: json["nama_wisata"],
    hargaTiket: json["harga_tiket"],
    alamat: json["alamat"],
    deskripsi: json["deskripsi"],
    jamBuka: json["jam_buka"],
    jamTutup: json["jam_tutup"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    pengelola: json["pengelola"],
    gambar: json["gambar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    manager: Manager.fromJson(json["manager"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_wisata": namaWisata,
    "harga_tiket": hargaTiket,
    "alamat": alamat,
    "deskripsi": deskripsi,
    "jam_buka": jamBuka,
    "jam_tutup": jamTutup,
    "latitude": latitude,
    "longitude": longitude,
    "pengelola": pengelola,
    "gambar": gambar,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "manager": manager.toJson(),
  };
}

class Manager {
  Manager({
    this.id,
    this.nama,
    this.email,
    this.telepon,
    this.alamat,
    this.foto,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String nama;
  String email;
  String telepon;
  String alamat;
  String foto;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
    id: json["id"],
    nama: json["nama"],
    email: json["email"],
    telepon: json["telepon"],
    alamat: json["alamat"],
    foto: json["foto"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "email": email,
    "telepon": telepon,
    "alamat": alamat,
    "foto": foto,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}