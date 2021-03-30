class ModelFavorite {
  String _place;
  String _location;
  String _lat;
  String _long;
  String _favorite;
  String _description;
  String _id;
  String _photo;

  ModelFavorite(this._place, this._location, this._lat, this._long,this._description,this._favorite,this._photo);

  ModelFavorite.map(dynamic obj) {
    this._place = obj['place'];
    this._location = obj['location'];
    this._lat = obj['lat'];
    this._long = obj['long'];
    this._favorite = obj['favorite'];
    this._id = obj['id'];
    this._description = obj['description'];
    this._photo = obj['photo'];
  }

  String get place => _place;
  String get location => _location;

  String get lat => _lat;
  String get long => _long;
  String get favorite => _favorite;
  String get id => _id;
  String get description => _description;
  String get photo=>_photo;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['place'] = _place;
    map['location'] = _location;
    map['lat'] = _lat;
    map['long'] = _long;

    map['favorite'] = _favorite;
    map['description'] = _description;
    map['photo'] = _photo;
    return map;
  }

  ModelFavorite.fromMap(Map<String, dynamic> map) {
    this._place = map['place'];
    this._location = map['location'];
    this._lat = map['lat'];
    this._long= map['long'];
    this._favorite = map['favorite'];
    this._id = map['id'];
    this._description = map['description'];
    this._photo = map['photo'];
  }
}