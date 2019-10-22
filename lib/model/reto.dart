import 'package:firebase_database/firebase_database.dart';

class Reto{
  String _id;
  String _name;
  String _description;
  String _fecha;

  Reto(this._id, this._name, this._description, this._fecha);

  Reto.map(dynamic obj)
  {
    this._name = obj['name'];
    this._description = obj['description'];
    this._fecha = obj['fecha'];
  }

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get fecha => _fecha;

  Reto.fromSnapShot(DataSnapshot snapshot)
  {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _description = snapshot.value['description'];
    _fecha = snapshot.value['fecha'];
  }

}