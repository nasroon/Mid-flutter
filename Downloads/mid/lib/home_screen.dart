import 'package:flutter/material.dart';
import 'package:mid/edit_screen.dart';
import 'package:mid/show_screen.dart';
import 'package:mid/student_data.dart';

List<StudentData> student = [
  StudentData(1, "JJ", 80),
  StudentData(2, "Poon", 77),
  StudentData(3, "Geng", 85),
  StudentData(4, "John", 60)
];

class HomeParameter {
  final int id, score;
  final String name;
  HomeParameter(this.id, this.name, this.score);
}

class HomeScreen extends StatefulWidget {
  final int id, score;
  final String name;
  HomeScreen({this.name, this.score, this.id});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List"),
      ),
      body: ListView.builder(
        itemCount: student.length,
        itemBuilder: (BuildContext context, int index) {
          return buildRow(context, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _awaitReturnValueFromEditScreen(context);
        },
        child: Icon(Icons.plus_one),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _awaitReturnValueFromEditScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditScreen(),
        ));
    if (result != null) {
      List<String> x = result.split("-");
      setState(() {
        student.add(StudentData(student.length + 1, x[0], int.parse(x[1])));
      });
    }
  }

  void _awaitReturnValueFromShowScreen(BuildContext context, int index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowScreen(
              student: student, std: student[index], selectidx: index),
        ));
    if (result != null) {
      List<String> x = result.split("-");
      setState(() {
        student[int.parse(x[2])] =
            StudentData(int.parse(x[2]) + 1, x[0], int.parse(x[1]));
      });
    }
  }

  void _awaitReturnValueFromEditScreen2(BuildContext context,int i) async{
    final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditScreen(std: student[i]),
              ));
          if (result != null) {
            List<String> x = result.split("-");
            setState(() {
              student[i] =
                  StudentData(i, x[0], int.parse(x[1]));
              print(result);
            });
          }
  }

  Widget buildRow(BuildContext context, int i) {
    StudentData item = student[i];
    return Dismissible(
      key: Key(item.name),
      background: slideLeftBackground(),
      secondaryBackground: slideRightBackground(),
      child: ListTile(
          leading: Text("${i + 1} "),
          title: Text("${student[i].name}"),
          trailing: Container(
            child: Text(
              "${student[i].score}",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () => {_awaitReturnValueFromShowScreen(context, i)}),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                      "Are you sure you want to delete ${student[i].name}?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        // TODO: Delete the item from DB etc..
                        setState(() {
                          student.removeAt(i);
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          _awaitReturnValueFromEditScreen2(context,i);
        }
      },
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
