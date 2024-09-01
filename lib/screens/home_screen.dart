import 'package:flutter/material.dart';
import 'package:todo_sqlite/helpers/drawer_navigation.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,

        title: const Text(
          'Todo  Sqlite',
          style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
