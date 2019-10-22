import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:retos/model/reto.dart';


class RetoInformation extends StatefulWidget {
  final Reto reto;
  RetoInformation(this.reto);
  @override
  _RetoInformationState createState() => _RetoInformationState();
}

final retoReference = FirebaseDatabase.instance.reference().child('reto');

class _RetoInformationState extends State<RetoInformation> {

  List<Reto> items;

 // String productImage;//nuevo

  @override
  void initState() {
    super.initState();
   // productImage = widget.product.productImage;//nuevo
   // print(productImage);//nuevo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reto Information y Foto'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                new Text("Name : ${widget.reto.name}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Description : ${widget.reto.description}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Price : ${widget.reto.fecha}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                Container(
                  height: 300.0,
                  width: 300.0,
                  child: Center(
                 ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
