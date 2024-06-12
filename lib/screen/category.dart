import 'package:flutter/material.dart';
import 'package:todo_application/models/cateogry.dart';
import 'package:todo_application/services/category_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  var categoryname = TextEditingController();
  var categorydescription = TextEditingController();

  var _category = Category();
  var _categoryservice = CategoryService();

  List<Category> _categorylist = <Category>[];

  var editcategoryname = TextEditingController();
  var editcategorydescription = TextEditingController();

  var category;

  @override
  void initState() {
    super.initState();
    getAllCategories();
    setState(() {});
  }

  getAllCategories() async {
    _categorylist = <Category>[];

    var categories = await _categoryservice.getCategories();
    categories.forEach((category1) {
      setState(() {
        print(category1['name']);

        var model = Category();
        model.name = category1['name'];
        model.id = category1['id'];
        model.description = category1['description'];
        _categorylist.add(model);
      });
    });
  }

  _showFormInDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel')),
            TextButton(
                onPressed: () async {
                  _category.name = categoryname.text;
                  _category.description = categorydescription.text;

                  var result = await _categoryservice.saveCategory(_category);
                  if (result! > 0) {
                    Navigator.of(context).pop();
                    getAllCategories();
                  }
                },
                child: const Text('Save')),
          ],
          title: const Text('Category Form'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: categoryname,
                  decoration: const InputDecoration(
                    labelText: 'Category Name ',
                    hintText: 'Write category name ',
                  ),
                ),
                TextField(
                  controller: categorydescription,
                  decoration: const InputDecoration(
                    labelText: 'category description ',
                    hintText: 'Write category description',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _editCategoryName(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel')),
            TextButton(
                onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = editcategoryname.text;
                  _category.description = editcategorydescription.text;

                  var result = await _categoryservice.updatecategory(_category);
                  if (result > 0) {
                    Navigator.of(context).pop();
                    getAllCategories();
                    _showSnackBar('Success');
                  }
                },
                child: const Text('Update')),
          ],
          title: const Text('Category Form'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: editcategoryname,
                  decoration: const InputDecoration(
                    labelText: 'Category Name ',
                    hintText: 'Write category name ',
                  ),
                ),
                TextField(
                  controller: editcategorydescription,
                  decoration: const InputDecoration(
                    labelText: 'category description ',
                    hintText: 'Write category description',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _deleteCategoryName(BuildContext context, categoryId) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {

                await _categoryservice.deletecategory(categoryId);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          title: const Text('Are you sure, you want to delete ?'),
         
        );
      },
    );
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryservice.getCategorybyId(categoryId);

    if (category != null && category.isNotEmpty) {
      setState(() {
        editcategoryname.text = category[0]['name'] ?? 'No Name';
        editcategorydescription.text =
            category[0]['description'] ?? 'No description';
      });

      _editCategoryName(context);
    } else {
      // Handle the case where the category is null or empty
      print('Category not found');
    }
  }

  _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.red,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Category '),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _editCategory(context, _categorylist[index].id);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_categorylist[index].name),
                  IconButton(onPressed: () {
                    _deleteCategoryName(context,_categorylist[index].id);
                  }, icon: const Icon(Icons.delete)),
                ],
              ),
            ),
          );
        },
        itemCount: _categorylist.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return _showFormInDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
