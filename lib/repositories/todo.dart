

import 'package:todo_application/models/todomodel.dart';
import 'package:todo_application/repositories/repository.dart';

class TodoService {
  late Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  Future<int?> insertTodo(Todotable todo) async {
   
    return await _repository.save('TODO', todo.todoMap());
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    return await _repository.getAll('TODO');
  }

  todoBycategory(String category) async {
    var tej = await _repository.getByColumnName('TODO', 'category', category);
  return tej;
  }
}
