import 'package:flutter/material.dart';
import 'package:todo_application/screen/category.dart';
import 'package:todo_application/screen/home_screen.dart';
import 'package:todo_application/screen/todo_by_categories.dart';
import 'package:todo_application/services/category_service.dart';

class Drawernavigation extends StatefulWidget {
  const Drawernavigation({super.key});

  @override
  State<Drawernavigation> createState() => _DrawernavigationState();
}

class _DrawernavigationState extends State<Drawernavigation> {
  final List<Widget> _categtorylist = <Widget>[];
  final CategoryService _category = CategoryService();

 @override
 void initState() {
   super.initState();
   getAllcategory();

 }

  getAllcategory() async {
    var categories = await _category.getCategories();
    categories.forEach((category) {
      setState(() {
        _categtorylist.add(InkWell(
          child: ListTile(
            title: Text(category['name']),
          ),onTap:() {
            Navigator.push(context, MaterialPageRoute(builder:(context) => TodoByCategory(category: category['name']), ));
          },
        ), 
      
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('ToDo App '),
            accountEmail: const Text('category : '),
            currentAccountPicture: GestureDetector(
              child: const CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
          ),
          ListTile(
            title: const Text('category'),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CategoryScreen(),
              ));
            },
          ),
          const Divider(),
          Column(
            children: _categtorylist,
          )
        ],
      ),
    );
  }
}
