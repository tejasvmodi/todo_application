import 'package:flutter/material.dart';
import 'package:todo_application/Helpers/drawer_navigation.dart';
import 'package:todo_application/models/todomodel.dart';
import 'package:todo_application/repositories/todo.dart';
import 'package:todo_application/screen/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoService _todoService;

  List<Todotable> _todolist = <Todotable>[];

  @override
  void initState() {
    super.initState();
    getAlltodo();
  }

  getAlltodo() async {
    _todoService = TodoService();
    _todolist = <Todotable>[];

    var todos = await _todoService.getTodos();
    for (var todo in todos) {
      setState(() {
        var model = Todotable();
        model.id = todo['id'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.description = todo['description'];
        model.isFinished = todo['isFinished'];
        model.title = todo['title'];

        _todolist.add(model);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO APP'),
      ),
      drawer: const Drawernavigation(),
      body: _todolist.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(child: Text(_todolist[index].title)),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _todolist.length,
            )
          : const Center(child: Text('Add Your todo list ')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TodoScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
