import 'package:flutter/material.dart';
import 'package:mid/edit_screen.dart';
import 'package:mid/home_screen.dart';
import 'package:mid/student_data.dart';

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
      print("ALREADY TOP!");
      _isAlreadyTop = true;
    }
    super.initState();
  }

  void _getNextPerson() {
    setState(() {
      if (++_nextPersonDataIdx >= widget.studentsorted.length - 1) {
        _nextPersonDataIdx = widget.studentsorted.length - 1;
        print("TOP!");
        _isAlreadyTop = true;
      }
    });
  }

  void _awaitReturnValueFromEditScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditScreen(std : widget.std),
        ));
    if (result != null) {
      Navigator.pop(context, result+widget.selectidx.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Screen"),
      ),
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            ListTile(
              leading: Text(widget.std.id.toString()),
              title: Text(widget.std.name),
              trailing: Text(
                widget.std.score.toString(),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _awaitReturnValueFromEditScreen(context);
              },
            ),
            Container(
                child: Column(children: [
              InkWell(
                child: Text("Next Person >",
                    style:
                        TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                onTap: () {
                  _getNextPerson();
                },
              ),
              ListTile(
                leading: Text(
                    widget.studentsorted[_nextPersonDataIdx].id.toString()),
                title: Text(widget.studentsorted[_nextPersonDataIdx].name),
                trailing: Text(
                  widget.studentsorted[_nextPersonDataIdx].score.toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ]))
          ])),
    );
  }
}
