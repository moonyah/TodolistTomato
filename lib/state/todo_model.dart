// import 'dart:collection';
//
// import 'package:flutter/cupertino.dart';
//
// import '../model/todo.dart';
//
// class TodoModel extends ChangeNotifier {
//   final List<Todo> _todos = [];
//
//   UnmodifiableListView<Todo> get todos =>
//       UnmodifiableListView(_todos);
//
//   void add(Todo todo) {
//     _todos.add(todo);
//     notifyListeners();
//   }
//
//   void toggleDone(int id) {
//     var index = _todos.indexWhere((element) => element.id == id);
//     _todos[index].isDone = !_todos[index].isDone;
//     notifyListeners();
//   }
//
//   void remove(int id) {
//     _todos.removeWhere((element) => element.id == id);
//     notifyListeners();
//   }
// }