import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/utils/todo_list.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    final _controller = TextEditingController();

    // List<dynamic> toDoList = [];

    List toDoList = [
      ['Sweet', false],
      ['Sweet2', true],
      ['Sweet3', false],
    ];

   void fetchData() async {
     const url = 'https://httpbin.org/get';
     final uri = Uri.parse(url);
     final response = await http.get(uri);
     final body = response.body;
     final json = jsonDecode(body);

     // setState(() {
     //   toDoList = json['data'];
     // });

     print(json);
   }


   void ChackboxChange(int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
   }
   void saveNewTask(){
     setState(() {
       toDoList.add([_controller.text, false]);
       _controller.clear();
     });
   }

   void deleteTask(int index){
     setState(() {
       toDoList.removeAt(index);
     });
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(title: const Text('Todo App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(itemCount: toDoList.length ,itemBuilder: (BuildContext context, index){
        return Todolist(
            taskName : toDoList[index][0],
            tackCompleted: toDoList[index][1],
            onChanged: (value) => ChackboxChange(index),
            deleteFunction: (contex) =>  deleteTask(index),
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Add new ToDO Item",
                      filled: true,
                      fillColor: Colors.deepPurple.shade200,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                  ),
                )
            ),
            FloatingActionButton(
              // onPressed: saveNewTask,
              onPressed: fetchData,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );

  }
}
