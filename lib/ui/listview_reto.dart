import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:retos/ui/reto_screen.dart';
import 'package:retos/ui/reto_information.dart';
import 'package:retos/model/reto.dart';

class ListViewReto extends StatefulWidget {
  @override
  _ListViewRetoState createState() => _ListViewRetoState();
}

final retoReference = FirebaseDatabase.instance.reference().child('reto');

class _ListViewRetoState extends State<ListViewReto> {

  List<Reto> items;
  StreamSubscription<Event> _onRetoAddedSubscription;
  StreamSubscription<Event> _onRetoChangedSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _onRetoAddedSubscription = retoReference.onChildAdded.listen(_onRetoAdded);
    _onRetoChangedSubscription = retoReference.onChildChanged.listen(_onRetoUpdate);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onRetoAddedSubscription.cancel();
    _onRetoChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Retos'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 3.0),
              itemBuilder: (context, position){
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 1.0,
                    ),
                    Container(
                      padding: new EdgeInsets.all(3.0),
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            new Container(
                              padding: new EdgeInsets.all(5.0),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${items[position].name}',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 21.0,
                                  ),
                                ),
                                subtitle: Text(
                                  '${items[position].description}',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 21.0,
                                  ),
                                ),
                                onTap: ()=> _navigateToRetoInformation(
                                  context, items[position])),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                              ),
                                  onPressed: () => _showDialog(context, position),
                            ),

                            IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () =>
                              _navigateToReto(context, items[position])),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    )
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.pinkAccent,
          onPressed: () => _createNewReto(context),
        ),
      )
    );
  }


  void _showDialog(context, position)
  {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Estas seguro de querer eliminar este reto'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.purple,
              ),
              onPressed: () =>
              _deleteReto(context, items[position], position),
            ),
            new FlatButton(
              child: Text('Cancelar'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _onRetoAdded(Event event){
    setState(() {
      items.add(new Reto.fromSnapShot(event.snapshot));
    });
  }

  void _onRetoUpdate(Event event){
    var oldProductValue =
        items.singleWhere((reto) => reto.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] =
          new Reto.fromSnapShot(event.snapshot);
    });
  }

  void _deleteReto(
      BuildContext context, Reto reto, int position) async{
    await retoReference.child(reto.id).remove().then( (_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToRetoInformation(
      BuildContext context, Reto reto) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RetoScreen(reto)),
    );
  }

  void _navigateToReto(BuildContext context, Reto reto) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RetoInformation(reto)),
    );
  }

  void _createNewReto(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              RetoScreen(Reto(null, '', '', ''))),
    );
  }

}
