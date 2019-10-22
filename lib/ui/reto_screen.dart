import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:retos/model/reto.dart';
import 'dart:io';


class RetoScreen extends StatefulWidget {
  final Reto reto;
  RetoScreen(this.reto);
  @override
  _RetoScreenState createState() => _RetoScreenState();
}

final retoReference = FirebaseDatabase.instance.reference().child('reto');

class _RetoScreenState extends State<RetoScreen> {

  List<Reto> items;

  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _fechaController;


  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }
  //fin nuevo imagen

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.reto.name);
    _descriptionController = new TextEditingController(text: widget.reto.description);
    _fechaController = new TextEditingController(text: widget.reto.fecha);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Products DB'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  style: TextStyle(fontSize: 17.0,color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.person),
                      labelText: 'Name'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _descriptionController,
                  style: TextStyle(fontSize: 17.0,color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.list),
                      labelText: 'Description'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _fechaController,
                  style: TextStyle(fontSize: 17.0,color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.monetization_on),
                      labelText: 'Price'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                FlatButton(onPressed: () {
                  if (widget.reto.id != null) {
                    retoReference.child(widget.reto.id).set({
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'fecha': _fechaController.text,
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  } else {
                    retoReference.push().set({
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'price': _fechaController.text,
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                    child: (widget.reto.id != null) ? Text('Update') : Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
