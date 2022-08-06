import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_tomato/config/palette.dart';
import '../../model/todo.dart';

class NewTodoView extends StatefulWidget {
  final Todo item; //completed도 있을 듯

  const NewTodoView({ required this.item });

  @override
  _NewTodoViewState createState() => _NewTodoViewState();
}

class _NewTodoViewState extends State<NewTodoView> {
  late TextEditingController titleController;

  @override
  void initState() {
    //super.initState();
    titleController = TextEditingController(
        text: widget.item.title
    );
    widget.item.completed=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.item.title != '' ? 'Edit todo' : '할 일 추가',
      //     key: const Key('new-item-title'),
      //   ),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: titleController,
              autofocus: true,
              onEditingComplete: submit,
              decoration: const InputDecoration(
              //labelText: '할 일 추가',
              hintText: '할 일을 입력하세요',
              //labelStyle: TextStyle(color: Colors.black87),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.black54)
              ),
              ),
            ),
            const SizedBox(height: 14.0,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Palette.mainColor, // background
                onPrimary: Colors.white, // foreground
              ),
              child: const Text(
                '저장',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: submit,
            ),
          ],
        ),
      ),
    );
  }

  void submit(){
    if(titleController.text != '') {
      Navigator.of(context).pop(titleController.text);
      DocumentReference documentReference = FirebaseFirestore.instance.collection("MyTodos").doc(titleController.text);

      Map<String, dynamic> todoList = {
        "todoTitle": titleController.text,
        "completed" : false,
        "timeStamp" : Timestamp.now()
      };

      documentReference.set(todoList).whenComplete(() => debugPrint("Data stored successfully"));
    }
  }

}