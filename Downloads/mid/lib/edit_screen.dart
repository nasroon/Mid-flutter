import 'package:flutter/material.dart';
import 'package:mid/student_data.dart';

class EditScreen extends StatefulWidget {
  final StudentData std;
  EditScreen({this.std});
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String answer;
  bool _validate = false;
  TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    if (widget.std != null) {
      answer = widget.std.score.toString();
    } else
      answer = '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Screen"),
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          buildName(),
          buildAnswerWidget(),
          buildNumPadWidget()
        ],
      )),
    );
  }

  Widget buildName() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Name",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 48,
                    fontWeight: FontWeight.bold)),
            Container(width: 220, child: printTextfeild())
          ],
        ));
  }

  Widget printTextfeild() {
    if (widget.std != null) {
      controller.text = widget.std.name;
    }
    return TextField(
      style: TextStyle(fontSize: 30,color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorText: _validate ? 'Value Can\'t Be Empty' : null,
      ),
    );
  }

  Widget buildAnswerWidget() {
    return Container(
        margin: EdgeInsets.only(top: 80),
        constraints:
            BoxConstraints(minWidth: 100, maxWidth: 300), ////////////////
        padding: EdgeInsets.all(8), //////////////////
        color: Color(0xffdbdbdb),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(answer,
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
                ])));
  }

  Widget buildNumPadWidget() {
    return Container(
        margin: EdgeInsets.only(top: 50), ///////////////////////////
        color: Color(0xffdbdbdb),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(children: <Widget>[
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7);
              }),
              buildNumberButton("8", onTap: () {
                addNumberToAnswer(8);
              }),
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4);
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);
              }),
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);
              }),
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("CLR", onTap: () {
                clearAnswer();
              }),
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0);
              }),
              buildNumberButton("OK", onTap: () {
                setState(() {
                  controller.text.isEmpty
                      ? _validate = true
                      : _validate = false;
                });
                _validate ? errorMessage() : confirmNumber();
              }),
            ]),
          ],
        ));
  }

  void errorMessage() {
    AlertDialog alerterror = AlertDialog(
      title: Text('Error !!'),
      content: const Text("Name can't empty"),
      actions: [
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerterror;
      },
    );
  }

  void confirmNumber() {
    _sendDataBack(context);
  }

  void _sendDataBack(BuildContext context) {
    Navigator.pop(context, '${controller.text}-$answer-');
  }

  void clearAnswer() {
    controller.clear();
    setState(() {
      answer = "0";
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (int.parse(answer) < 10) {
        if (number == 0 && answer == "0") {
          // Not do anything.
        } else if (number != 0 && answer == "0") {
          answer = number.toString();
        } else {
          answer += number.toString();
        }
      }
    });
  }

  Widget buildNumberButton(String str,
      {@required Function() onTap, bool numberButton = true}) {
    Widget widget;
    widget = Container(
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Material(
            color: Colors.blueGrey,
            child: InkWell(
                onTap: onTap,
                splashColor: Colors.blue,
                child: Container(
                    height: 70,
                    child: Center(
                        child: Text(str,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold)))))));

    return Expanded(child: widget);
  }
}
