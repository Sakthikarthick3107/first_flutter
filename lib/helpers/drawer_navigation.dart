import 'package:flutter/material.dart';
import 'package:todo_sqlite/screens/categories_screen.dart';
import 'package:todo_sqlite/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.lightBlueAccent),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/man.jpeg'),
                ),
                accountName: Text('Sakthikarthick'),
                accountEmail: Text('sakthikarthick3107@gmail.com')),
            ListTile(
              leading:const Icon(Icons.home_outlined),
              title:const Text(
                'Home',
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) =>const HomeScreen())),
            ),
            ListTile(
              leading:const Icon(Icons.view_list),
              title:const Text(
                'Categories',
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) =>const CategoriesScreen())),
            )
          ],
        ),
      ),
    );
  }
}
