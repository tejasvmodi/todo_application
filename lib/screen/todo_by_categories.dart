import 'package:flutter/material.dart';
import 'package:todo_application/models/todomodel.dart';
import 'package:todo_application/repositories/todo.dart';

class TodoByCategory extends StatefulWidget {
  const TodoByCategory({super.key, required this.category});
  final String category;

  @override
  State<TodoByCategory> createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  List<Todotable> _todolist = <Todotable>[];
  final TodoService _todoService = TodoService();
  @override
  void initState() {
    super.initState();
    gettodosbycategory();
  }

  gettodosbycategory() async {
    _todolist = <Todotable>[];
    var todos = await _todoService.todoBycategory(widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todotable();
        model.title = todo['title'];
        _todolist.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos by Category'),
        ),
        body: Column(
          children: <Widget>[
            Text(widget.category),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text(_todolist[index].title);
                },
                itemCount: _todolist.length,
              ),
            ),
          ],
        ));
  }
}
