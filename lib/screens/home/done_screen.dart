import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../model/todo.dart';

class MyDone extends StatefulWidget {
  const MyDone({Key? key}) : super(key: key);

  @override
  State<MyDone> createState() => _MyDoneState();
}

class _MyDoneState extends State<MyDone> {
  List<Todo> items = List<Todo>.empty(growable: true); //growable: true

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("MyTodos")
            .where("completed", isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                return ListTile(
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
                  // 삭제버튼
                  title: Text(
                    (docs[index]['completed'] != true)
                        ? ''
                        : (docs[index]['todoTitle']),
                    style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.check_box,
                      color: Colors.grey,
                      key: Key('completed-icon-$index'),
                    ),
                    onPressed: () {},
                  ),
                  // 체크버튼
                );
              },
            );
          }
          return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red)));
        });
  }

  void removeItem(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(item);
    documentReference
        .delete()
        .whenComplete(() => debugPrint("deleted successfully!"));

    items.remove(item);
  }
}
