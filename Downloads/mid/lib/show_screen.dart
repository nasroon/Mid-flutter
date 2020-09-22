import 'package:flutter/material.dart';
import 'package:mid/edit_screen.dart';
import 'package:mid/home_screen.dart';
import 'package:mid/student_data.dart';
import 'package:mid/config/slide_route.dart';
import 'package:slimy_card/slimy_card.dart';

class ShowParameter {
  final List<StudentData> student;
  final StudentData std;
  final int selectidx;
  const ShowParameter(this.student, this.std, this.selectidx);
}

class ShowScreen extends StatefulWidget {
  final List<StudentData> student;
  final StudentData std;
  final int selectidx;
  List<StudentData> studentsorted;
  ShowScreen({this.student, this.std, this.selectidx}) {
    studentsorted = List.from(student);
    studentsorted.sort((a, b) => a.score.compareTo(b.score));
  }

  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  int _nextPersonDataIdx;
  bool _isAlreadyTop = false;

  @override
  void initState() {
    _nextPersonDataIdx =
        widget.studentsorted.indexOf(student[widget.selectidx]) + 1;
    if (_nextPersonDataIdx >= widget.studentsorted.length) {
      _nextPersonDataIdx = widget.studentsorted.length - 1;
      _isAlreadyTop = true;
    }
    super.initState();
  }

  void _getNextPerson() {
    setState(() {
      if (++_nextPersonDataIdx >= widget.studentsorted.length - 1) {
        _nextPersonDataIdx = widget.studentsorted.length - 1;
        _isAlreadyTop = true;
      }
    });
  }

  void _awaitReturnValueFromEditScreen(BuildContext context) async {
    final result = await Navigator.push(
        context, SlideLeftRoute(page: EditScreen(std: widget.std)));
    if (result != null) {
      Navigator.pop(context, result + widget.selectidx.toString());
    }
  }

  Widget printNext() {
    if (_isAlreadyTop) {
      return InkWell(
        child: Text("TOP",
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
      );
    } else
      return InkWell(
        child: Text("Next Person >",
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
        onTap: () {
          _getNextPerson();
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _awaitReturnValueFromEditScreen(context);
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                makeCard(),
                Container(
                    color: Colors.amberAccent,
                    child: Column(children: [
                      printNext(),
                      ListTile(
                        leading: Text(
                          widget.studentsorted[_nextPersonDataIdx].id
                              .toString(),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          widget.studentsorted[_nextPersonDataIdx].name,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          widget.studentsorted[_nextPersonDataIdx].score
                              .toString(),
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]))
              ])),
    );
  }

  Widget makeCard() {
    return SlimyCard(
      color: Colors.blueGrey,
      //width: 200,
      topCardHeight: 300,
      bottomCardHeight: 100,
      borderRadius: 15,
      topCardWidget: topCardWidget(),
      bottomCardWidget: bottomCardWidget(),
      slimeEnabled: true,
    );
  }

  Widget topCardWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.green,
                child: Text(
                  widget.std.id.toString(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 1),
          Container(
              child: CircleAvatar(
            radius: 68,
            backgroundColor: Colors.black38,
            child: Text(
              widget.std.name.substring(0, 2) + '.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          )),
          SizedBox(height: 8),
          Text(
            'Name : ' + widget.std.name,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Score : ' + widget.std.score.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 25),
        ]);
  }

  Widget bottomCardWidget() {
    return Text(
      'Ranking : ' + findRank(widget.std, widget.studentsorted).toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  int findRank(StudentData std, List<StudentData> students) {
    for (int i = 0; i < students.length; i++) {
      if (std == students[i]) {
        return students.length - i;
      }
    }
  }
}
