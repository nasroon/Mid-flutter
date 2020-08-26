import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[buildAnswerWidget(), buildNumPadWidget()],
      ),
    );
  }

  Widget buildAnswerWidget() {
    return Container(
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints.expand(height: 180),
        color: Color(0xffecf0f1),
        child: Align(
            alignment: Alignment.bottomRight,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text("8",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
            ])));
  }

  Widget buildNumPadWidget() {
    return Container(
        color: Color(0xffecf0f1),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(children: <Widget>[
              buildNumberButton("7"),
              buildNumberButton("8"),
              buildNumberButton("9"),
            ]),
            Row(children: <Widget>[
              buildNumberButton("4"),
              buildNumberButton("5"),
              buildNumberButton("6"),
            ]),
            Row(children: <Widget>[
              buildNumberButton("1"),
              buildNumberButton("2"),
              buildNumberButton("3"),
            ]),
            Row(children: <Widget>[
              buildNumberButton("CLR"),
              buildNumberButton("0"),
              buildNumberButton("OK"),
            ]),
          ],
        ));
  }

  Expanded buildNumberButton(String str) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.all(2),
            color: Colors.white,
            height: 70,
            child: Center(
                child: Text(str,
                    style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold)))));
  }
}
