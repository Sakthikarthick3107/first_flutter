import 'package:flutter/material.dart';
import 'package:todo_sqlite/helpers/drawer_navigation.dart';
import 'package:todo_sqlite/models/Category.dart';
import 'package:todo_sqlite/screens/home_screen.dart';
import 'package:todo_sqlite/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _category = TextEditingController();
  var _description = TextEditingController();
  var _editcategory = TextEditingController();
  var _editdescription = TextEditingController();

  var category = Category();
  var categoryService = CategoryService();

  List<Category> _categorylist = [];

  @override
  void initState() {
    super.initState();
    categoryService = CategoryService();

    loadCategories();
  }



  _showSuccessSnackBar(String message){
    var snackBar = SnackBar(
        content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,


    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> loadCategories() async {
    try {
      var categories = await categoryService.readCategories();
      setState(() {
        _categorylist.clear();
        for (var categoryMap in categories) {
          var categoryModel = Category();
          categoryModel.name = categoryMap['name'];
          categoryModel.description = categoryMap['description'];
          categoryModel.id = categoryMap['id'];
          _categorylist.add(categoryModel);
        }
      });
    } catch (e) {
      print('Error fetching categories');
    }
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text(
              'Category Form',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                  )),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      category.name = _category.text;
                      category.description = _description.text;
                      categoryService.saveCategory(category);
                      _category.text = '';
                      _description.text = '';
                    });
                    Navigator.pop(context);
                    loadCategories();
                    print(category.name);
                  },
                  child: const Text(
                    'Create',
                  ))
            ],
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _category,
                    decoration: const InputDecoration(
                        hintText: 'Write a category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _description,
                    decoration: const InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _editCategory(BuildContext context , int id) async{
    category = await categoryService.readCategoryById(id);
    setState(() {
      _editcategory.text = category.name ?? 'No name';
      _editdescription.text = category.description ?? 'No description';
    });
    _editFormDialog(context);
  }



  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text(
              'Edit Category',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                  )),
              TextButton(
                  onPressed: ()async  {
                    setState((){
                      category.id = category.id;
                      category.name = _editcategory.text;
                      category.description = _editdescription.text;

                      _category.text = '';
                      _description.text = '';
                    });
                    await categoryService.updateCategory(category);

                    Navigator.pop(context);
                    loadCategories();
                    _showSuccessSnackBar('Edited successfully');
                  },
                  child: const Text(
                    'Update',
                  ))
            ],
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editcategory,
                    decoration: const InputDecoration(
                        hintText: 'Edit category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _editdescription,
                    decoration: const InputDecoration(
                        hintText: 'Edit description',
                        labelText: 'Description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context , int categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text(
              'Are you sure to delete this category?',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                  )),
              TextButton(
                  onPressed: ()async  {

                    await categoryService.deleteCategory(categoryId);

                    Navigator.pop(context);
                    loadCategories();
                    _showSuccessSnackBar('Deleted successfully');
                  },
                  child: const Text(
                    'Delete',
                  ))
            ],

          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //
        //   onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen())),
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        // ),
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'Categories',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: _categorylist.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    _editCategory(context , _categorylist[index].id!);
                  },
                  icon:const Icon(Icons.edit),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _categorylist[index].name!,
                      style:const TextStyle(fontSize: 25),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteFormDialog(context , _categorylist[index].id!);
                      },
                      icon:const Icon(Icons.delete),
                      color: Colors.red,
                    )
                  ],
                ),
                subtitle: Text(_categorylist[index].description!),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        elevation: 20,
        child: const Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
