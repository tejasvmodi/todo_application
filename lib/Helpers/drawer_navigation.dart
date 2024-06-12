import 'package:flutter/material.dart';
import 'package:todo_application/screen/category.dart';
import 'package:todo_application/screen/home_screen.dart';

class Drawernavigation extends StatefulWidget {
  const Drawernavigation({super.key});

  @override
  State<Drawernavigation> createState() => _DrawernavigationState();
}

class _DrawernavigationState extends State<Drawernavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('ToDo App '), accountEmail: Text('category : '),currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.filter_list, color: Colors.white,),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                ),
                ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen(),));
                  },
                ),
                ListTile(
                  title: Text('category'),
                  leading: Icon(Icons.list),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoryScreen(),));
                  },
                ),
                
          ],
        ),
      ),
    );
  }
}