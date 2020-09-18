import 'package:flutter/material.dart';
import 'package:mid/config/routes.dart';
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
          _awaitReturnValueFromSecondScreen(context);
        },
        child: Icon(Icons.plus_one),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
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

  Widget buildRow(BuildContext context, int index) {
    return ListTile(
        leading: Text("${student[index].id} "),
        title: Text("${student[index].name}"),
        trailing: Text(
          "${student[index].score}",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        onTap: () => {
              Navigator.of(context)
                  .pushNamed(AppRoutes.show, arguments: ShowParameter(student,student[index]))
            });
  }
}
