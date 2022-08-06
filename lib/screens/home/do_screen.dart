import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_tomato/config/palette.dart';

import 'new_todo.dart';
import '../../model/todo.dart';

class MyDo extends StatefulWidget {
  const MyDo({Key? key}) : super(key: key);

  @override
  MyDoState createState() => MyDoState();
}

class MyDoState extends State<MyDo> with AutomaticKeepAliveClientMixin {
  List<Todo> items = List<Todo>.empty(growable: true); //growable: true
  //GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  //late AnimationController emptyListController;

  @override
  void initState() {
    // emptyListController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 200),
    // );
    // emptyListController.forward();
    super.initState();
  }

  @override
  void dispose() {
    //emptyListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.mainColor,
          child: const Icon(Icons.add),
          onPressed: () => goToNewItemView(),
        ),
        body: buildListView() );
  }

  // Widget renderBody() {
  //   if (items.isNotEmpty) {
  //     return buildListView();
  //   } else {
  //     return emptyList();
  //   }
  // }

  Widget emptyList() {
    return const Center(child: Text('이 곳에 할 일을 추가하세요')
        // child: FadeTransition(
        //     opacity: emptyListController,
        //     child: const Text('이 곳에 할 일을 추가하세요')
        // )
        );
  }

  Widget buildListView() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("MyTodos").orderBy('timeStamp', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          //(context, snapshot)
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              //AnimatedList
              //key: animatedListKey,
              //initialItemCount: items.length,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return
                  ListTile(
                      leading: IconButton(
                        // 삭제 버튼
                        icon: const Icon(
                          Icons.delete,
                          color: Palette.mainColor,
                        ),
                        onPressed: () {
                          setState(() {
                            removeItem((docs[index]['todoTitle'] != null)
                                ? (docs[index]['todoTitle'])
                                : "");
                          });
                        },
                      ),
                  title : Text(
                      (docs[index]['todoTitle'] != null)
                               ? (docs[index]['todoTitle'])
                               : "",
                style: TextStyle(
                        color:
                        docs[index]['completed'] ? Colors.grey : Colors.black,
                        decoration: docs[index]['completed']
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                    trailing: IconButton(
                      icon: Icon(
                        docs[index]['completed']
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Palette.mainColor,
                        key: Key('completed-icon-$index'),
                      ),
                      onPressed: () { // 바뀌는 거 넣기
                        docs[index]['completed'] ?
                        changeItemFalse(docs[index]['todoTitle']) : changeItemTrue(docs[index]['todoTitle']);
                      },
                    ),

                // 데이터 접근해보자
                );
                    //   Container(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(docs[index]['todoTitle']),
                    // );
                    //Dismissible(
                    //key: Key(index.toString()),
                    //key: Key('${documentSnapshot?["todoTitle"].hashCode}'),
                    //background: Container(color: Palette.mainColor),
                    //onDismissed: (direction) => removeItem,
                    //direction: DismissDirection.startToEnd,
                //     ListTile(
                //   leading: IconButton(
                //     // 삭제 버튼
                //     icon: const Icon(
                //       Icons.delete,
                //       color: Palette.mainColor,
                //     ),
                //     onPressed: () {
                //       setState(() {
                //         removeItem((docs[index]['todoTitle'] != null)
                //             ? (docs[index]['todoTitle'])
                //             : "");
                //       });
                //     },
                //   ),
                //   //onTap: () => changeItemCompleteness(items[index]),
                //   //onLongPress: () => goToEditItemView(items[index]),
                //   title: Text(
                //     (docs[index]['todoTitle'] != null)
                //         ? (docs[index]['todoTitle'])
                //         : "",
                //     key: Key(index.toString()), //'item-$index'
                //     style: TextStyle(
                //         color:
                //             items[index].completed ? Colors.grey : Colors.black,
                //         decoration: items[index].completed
                //             ? TextDecoration.lineThrough
                //             : null),
                //   ),
                //
                //   trailing: IconButton(
                //     icon: Icon(
                //       items[index].completed
                //           ? Icons.check_box
                //           : Icons.check_box_outline_blank,
                //       color: Palette.mainColor,
                //       key: Key('completed-icon-$index'),
                //     ),
                //     onPressed: () {
                //       changeItemCompleteness(items[index]);
                //     },
                //   ),
                // );
              },
            );
          }
          return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red)));
        });
  }

  void changeItemTrue(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(item);
    documentReference
        .update({"completed" : true})
        .whenComplete(() => debugPrint("changed successfully!")); //print

    // setState(() {
    //   item.completed = !item.completed;
    // });
  }
  void changeItemFalse(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(item);
    documentReference
        .update({"completed" : false})
        .whenComplete(() => debugPrint("changed successfully!"));

    // setState(() {
    //   item.completed = !item.completed;
    // });
  }

  void goToNewItemView() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewTodoView(
        item: Todo(title: ''),
      );
    })).then((title) {
      if (title != null) {
        setState(() {
          addItem(Todo(title: title));
        });
      }
    });
  }

  void addItem(Todo item) {
    // Insert an item into the top of our list, on index zero
    items.insert(0, item);
    // if (animatedListKey.currentState != null) {
    //   animatedListKey.currentState!.insertItem(0);
    // }
  }

  void goToEditItemView(Todo item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewTodoView(item: item);
    })).then((title) {
      if (title != null) {
        editItem(item, title);
      }
    });
  }

  void editItem(Todo item, String title) {
    item.title = title;
  }

  void removeItem(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(item);
    documentReference
        .delete()
        .whenComplete(() => debugPrint("deleted successfully!"));

    items.remove(item);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

// void deleteItem(item) {
//   DocumentReference documentReference = FirebaseFirestore.instance.collection("My Todos").doc(item);
//   documentReference.delete().whenComplete(() => print("deleted successfully!"));
//
//   items.remove(item);
//   if (items.isEmpty) {
//     emptyListController.reset();
//     setState(() {});
//     emptyListController.forward();
//   }
// }
}
