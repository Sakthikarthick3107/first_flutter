import 'package:flutter/material.dart';
import 'package:todo_sqlite/screens/home_screen.dart';


void main() => runApp(const App());


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent)
          )
        )
      ),
      home: HomeScreen()
    );
  }
}
