import 'package:flutter/material.dart';
import 'package:mid/config/routes.dart';
import 'package:mid/edit_screen.dart';
import 'package:mid/home_screen.dart';
import 'package:mid/show_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "navigator",
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.show: (context) => ShowScreen(),
        AppRoutes.edit: (context) => EditScreen()
      },
    );
  }
}
