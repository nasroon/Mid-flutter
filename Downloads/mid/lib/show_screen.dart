import 'package:flutter/material.dart';

class ShowParameter {
  final String name, score,id;
  const ShowParameter(this.name, this.score,this.id);
}

class ShowScreen extends StatefulWidget {
  final String name, score,id;
  ShowScreen({this.name, this.score,this.id});

  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Show Screen"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
              ListTile(
                leading: Text(widget.id),
                title: Text(widget.name),
                trailing: Text(
                  widget.score,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),);
  }
}
