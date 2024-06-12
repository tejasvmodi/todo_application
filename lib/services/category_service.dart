import 'package:todo_application/models/cateogry.dart';
import 'package:todo_application/repositories/repository.dart';

class CategoryService {
  late Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  Future<int?> saveCategory(Category category) async {
    return _repository.save('categories', category.categoryMap());
  }

  getCategories() async{
    return  await _repository.getAll('categories');
  }

   getCategorybyId(categoryId) async {
    return await _repository.getById('categories',categoryId);

  }

  updatecategory(Category category) async {
    return await _repository.update('categories',category.categoryMap());
  }

  deletecategory(categoryId) async{
     return await  _repository.delete('categories',categoryId); 
  }
}
