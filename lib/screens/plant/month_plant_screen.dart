import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MonthPlant extends StatefulWidget {
  const MonthPlant({Key? key}) : super(key: key);

  @override
  State<MonthPlant> createState() => _MonthPlantState();
}

class _MonthPlantState extends State<MonthPlant>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          StreamBuilder(
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
                  return AppBar(
                      backgroundColor: Colors.white,
                      flexibleSpace: Stack(
                        children: [
                          Positioned(
                            top: 61,
                            right: 0,
                            left: 0,
                            child: Container(
                              height: 420,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage('assets/plant0${docs.length}.png'),
                                      scale: 0.9)),
                            ),
                          ),
                        ],
                      ));
                }
                return const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red)));
              })
        ]));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
