

import 'package:todo_sqlite/models/Category.dart';
import 'package:todo_sqlite/repositories/repository.dart';

class CategoryService{
  late Repository _repository;

  CategoryService(){
    _repository = Repository();
  }

  Future<int> saveCategory(Category category) async{
    return await _repository.insertData('Categories', category.categoryMap());
  }


  Future<List<Map<String, dynamic>>> readCategories() async{
    return await _repository.readData('Categories');
  }

  Future<Category> readCategoryById(int id) async{
    var result = await _repository.readDataById('Categories',id);

      var categoryMap = result.first;
      var category = new Category();
      category.name = categoryMap['name'];
      category.id = categoryMap['id'];
      category.description = categoryMap['description'];
      return category;

  }

  updateCategory(Category category) async{
    return await _repository.updateData('Categories',category.categoryMap());
  }

  deleteCategory(int categoryId) async{
    return await _repository.deleteData('Categories' , categoryId);
  }
}