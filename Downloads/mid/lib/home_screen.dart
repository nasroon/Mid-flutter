import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:mid/edit_screen.dart';
import 'package:mid/show_screen.dart';
import 'package:mid/student_data.dart';
import 'package:mid/config/slide_route.dart';
import 'package:mid/slide_background.dart';

List<StudentData> student = [
  StudentData(1, "JJ", 80),
  StudentData(2, "Poon", 77),
  StudentData(3, "Geng", 85),
  StudentData(4, "John", 60)
];

final options = LiveOptions(
  delay: Duration(seconds: 1),
  showItemInterval: Duration(milliseconds: 500),
  showItemDuration: Duration(milliseconds: 500),
  visibleFraction: 0.05,
  reAnimateOnVisibility: false,
);

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
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("My List"),
        centerTitle: true,
      ),
      body: LiveList.options(
        options: options,
        itemBuilder: buildAnimatedItem,
        scrollDirection: Axis.vertical,
        itemCount: student.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _awaitReturnValueFromEditScreen(context);
        },
        child: Icon(
          Icons.add,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: buildRow(context, index),
        ),
      );

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

  void _awaitReturnValueFromEditScreen(BuildContext context) async {
    final result =
        await Navigator.push(context, SlideLeftRoute(page: EditScreen()));
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
        SlideLeftRoute(
            page: ShowScreen(
                student: student, std: student[index], selectidx: index)));
    if (result != null) {
      List<String> x = result.split("-");
      setState(() {
        student[int.parse(x[2])] =
            StudentData(int.parse(x[2]) + 1, x[0], int.parse(x[1]));
      });
    }
  }

  void _awaitReturnValueFromEditScreen2(BuildContext context, int i) async {
    final result = await Navigator.push(
        context, SlideLeftRoute(page: EditScreen(std: student[i])));
    if (result != null) {
      List<String> x = result.split("-");
      setState(() {
        student[i] = StudentData(i, x[0], int.parse(x[1]));
      });
    }
  }

  Widget buildRow(BuildContext context, int i) {
    StudentData item = student[i];
    return Dismissible(
      key: Key(item.name),
      background: slideLeftBackground(),
      secondaryBackground: slideRightBackground(),
      child: makeCard(i),
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
                        setState(() {
                          student.removeAt(i);
                          idUpdate();
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          _awaitReturnValueFromEditScreen2(context, i);
        }
      },
    );
  }

  void idUpdate() {
    for (int i = 0; i < student.length; i++) {
      student[i].id = i + 1;
    }
  }

  Widget makeCard(int i) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: buildList(i),
      ),
    );
  }

  Widget buildList(int i) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white))),
          child: Text(
            "${i + 1} ",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          "${student[i].name}",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        //subtitle: Text(" ", style: TextStyle(color: Colors.white)),
        trailing: Container(
          child: Text(
            "${student[i].score}",
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () => {_awaitReturnValueFromShowScreen(context, i)});
  }
}
