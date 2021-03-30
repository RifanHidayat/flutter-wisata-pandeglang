class ModelUser {
  String _username;
  String _phone;
  String _name;
  String _password;
  String _id;
  String _email;

  ModelUser(this._name, this._username, this._email, this._phone,this._password);

  ModelUser.map(dynamic obj) {
    this._username = obj['username'];
    this._name = obj['name'];
    this._phone = obj['phone'];
    this._email = obj['email'];
    this._id = obj['id'];
    this._password = obj['password'];
  }

  String get username => _username;
  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  String get password => _password;
  String get id => _id;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['username'] = _username;
    map['name'] = _name;
    map['phone'] = _phone;
    map['email'] = _email;
    map['id'] = _id;
    map['password'] = _password;
    return map;
  }

  ModelUser.fromMap(Map<String, dynamic> map) {
    this._username = map['username'];
    this._name = map['name'];
    this._email = map['email'];
    this._phone = map['phone'];
    this._password = map['password'];

  }
}