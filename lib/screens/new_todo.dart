import 'package:flutter/material.dart';
import 'package:todo_sqlite/services/category_service.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {

  var _newTitle = TextEditingController();
  var _newDescription = TextEditingController();

  var _selectedvalue;
  List<DropdownMenuItem> _categories = [];

  @override
  void initState(){
    super.initState();
    _loadCategories();
  }


  _loadCategories() async{
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    setState(() {
      _categories = categories.map<DropdownMenuItem>((category) {
        return DropdownMenuItem(
          value: category['name'],
          child: Text(category['name']),
        );
      }).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'Create Todo',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding:const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _newTitle,
              decoration:
                  const InputDecoration(labelText: 'Title', helperText: 'New title'),
            ),
            TextField(
              controller: _newDescription,
              decoration: const InputDecoration(
                  labelText: 'Description', helperText: 'New Description'),
            ),
            DropdownButtonFormField(
              hint:Text('Category'),
                value: _selectedvalue,
                items: _categories,
                onChanged: (value){
                  setState(() {
                    _selectedvalue = value;
                  });
                }
            ),
          ],
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 16,
        margin: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: (){},
          style: ButtonStyle(

              backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              )
          ),
          child: Text(
            'Create'
          ),
        ),
      ),

    );
  }
}
