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
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        //AppRoutes.show: (context) => ShowScreen(),
        AppRoutes.edit: (context) => EditScreen()
      },
      onGenerateRoute: _registerRWP,
    );
  }

  Route _registerRWP(RouteSettings settings){
    if(settings.name == AppRoutes.show){
      return MaterialPageRoute(builder: (context){
        ShowParameter param = settings.arguments;
        return ShowScreen(name: param.name, score: param.score, id: param.id);
      });
    }
  }

}