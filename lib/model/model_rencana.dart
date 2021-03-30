class ModelRencana {
  String _name;
  String _data;
  String _lawawisata;
  String _jmlwisatawan;
  String _id_wisata;
  String _id;
  String _photo;

  ModelRencana(this._name, this._data, this._lawawisata, this._jmlwisatawan,this._id_wisata,this._photo);
  ModelRencana.map(dynamic obj) {
    this._name = obj['name'];
    this._data = obj['data'];
    this._lawawisata = obj['lawawisata'];
    this._jmlwisatawan = obj['jmlwisatawan'];
    this._id = obj['id'];
    this._id_wisata = obj['id_wisata'];
    this._photo = obj['photo'];

  }

  String get name => _name;
  String get data => _data;

  String get phone => _lawawisata;
  String get jmlwisatawan => _jmlwisatawan;
  String get id_wisata => _id_wisata;
  String get id=> _id;
  String get lamawisata=> _lawawisata;
  String get photo=> _photo;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = _name;
    map['data'] = _data;
    map['lawawisata'] = _lawawisata;
    map['id_wisata'] = _id_wisata;
    map['id'] = _id;
    map['jmlwisatawan'] = _jmlwisatawan;
    map['photo'] = _photo;

    return map;
  }

  ModelRencana.fromMap(Map<String, dynamic> map) {
    this._name = map['name'];
    this._data = map['data'];
    this._lawawisata = map['lawawisata'];
    this._id = map['id'];
    this._id_wisata = map['id_wisata'];
    this._jmlwisatawan = map['jmlwisatawan'];
    this._photo = map['photo'];
  }
}