import 'package:flutter/material.dart';
import 'package:mid/student_data.dart';

class ShowParameter {
  final List<StudentData> student;
  final StudentData std;
  const ShowParameter(this.student, this.std);
}

class ShowScreen extends StatefulWidget {
  final List<StudentData> student;
  final StudentData std;
  ShowScreen({this.student, this.std});

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
            ),
            Container(
                child: Column(children: [
              InkWell(
                child: Text("Next Person >",
                    style:
                        TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                onTap: () {
                  findNextPerson(findNextPerson(widget.std, widget.student),
                      widget.student);
                  setState(() {});
                },
              ),
              ListTile(
                leading: Text(
                    findNextPerson(widget.std, widget.student).id.toString()),
                title: Text(findNextPerson(widget.std, widget.student).name),
                trailing: Text(
                  findNextPerson(widget.std, widget.student).score.toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ]))
          ])),
    );
  }

  StudentData findNextPerson(StudentData std, List<StudentData> stdlist) {
    List<StudentData> stdlistsort;
    stdlistsort = List.from(stdlist);
    stdlistsort.sort((a, b) => a.score.compareTo(b.score));
    for (int i = 0; i < stdlistsort.length; i++) {
      if (std.score < stdlistsort[i].score) return stdlistsort[i];
    }
    return std;
  }
}
