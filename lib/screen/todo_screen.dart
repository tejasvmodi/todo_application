import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_application/models/todomodel.dart';
import 'package:todo_application/repositories/todo.dart';
import 'package:todo_application/services/category_service.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _todoTile = TextEditingController();

  final _tododescription = TextEditingController();

  final _tododate = TextEditingController();

  final _categories = <DropdownMenuItem>[];

  // ignore: prefer_typing_uninitialized_variables
  var _selectedvalue;

  @override
  void initState() {
    super.initState();
    _loadcategories();
  }

  _loadcategories() async {
    var categoryservice = CategoryService();
    var categories = await categoryservice.getCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(
          DropdownMenuItem(
            value: category['name'],
            child: Text(category['name']),
          ),
        );
      });
    });
  }

  _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  DateTime _date = DateTime.now();

  _selectTodoDate(BuildContext context) async {
    var pickdate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099),
        initialDate: _date);
    if (pickdate != null) {
      setState(() {
        _date = pickdate;
        _tododate.text = DateFormat('yyyy-MM-dd').format(pickdate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo '),
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
        child: Column(
          children: [
            TextField(
              controller: _todoTile,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: 'Todon Title ',
                  labelText: 'Cook food'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextField(
              maxLines: 3,
              controller: _tododescription,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: 'To-do Description ',
                  labelText: 'Cook rice and cirry '),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextField(
              controller: _tododate,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'YY - MM - DD',
                labelText: 'YY - MM - DD',
                prefixIcon: InkWell(
                  child: const Icon(Icons.calendar_today),
                  onTap: () {
                    _selectTodoDate(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Flexible(
              flex: 3,
              child: DropdownButtonFormField(
                items: _categories,
                value: _selectedvalue,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                hint: const Text('Select the one category'),
                onChanged: (value) {
                  _selectedvalue = value;
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextButton(
                onPressed: () async {
                  var todoObj = Todotable();
                  todoObj.title = _todoTile.text;
                  todoObj.description = _tododescription.text;
                  todoObj.category = _selectedvalue;
                  todoObj.isFinished = 0;
                  todoObj.todoDate = _tododate.text;

                  var todoservice = TodoService();
                  var result = await todoservice.insertTodo(todoObj);

                  // ignore: unrelated_type_equality_checks
                  if (result! > 0) {
                    _showSnackBar('Suceess');
                  }
                },
                child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
