import 'package:flutter/material.dart';
import 'package:mid/config/routes.dart';
import 'package:mid/show_screen.dart';

List<Map> student = [
  {"name": "JJ", "score": "80"},
  {"name": "Poon", "score": "77"},
  {"name": "Geng", "score": "85"},
  {"name": "John", "score": "60"}
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          for (int index = 0; index < student.length; index++)
            GestureDetector(
              onTap: () => {
                Navigator.of(context).pushNamed(AppRoutes.show, arguments: ShowParameter(student[index]["name"],student[index]["score"]))
              },
              child: ListTile(
                leading: Text("${index + 1}"),
                title: Text("${student[index]["name"]}"),
                trailing: Text(
                  "${student[index]["score"]}",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.edit);
        },
        child: Icon(Icons.plus_one),
        backgroundColor: Colors.green,
      ),
    );
  }
}
